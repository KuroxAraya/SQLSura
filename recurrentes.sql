;WITH CTE AS (
    SELECT RUT_DV,CAST(INI AS DATETIME) AS INI, CAST(FIN AS DATETIME) AS FIN,
        RN_COL = ROW_NUMBER() OVER (PARTITION BY RUT_DV ORDER BY INI, FIN),
        RN_REG = COUNT(*) OVER (PARTITION BY RUT_DV)
    FROM ausentismoT
    WHERE NOM_INC LIKE 'LICENCIA%' 
    AND ULT_ACT = 20190509
)
, CTE2 AS (
    SELECT T.*,
        DDTOT = 
        CASE 
            WHEN DATEDIFF(DAY, T.INI, T.FIN) < 0 THEN NULL -- CÁLCULO REVERSO
            ELSE DATEDIFF(DAY, T.INI, T.FIN) 
        END,
        DDPREVREG = 
        CASE
            WHEN T.RN_COL = 1 THEN 0 -- PRIMER REGISTRO (MÁS ANTIGUO)
            WHEN DATEADD(DAY, 1, rANTE.FIN) = T.INI THEN 0 -- UN DÍA DE DISTANCIA ESTÁ PERMITIDO
            WHEN DATEADD(DAY, 2, rANTE.FIN) = T.INI THEN 0 -- DOS DÍAS DE DISTANCIA ESTÁ PERMITIDO
            WHEN DATEADD(DAY, 3, rANTE.FIN) = T.INI THEN 0 -- DOS DÍAS DE DISTANCIA ESTÁ PERMITIDO
            ELSE DATEDIFF(DAY, rANTE.FIN, T.INI) 
        END,
        rANTE.INI AS INI_ANTE, rANTE.FIN AS FIN_ANTE
    FROM CTE T
    LEFT JOIN CTE rANTE ON T.RUT_DV = rANTE.RUT_DV AND rANTE.RN_COL = (T.RN_COL - 1)
    --LEFT JOIN CTE rSIG ON T.RUT_DV = rSIG.RUT_DV AND rSIG.RN_COL = (T.RN_COL + 1) 
)
, CTE3 AS (
    SELECT RUT_DV, /*MIN(CAST(INI AS DATETIME)) AS MAXINI,*/ MAX(CAST(FIN AS DATETIME)) AS MAXFIN,
        D_DIF = SUM(DDPREVREG), -- DIAS DE DISTANCIA TOTALES
        DDTOT = SUM(DDTOT),
        NUM_LIC = MAX(RN_REG), -- TOTAL REGISTROS
        licSinEsp = COUNT(CASE WHEN DDPREVREG = 0 THEN RUT_DV ELSE NULL END),
        licConEsp = COUNT(NULLIF(DDPREVREG, 0)),
        -- SI HAY LICENCIAS CON FECHAS NULL
        ERROR = COUNT(CASE WHEN DDTOT IS NULL THEN RUT_DV ELSE NULL END)
    FROM CTE2
    GROUP BY RUT_DV
) -- SELECT * FROM CTE3
, CTE4 AS (
	SELECT RUT_DV,CONVERT(NVARCHAR(10),MAXFIN,103) AS MAXFIN,
        D_DIF,DDTOT,NUM_LIC,licSinEsp,licConEsp,ERROR
	FROM CTE3
	GROUP BY RUT_DV,MAXFIN,D_DIF,DDTOT,NUM_LIC,licSinEsp,licConEsp,ERROR
	HAVING GETDATE() <= MAXFIN
)
    SELECT T.RUT_DV, T2.INI AS MININI,MAXFIN,LICSINESP,LICCONESP,ERROR,
        ALERTA = (CASE --WHEN licConEsp = 0 AND GETDATE() BETWEEN MAXINI AND MAXFIN THEN 'EN CURSO'
						WHEN licSinEsp > 0 /*AND GETDATE() BETWEEN MAXINI AND MAXFIN*/ THEN 'LICENCIA CONT' 
                        WHEN D_DIF <= 1 THEN 'EN CURSO' END)
    FROM CTE4 T
    LEFT JOIN (SELECT TOP 1 * FROM CTE T2)
    ON RUT_DV = RUT_DV ORDER BY RN_COL DESC
    --CTE T2 ON T.RUT_DV = T2.RUT_DV AND RN_COL = RN_COL - T.licConEsp









-----
-----
SELECT RUT_DV, INI, FIN, DIAS_DUR, NOM_INC
FROM ausentismoT 
WHERE RUT_DV='10912431-1' 
    AND NOM_INC LIKE 'LIC%' 
    AND ULT_ACT = 20190509
    ORDER BY CAST(INI AS [datetime])
    --NVA QUERY
-----
-----
SELECT * FROM cargaGeneral WHERE RUT_DV='CL_17739' AND NOM_INC LIKE 'LIC%' ORDER BY INI
SELECT * FROM cargaGeneral WHERE RUT_DV='CL_21058' AND NOM_INC LIKE 'LIC%' ORDER BY INI
SELECT * FROM cargaGeneral WHERE RUT_DV='CL_22142' AND NOM_INC LIKE 'LIC%' ORDER BY INI
------
SELECT DATEADD(DD,-84,CAST('31/12/2018' AS DATETIME))
SELECT DATEDIFF(DD,CAST('26/10/2017' AS [datetime]),CAST('24/05/2019' AS [datetime]))
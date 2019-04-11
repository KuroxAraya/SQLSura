SET DATEFORMAT DMY
;
WITH
    CTE
    AS
    (
        SELECT T1.STD_ID_HR, T1.ESTADO, T1.RUT_DV, T1.SCO_GB_NAME,
            T3.JEFE_DIRECTO, T2.AGR_CAR, T2.NOM_CAR, T2.NOM_UBI,
            SUM(T4.DIAS_DUR) AS DIAS_USADOS,--DIAS DURACION DESDE HISTORICOVAC
            T5.[Dias base], T5.[Pendientes Legales], T5.[Pendientes Progresivos],
            T3.VP, T3.AREA, T2.TIPO_GAS, T3.ROL
        FROM FG_SALDO_VAC AS T1
            LEFT JOIN CENTTALENTUM AS T2 ON REPLACE(T2.RUT,'.','') = T1.RUT_DV
            LEFT JOIN CENTM4 AS T3 ON RIGHT('0000000000'+ISNULL(T3.RUT_DV,''),10) = T1.RUT_DV
            LEFT JOIN HISTORICOVAC AS T4 ON RIGHT('0000000000'+ISNULL(T4.RUT,''),10) = T1.RUT_DV
            LEFT JOIN SDO_VAC_MAS AS T5 ON RIGHT('0000000000'+ISNULL(T5.[RUT],''),10) = T1.RUT_DV
        WHERE T4.INI > CAST('31/12/2018' AS DATETIME)
            AND T4.NOM_INC LIKE 'VACACION%'
            AND T2.TIPO_GAS = 'VENTA'
        GROUP BY T1.STD_ID_HR, T1.ESTADO, T1.RUT_DV, T1.SCO_GB_NAME, T3.JEFE_DIRECTO, T2.AGR_CAR, T2.NOM_CAR, T2.NOM_NOR2, T5.[Dias base],
                 T5.[Pendientes Legales], T5.[Pendientes Progresivos], T3.VP, T3.AREA, T3.ROL, T2.TIPO_GAS, T2.NOM_UBI
        --HAVING T4.INI < CAST('30/11/2018' AS DATETIME)
    ),
    CTE2
    AS

    (
        SELECT STD_ID_HR, ESTADO, RUT_DV, SCO_GB_NAME,
            --JEF_IND,
            JEFE_DIRECTO, AGR_CAR, NOM_CAR, NOM_UBI, TIPO_GAS,
            DIAS_USADOS,--DIAS DURACION DESDE HISTORICOVAC
            [Dias base] AS DIAS_BASE, [Pendientes Legales] AS PEND_LEG, [Pendientes Progresivos] AS PEND_PROG,
            PROY_VAC_LEG = CAST(CAST([Dias base] AS FLOAT) / CAST(365 AS FLOAT) * CAST(datediff(DD,getdate(),CAST('31/03/2019' AS [datetime])) AS FLOAT) + [Pendientes Legales] AS INT),
            DIAS_REBAJA = CAST([Dias base] - CAST(CAST([Dias base] AS FLOAT) / CAST(365 AS FLOAT) * CAST(datediff(DD,getdate(),CAST('31/03/2019' AS [datetime])) AS FLOAT) + [Pendientes Legales] AS FLOAT) AS INT),
            VP, AREA
        FROM CTE
    )
SELECT STD_ID_HR, ESTADO, RUT_DV, SCO_GB_NAME,
    JEFE_DIRECTO,
    AGR_CAR, NOM_CAR, NOM_UBI, TIPO_GAS,
    DIAS_USADOS,
    [DIAS_BASE], [PEND_LEG], [PEND_PROG],
    PROY_VAC_LEG,
    (CASE WHEN DIAS_REBAJA <= 0 THEN 0
            WHEN DIAS_REBAJA >= 0 THEN DIAS_REBAJA END) AS 'DIAS_REBAJA',
    --INDICADOR, --CONDICIONAL EN BASE A DIAS A REBAJAR
    (CASE WHEN DIAS_REBAJA >= 10 THEN 'URGENTE'
            WHEN DIAS_REBAJA BETWEEN 5 AND 9 THEN 'MEDIO'
            WHEN DIAS_REBAJA < 5 THEN 'BAJO' END) AS 'INDICADOR',
    VP, AREA
FROM CTE2
WHERE ESTADO = 'ACTIVO'
ORDER BY DIAS_REBAJA
--INFORME MENSUAL PATO VERGARA
--VALIDAR LA CANTIDAD MÁXIMA DE PERMISOS HECHAS POR LOS COLABORADORES SOLICITADOS CON ESTA QUERY
--PARA LICENCIAS
;WITH CTE AS (
    SELECT PER_PRO,RUT_DV, RN = row_number()OVER (partition BY RUT_DV,PER_PRO order BY PER_PRO)
    FROM INF_LIC
)
SELECT * FROM CTE WHERE PER_PRO = 201903 ORDER BY RN DESC
--PARA VACACIONES
;WITH CTE AS (
    SELECT PER_PRO,RUT_DV, RN = row_number()OVER (partition BY RUT_DV,PER_PRO order BY PER_PRO)
    FROM INF_VAC
    WHERE NOM_INC LIKE '%VACACION%'
)
SELECT * FROM CTE WHERE PER_PRO = 201903 ORDER BY RN DESC
--PARA PERMISOS
;WITH CTE AS (
    SELECT PER_PRO,RUT_DV, RN = row_number()OVER (partition BY RUT_DV,PER_PRO order BY PER_PRO)
    FROM INF_VAC
    WHERE NOM_INC LIKE 'PERMISO%'
)
SELECT * FROM CTE WHERE PER_PRO = 201903 ORDER BY RN DESC

-- VALIDAR LA SI EXISTEN POST/PRE-NATALES EN RUT ENTREGADOS (SOLO LICENCIAS)
SELECT RUT_DV,NOM_INC 
FROM INF_LIC
WHERE NOM_INC LIKE '%NATAL%'
AND PER_PRO = 201903
AND RUT_DV in ('14583018-4','09795373-2','16079247-7','15329692-8','13495643-7','18222448-0','17384694-0','16571139-4','16276948-0',
'12634552-6','07005871-5','06396907-9','07516170-0','06282282-1','11856595-9','14550473-2','19236575-9','12608431-5','16653561-1',
'17227086-7','17608978-4','11190833-8','14144005-5','16339480-4','14285285-3','11848392-8','12239061-6','16661805-3','18099850-0',
'16070401-2','16457538-1','15918134-0','10647128-2','16361408-1','13851347-5','16478471-1','16857752-4','17253800-2','15739567-K',
'15543970-K','09868914-1','16790428-9','18635125-8','18338932-7','15940152-9','14159592-k','08242978-6','16610008-9','15536596-K',
'11847860-6','06373995-2','10999674-2','08186739-9','16125801-6','09401298-8','15580169-7','17478775-1','17418119-5','14597049-0',
'16795522-3','16691891-K','15754902-2','08117660-4','13715965-1','08774140-0','15373933-1','11824524-5','12865355-4','10325077-3',
'15438950-4','09478007-1','08344456-8','17575545-4','11948679-3','12474251-K','11548807-4','11872204-3','14198677-5','16922232-0',
'17054800-0','16090906-4','25223558-2','12500537-3','10551340-2','15837677-6','06594417-0','09654671-8','10567673-5','13907838-1',
'09979896-3','15634786-8','09031276-6','13767427-0','18172461-7','17602556-5','11479542-9','16193116-0','16923678-k','18022767-9',
'08404622-1','16123501-6','10225221-7','13029329-8','14138474-0','13052862-7','12833817-9','18083910-0','18748051-5','14448134-8',
'15336630-6','13302127-2','14270107-3','17097806-4','09159496-k','11482230-2','12410556-0','13672266-2','13715502-8','14137700-0',
'13271252-2','06618014-K','10723345-8','11753565-7','06557525-6','18613894-5','15424657-6','14149834-7','14506645-k','14156920-1',
'14152643-K','09805210-0','11653149-6','16115770-8','16405870-0','08039984-7','09818257-8','08317301-7','14183950-0','05746982-K',
'13930070-K','08029844-7','08788677-8','08087538-K','13351801-0','18695310-k','12506100-1','12585349-8','12113891-3','06342822-1',
'18406332-8','16976669-K','15689022-7','18326721-3','16069062-3','08112422-1','17049977-8','15045565-0','10123000-7','07004149-9',
'17433656-3','17735812-6','11211103-4','13212265-2','17656827-5','17093420-2','18182530-8','08906606-9','07792600-3','15491079-4',
'16838845-4','11135170-8','10725207-K','07882436-0','16535318-8','09685332-7','10743357-0','10731371-0','07876933-5','18504542-0',
'16328330-1','07241391-1','08617084-1','15611825-7','10357657-1','10294868-8','10828762-4','17157470-6','17883588-2','17442887-5',
'16928285-4','12438218-1','18006472-9','08053795-6','19178803-6','08502779-4','07482696-2','13364860-7','17688522-K','10104349-5',
'08678890-K','15969432-1','13018114-7','11719892-8','13145662-K','11793691-0','13136176-9','09450382-5','17466736-5','09281317-7',
'18239368-1','10300337-7','06515890-6','18267022-7','10130960-6','12765142-6','09716293-K','09763806-3','18328687-0','18334624-5',
'12291455-0','11553572-2','10755332-0','16448083-6','09552994-1','16200336-4','06895112-7','09229125-1','09169997-4','13208016-K',
'06515053-0','11675643-9','13952957-K','10029003-0','12194803-6','10741363-4','09235966-2','15232556-8','17501717-8','17915858-2',
'17260827-2','12751183-7','13520671-7','11592465-6','12939894-9','15655984-9','16759478-6','12626112-8','07964299-1','08980275-K',
'07875969-0','16799807-0','16700668-K','10329095-3','17210805-9','11398579-8','19775146-0','15560394-1','09645721-9'
) 
-- QUERY PARA LICENCIAS
;WITH CTE AS(
   SELECT PER_PRO, ID_HR, NOM_INC, rut_dv, dias_durAC, INI, FIN,
       ROW_NUMBER()OVER(PARTITION BY ID_HR ORDER BY ULT_ACT) AS RN
   FROM dbo.INF_LIC WHERE PER_PRO = 201903
)
SELECT ID_HR,rut_dv,NOM_INC,
       max(case when rn = 1 then DIAS_DURAC end) as DIAS_DUR1,
       max(case when rn = 1 then INI end) as INI1,
       max(case when rn = 1 then FIN end) as FIN1,

       max(case when rn = 2 then DIAS_DURAC end) as DIAS_DUR2,
       max(case when rn = 2 then INI end) as INI2,
       max(case when rn = 2 then FIN end) as FIN2,

       max(case when rn = 3 then DIAS_DURAC end) as DIAS_DUR3,
       max(case when rn = 3 then INI end) as INI3,
       max(case when rn = 3 then FIN end) as FIN3--,
       
       --max(case when rn = 4 then DIAS_DURAC end) as DIAS_DUR4,
       --max(case when rn = 4 then INI end) as INI4,
       --max(case when rn = 4 then FIN end) as FIN4
FROM CTE
WHERE RUT_DV IN ('14583018-4','09795373-2','16079247-7','15329692-8','13495643-7','18222448-0','17384694-0','16571139-4','16276948-0',
'12634552-6','07005871-5','06396907-9','07516170-0','06282282-1','11856595-9','14550473-2','19236575-9','12608431-5','16653561-1',
'17227086-7','17608978-4','11190833-8','14144005-5','16339480-4','14285285-3','11848392-8','12239061-6','16661805-3','18099850-0',
'16070401-2','16457538-1','15918134-0','10647128-2','16361408-1','13851347-5','16478471-1','16857752-4','17253800-2','15739567-K',
'15543970-K','09868914-1','16790428-9','18635125-8','18338932-7','15940152-9','14159592-k','08242978-6','16610008-9','15536596-K',
'11847860-6','06373995-2','10999674-2','08186739-9','16125801-6','09401298-8','15580169-7','17478775-1','17418119-5','14597049-0',
'16795522-3','16691891-K','15754902-2','08117660-4','13715965-1','08774140-0','15373933-1','11824524-5','12865355-4','10325077-3',
'15438950-4','09478007-1','08344456-8','17575545-4','11948679-3','12474251-K','11548807-4','11872204-3','14198677-5','16922232-0',
'17054800-0','16090906-4','25223558-2','12500537-3','10551340-2','15837677-6','06594417-0','09654671-8','10567673-5','13907838-1',
'09979896-3','15634786-8','09031276-6','13767427-0','18172461-7','17602556-5','11479542-9','16193116-0','16923678-k','18022767-9',
'08404622-1','16123501-6','10225221-7','13029329-8','14138474-0','13052862-7','12833817-9','18083910-0','18748051-5','14448134-8',
'15336630-6','13302127-2','14270107-3','17097806-4','09159496-k','11482230-2','12410556-0','13672266-2','13715502-8','14137700-0',
'13271252-2','06618014-K','10723345-8','11753565-7','06557525-6','18613894-5','15424657-6','14149834-7','14506645-k','14156920-1',
'14152643-K','09805210-0','11653149-6','16115770-8','16405870-0','08039984-7','09818257-8','08317301-7','14183950-0','05746982-K',
'13930070-K','08029844-7','08788677-8','08087538-K','13351801-0','18695310-k','12506100-1','12585349-8','12113891-3','06342822-1',
'18406332-8','16976669-K','15689022-7','18326721-3','16069062-3','08112422-1','17049977-8','15045565-0','10123000-7','07004149-9',
'17433656-3','17735812-6','11211103-4','13212265-2','17656827-5','17093420-2','18182530-8','08906606-9','07792600-3','15491079-4',
'16838845-4','11135170-8','10725207-K','07882436-0','16535318-8','09685332-7','10743357-0','10731371-0','07876933-5','18504542-0',
'16328330-1','07241391-1','08617084-1','15611825-7','10357657-1','10294868-8','10828762-4','17157470-6','17883588-2','17442887-5',
'16928285-4','12438218-1','18006472-9','08053795-6','19178803-6','08502779-4','07482696-2','13364860-7','17688522-K','10104349-5',
'08678890-K','15969432-1','13018114-7','11719892-8','13145662-K','11793691-0','13136176-9','09450382-5','17466736-5','09281317-7',
'18239368-1','10300337-7','06515890-6','18267022-7','10130960-6','12765142-6','09716293-K','09763806-3','18328687-0','18334624-5',
'12291455-0','11553572-2','10755332-0','16448083-6','09552994-1','16200336-4','06895112-7','09229125-1','09169997-4','13208016-K',
'06515053-0','11675643-9','13952957-K','10029003-0','12194803-6','10741363-4','09235966-2','15232556-8','17501717-8','17915858-2',
'17260827-2','12751183-7','13520671-7','11592465-6','12939894-9','15655984-9','16759478-6','12626112-8','07964299-1','08980275-K',
'07875969-0','16799807-0','16700668-K','10329095-3','17210805-9','11398579-8','19775146-0','15560394-1','09645721-9')
GROUP BY ID_HR,RUT_DV, NOM_INC
ORDER BY RUT_DV;

-- QUERY PARA VACACIONES
;WITH CTE AS(
   SELECT PER_PRO, ID_HR, NOM_INC, rut_dv, DIAS_DUR, INI, FIN,
       ROW_NUMBER()OVER(PARTITION BY ID_HR ORDER BY SUBIDO) AS RN
   FROM dbo.INF_VAC WHERE PER_PRO = 201903 AND NOM_INC LIKE '%VACACION%'
)
SELECT ID_HR,RUT_DV,NOM_INC,
       max(case when rn = 1 then DIAS_DUR end) as DIAS_DUR1,
       max(case when rn = 1 then INI end) as INI1,
       max(case when rn = 1 then FIN end) as FIN1,

       max(case when rn = 2 then DIAS_DUR end) as DIAS_DUR2,
       max(case when rn = 2 then INI end) as INI2,
       max(case when rn = 2 then FIN end) as FIN2,

       max(case when rn = 3 then DIAS_DUR end) as DIAS_DUR3,
       max(case when rn = 3 then INI end) as INI3,
       max(case when rn = 3 then FIN end) as FIN3,
       
       max(case when rn = 4 then DIAS_DUR end) as DIAS_DUR4,
       max(case when rn = 4 then INI end) as INI4,
       max(case when rn = 4 then FIN end) as FIN4
FROM CTE
WHERE RUT_DV IN ('14583018-4','09795373-2','16079247-7','15329692-8','13495643-7','18222448-0','17384694-0','16571139-4','16276948-0',
'12634552-6','07005871-5','06396907-9','07516170-0','06282282-1','11856595-9','14550473-2','19236575-9','12608431-5','16653561-1',
'17227086-7','17608978-4','11190833-8','14144005-5','16339480-4','14285285-3','11848392-8','12239061-6','16661805-3','18099850-0',
'16070401-2','16457538-1','15918134-0','10647128-2','16361408-1','13851347-5','16478471-1','16857752-4','17253800-2','15739567-K',
'15543970-K','09868914-1','16790428-9','18635125-8','18338932-7','15940152-9','14159592-k','08242978-6','16610008-9','15536596-K',
'11847860-6','06373995-2','10999674-2','08186739-9','16125801-6','09401298-8','15580169-7','17478775-1','17418119-5','14597049-0',
'16795522-3','16691891-K','15754902-2','08117660-4','13715965-1','08774140-0','15373933-1','11824524-5','12865355-4','10325077-3',
'15438950-4','09478007-1','08344456-8','17575545-4','11948679-3','12474251-K','11548807-4','11872204-3','14198677-5','16922232-0',
'17054800-0','16090906-4','25223558-2','12500537-3','10551340-2','15837677-6','06594417-0','09654671-8','10567673-5','13907838-1',
'09979896-3','15634786-8','09031276-6','13767427-0','18172461-7','17602556-5','11479542-9','16193116-0','16923678-k','18022767-9',
'08404622-1','16123501-6','10225221-7','13029329-8','14138474-0','13052862-7','12833817-9','18083910-0','18748051-5','14448134-8',
'15336630-6','13302127-2','14270107-3','17097806-4','09159496-k','11482230-2','12410556-0','13672266-2','13715502-8','14137700-0',
'13271252-2','06618014-K','10723345-8','11753565-7','06557525-6','18613894-5','15424657-6','14149834-7','14506645-k','14156920-1',
'14152643-K','09805210-0','11653149-6','16115770-8','16405870-0','08039984-7','09818257-8','08317301-7','14183950-0','05746982-K',
'13930070-K','08029844-7','08788677-8','08087538-K','13351801-0','18695310-k','12506100-1','12585349-8','12113891-3','06342822-1',
'18406332-8','16976669-K','15689022-7','18326721-3','16069062-3','08112422-1','17049977-8','15045565-0','10123000-7','07004149-9',
'17433656-3','17735812-6','11211103-4','13212265-2','17656827-5','17093420-2','18182530-8','08906606-9','07792600-3','15491079-4',
'16838845-4','11135170-8','10725207-K','07882436-0','16535318-8','09685332-7','10743357-0','10731371-0','07876933-5','18504542-0',
'16328330-1','07241391-1','08617084-1','15611825-7','10357657-1','10294868-8','10828762-4','17157470-6','17883588-2','17442887-5',
'16928285-4','12438218-1','18006472-9','08053795-6','19178803-6','08502779-4','07482696-2','13364860-7','17688522-K','10104349-5',
'08678890-K','15969432-1','13018114-7','11719892-8','13145662-K','11793691-0','13136176-9','09450382-5','17466736-5','09281317-7',
'18239368-1','10300337-7','06515890-6','18267022-7','10130960-6','12765142-6','09716293-K','09763806-3','18328687-0','18334624-5',
'12291455-0','11553572-2','10755332-0','16448083-6','09552994-1','16200336-4','06895112-7','09229125-1','09169997-4','13208016-K',
'06515053-0','11675643-9','13952957-K','10029003-0','12194803-6','10741363-4','09235966-2','15232556-8','17501717-8','17915858-2',
'17260827-2','12751183-7','13520671-7','11592465-6','12939894-9','15655984-9','16759478-6','12626112-8','07964299-1','08980275-K',
'07875969-0','16799807-0','16700668-K','10329095-3','17210805-9','11398579-8','19775146-0','15560394-1','09645721-9')
GROUP BY ID_HR,RUT_DV, NOM_INC
ORDER BY RUT_DV;

--QUERY PARA PERMISOS
;WITH CTE AS(
   SELECT PER_PRO, ID_HR, NOM_INC, rut_dv, DIAS_DUR, INI, FIN,
       ROW_NUMBER()OVER(PARTITION BY ID_HR ORDER BY SUBIDO) AS RN
   FROM dbo.INF_VAC WHERE PER_PRO = 201903 AND NOM_INC LIKE 'PERMISO%'
)
SELECT ID_HR,RUT_DV,NOM_INC,
       max(case when rn = 1 then DIAS_DUR end) as DIAS_DUR1,
       max(case when rn = 1 then INI end) as INI1,
       max(case when rn = 1 then FIN end) as FIN1,

       max(case when rn = 2 then DIAS_DUR end) as DIAS_DUR2,
       max(case when rn = 2 then INI end) as INI2,
       max(case when rn = 2 then FIN end) as FIN2,

       max(case when rn = 3 then DIAS_DUR end) as DIAS_DUR3,
       max(case when rn = 3 then INI end) as INI3,
       max(case when rn = 3 then FIN end) as FIN3,
       
       max(case when rn = 4 then DIAS_DUR end) as DIAS_DUR4,
       max(case when rn = 4 then INI end) as INI4,
       max(case when rn = 4 then FIN end) as FIN4
FROM CTE
WHERE RUT_DV IN ('14583018-4','09795373-2','16079247-7','15329692-8','13495643-7','18222448-0','17384694-0','16571139-4','16276948-0',
'12634552-6','07005871-5','06396907-9','07516170-0','06282282-1','11856595-9','14550473-2','19236575-9','12608431-5','16653561-1',
'17227086-7','17608978-4','11190833-8','14144005-5','16339480-4','14285285-3','11848392-8','12239061-6','16661805-3','18099850-0',
'16070401-2','16457538-1','15918134-0','10647128-2','16361408-1','13851347-5','16478471-1','16857752-4','17253800-2','15739567-K',
'15543970-K','09868914-1','16790428-9','18635125-8','18338932-7','15940152-9','14159592-k','08242978-6','16610008-9','15536596-K',
'11847860-6','06373995-2','10999674-2','08186739-9','16125801-6','09401298-8','15580169-7','17478775-1','17418119-5','14597049-0',
'16795522-3','16691891-K','15754902-2','08117660-4','13715965-1','08774140-0','15373933-1','11824524-5','12865355-4','10325077-3',
'15438950-4','09478007-1','08344456-8','17575545-4','11948679-3','12474251-K','11548807-4','11872204-3','14198677-5','16922232-0',
'17054800-0','16090906-4','25223558-2','12500537-3','10551340-2','15837677-6','06594417-0','09654671-8','10567673-5','13907838-1',
'09979896-3','15634786-8','09031276-6','13767427-0','18172461-7','17602556-5','11479542-9','16193116-0','16923678-k','18022767-9',
'08404622-1','16123501-6','10225221-7','13029329-8','14138474-0','13052862-7','12833817-9','18083910-0','18748051-5','14448134-8',
'15336630-6','13302127-2','14270107-3','17097806-4','09159496-k','11482230-2','12410556-0','13672266-2','13715502-8','14137700-0',
'13271252-2','06618014-K','10723345-8','11753565-7','06557525-6','18613894-5','15424657-6','14149834-7','14506645-k','14156920-1',
'14152643-K','09805210-0','11653149-6','16115770-8','16405870-0','08039984-7','09818257-8','08317301-7','14183950-0','05746982-K',
'13930070-K','08029844-7','08788677-8','08087538-K','13351801-0','18695310-k','12506100-1','12585349-8','12113891-3','06342822-1',
'18406332-8','16976669-K','15689022-7','18326721-3','16069062-3','08112422-1','17049977-8','15045565-0','10123000-7','07004149-9',
'17433656-3','17735812-6','11211103-4','13212265-2','17656827-5','17093420-2','18182530-8','08906606-9','07792600-3','15491079-4',
'16838845-4','11135170-8','10725207-K','07882436-0','16535318-8','09685332-7','10743357-0','10731371-0','07876933-5','18504542-0',
'16328330-1','07241391-1','08617084-1','15611825-7','10357657-1','10294868-8','10828762-4','17157470-6','17883588-2','17442887-5',
'16928285-4','12438218-1','18006472-9','08053795-6','19178803-6','08502779-4','07482696-2','13364860-7','17688522-K','10104349-5',
'08678890-K','15969432-1','13018114-7','11719892-8','13145662-K','11793691-0','13136176-9','09450382-5','17466736-5','09281317-7',
'18239368-1','10300337-7','06515890-6','18267022-7','10130960-6','12765142-6','09716293-K','09763806-3','18328687-0','18334624-5',
'12291455-0','11553572-2','10755332-0','16448083-6','09552994-1','16200336-4','06895112-7','09229125-1','09169997-4','13208016-K',
'06515053-0','11675643-9','13952957-K','10029003-0','12194803-6','10741363-4','09235966-2','15232556-8','17501717-8','17915858-2',
'17260827-2','12751183-7','13520671-7','11592465-6','12939894-9','15655984-9','16759478-6','12626112-8','07964299-1','08980275-K',
'07875969-0','16799807-0','16700668-K','10329095-3','17210805-9','11398579-8','19775146-0','15560394-1','09645721-9')
GROUP BY ID_HR,RUT_DV, NOM_INC
ORDER BY RUT_DV;
--
SELECT REPLACE(RUT,'.','') AS RUT_DV,ESTADO,ULT_DIA_TRAB FROM CENTTALENTUM


--09229125-1 10999674-2
SELECT * FROM INF_VAC WHERE RUT_DV = '06515890-6' order BY PER_PRO
SELECT * FROM historicovac WHERE rut = '10999674-2' and nom_inc like 'permiso%' order BY subido

;with cte as (
    select id_hr, ini, fin, rn = row_number() over(partition by id_hr, ini, fin order by subido)
    from historicoVac
)
select * from cte order by rn

--
select count(*) from historicoVac
exec AMPLIACIONVAC
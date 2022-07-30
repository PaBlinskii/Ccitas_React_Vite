SELECT  CEALX835F.RAR.RDATE, 
CEALX835F.RAR.ARDOCN,  
CEALX835F.RAR.RINVC,  
CEALX835F.RAR.RCUST,  
CEALX835F.RCML01.CNME,  
CEALX835F.RAR.RSAL,  
CEALX835F.RCML01.CAD1,  
CEALX835F.SIh.SIQTY,  
CEALX835F.SIH.SICARR,  
CEALX835F.sil.ilires,  
CEALX835F.ZPAL01.DATA AS RAZON  
FROM CEALX835F.RAR,  
CEALX835F.RCML01,  
CEALX835F.ZPAL01 ,  
CEALX835F.sih ,  
CEALX835F.sil  
WHERE  
( CEALX835F.RAR.RCUST = CEALX835F.RCML01.CCUST )  
AND (CEALX835F.RAR.RCUST = CEALX835F.SIH.SICUST)   
AND (CEALX835F.RAR.ARDPFX = CEALX835F.SIH.IHDPFX )   
AND (CEALX835F.RAR.ARDOCN = CEALX835F.SIH.IHDOCN )  
AND (CEALX835F.RAR.ARDPFX = CEALX835F.SIL.ILDPFX )  
AND (CEALX835F.RAR.ARDOCN = CEALX835F.SIL.ILDOCN )  
AND (CEALX835F.RAR.RSEQ = CEALX835F.SIL.ILLINE )   
and ( ( CEALX835F.RAR.RDATE between  ' 20210601"' AND '20210605' )  
AND ( CEALX835F.RAR.ARDPFX LIKE  ' ' )  
AND ( CEALX835F.RAR.RSAL between '000'   AND '999'  )   
and ( SUBSTR(CEALX835F.ZPAL01.PKEY,1,6)='RCODRM' )  
and ( SUBSTR(CEALX835F.ZPAL01.PKEY,7,2)=CEALX835F.SIL.ILIRES ) )  
 ORDER BY  
 CEALX835F.RAR.RCUST ASC,  
 CEALX835F.RAR.RDATE ASC,  
 CEALX835F.RCML01.CAD1;

-- QUERY pedido por Ing. Nelson para Gerencia
SELECT
    CEALX835F.IIM.IPROD,
    CEALX835F.HPO.PPROD,
    CEALX835F.HPO.PSTAT,
    CEALX835F.HPO.PLINE,
    CEALX835F.HPO.PQORD,
    CEALX835F.HPO.PQREC,
    CEALX835F.HPO.POCDT,
    CEALX835F.HPO.POCBY,
    CEALX835F.HPH.PHORD, 
    CEALX835F.HPH.PHCOMP,
    CEALX835F.HPH.PHVEND,
    CEALX835F.HPH.PHCOMP
FROM
    CEALX835F.IIM,
    CEALX835F.HPH,
    CEALX835F.HPO,
    CEALX835F.AVM,
	CEALX835F.RCO    
WHERE
    (HPO.PPROD = IIM.IPROD)
AND (HPH.PHORD = HPO.PORD)
AND (HPH.PHCOMP = AVM.VCMPNY)
AND (HPH.PHVEND = AVM.VENDOR)
AND (HPO.PPROD = IIM.IPROD)
ORDER BY
;



SELECT
    IIM.IPROD,
    HPO.PPROD,
    HPO.PSTAT,
    HPO.PLINE,
    HPO.PQORD,
    HPO.PQREC,
    HPO.POCDT,
    HPO.POCBY,
    HPH.PHORD, 
    HPH.PHCOMP,
    HPH.PHVEND,
    HPH.PHCOMP
FROM
    IIM AS I,
    HPH AS H,
    HPO AS HO,
    AVM AS A,
	RCO AS R   
WHERE
    (HO.PPROD = I.IPROD)
AND (H.PHORD = HO.PORD)
AND (H.PHCOMP = A.VCMPNY)
AND (H.PHVEND = A.VENDOR)
AND (HO.PPROD = I.IPROD);


-- Query para ordenes abiertas Ing. Nelson
SELECT 
T1.PHCOMP,
(SELECT CMPNAM FROM CEALX835F.RCO T6
WHERE T6.CMPNY = T1.PHCOMP) AS DESCOMP,
T1.PHORD,
T2.PVEND,
(SELECT VNDNAM FROM CEALX835F.AVM T4
WHERE T4.VENDOR = T2.PVEND) AS TVENDOR,
T2.PPROD,
(SELECT IDESC FROM CEALX835F.IIM T5
WHERE T5.IPROD = T2.PPROD) AS DESCRIA,
T2.PLINE,
T2.PQORD,
T2.PQREC,
SUBSTR(T2.POCDT,7,2)||'/'||SUBSTR(T2.POCDT,5,2)||'/'||SUBSTR(T2.POCDT,1,4) AS FECHA,
T2.POCBY,            
T2.PSTAT
FROM CEALX835F.HPHL01 T1
JOIN CEALX835F.HPO T2 ON T1.PHORD = T2.PORD
WHERE T2.PSTAT IN ('0','1')
ORDER BY T1.PHORD DESC;

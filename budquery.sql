Army_pay_bud_(mh)_101 = 
CALCULATE(
    IF(
        SUM(Bud_codehd_master[vma]) > 0 && SUM(Bud_codehd_master[cma]) > 0,
        (SUM(Bud_codehd_master[vma]) + SUM(Bud_codehd_master[cma])) / 10000,
        IF(
            SUM(Bud_codehd_master[vre]) > 0 && SUM(Bud_codehd_master[cre]) > 0,
            (SUM(Bud_codehd_master[vre]) + SUM(Bud_codehd_master[cre])) / 10000,
            (SUM(Bud_codehd_master[vbe]) + SUM(Bud_codehd_master[cbe])) / 10000
        )
    ),
    Bud_codehd_master[majhd] = 2076,
    Bud_codehd_master[minorhd] = 101
)

###################################################################################
CREATE VIEW Bud_codehd_master AS
SELECT vbe,cbe,vre,cre,vma,cma,ch,majhd,majhd_desc,minhdid,minorhd,minorhd_desc,detailhd,dethdid,detailhd_desc,subhdid1,subhdid,sub_head,
sub_head_desc,minhdid1,submajhdid1,submajhdid,submajhd,submajhd_desc,majhd1,majsubmajid2,
granthd1,grantno1
FROM bud_codehd2425
INNER JOIN mast5_detailhd2 ON dethdid = dethdid1 
INNER JOIN mast4_subhd2 AS m4 ON subhdid = subhdid1 
INNER JOIN mast3_minor_hd2 ON minhdid=minhdid1 
INNER JOIN mast2_submaj_hd2 ON submajhdid = Submajhdid1 
INNER JOIN mast1_major_hd ON majhd = majhd1 
#################################### Easy way logic final i am using in all area ############################
SELECT 
    CASE
        WHEN SUM(vma) > 0 AND SUM(cma) > 0 THEN 
            (SUM(vma) + SUM(cma)) / 10000
        WHEN SUM(vre) > 0 AND SUM(cre) > 0 THEN 
            (SUM(vre) + SUM(cre)) / 10000
        ELSE 
            (SUM(vbe) + SUM(cbe)) / 10000
    END AS Armypaybud
FROM 
Bud_codehd_master

WHERE majhd IN (2076)   AND minorhd IN (101)

####################################################################################



#----------------------------------------------------------------------------------------------------------------

SELECT 
    CASE
        -- Check if VMA and CMA have values or (VMA > 0 and CMA = 0)
        WHEN (SUM(VMA) > 0 AND SUM(CMA) > 0) OR (SUM(VMA) > 0 AND SUM(CMA) = 0) THEN 
            (SUM(VMA) + SUM(CMA)) / 10000.0
        -- Check if CRE and VRE have values, or if VRE has data and CRE is 0
        WHEN (SUM(CRE) > 0 AND SUM(VRE) > 0) OR (SUM(VRE) > 0 AND SUM(CRE) = 0) THEN 
            (SUM(CRE) + SUM(VRE)) / 10000.0
        -- Check if CBE and VBE have values or (CBE > 0 and VBE = 0)
        WHEN (SUM(CBE) > 0 AND SUM(VBE) > 0) OR (SUM(CBE) > 0 AND SUM(VBE) = 0) THEN 
            (SUM(CBE) + SUM(VBE)) / 10000.0
        -- If none of the conditions are met, return 'Not Present Data'
        ELSE 'Not Present Data'
    END AS Bud_codehead_level
FROM Bud_codehd_master
WHERE majhd IN (2076)   AND minorhd IN (101)

-----------------------------------------------------------------
SELECT 
    CASE
        -- Check if VMA and CMA have values or (VMA > 0 and CMA = 0)
        WHEN (SUM(VMA) > 0 AND SUM(CMA) > 0) OR (SUM(VMA) > 0 AND SUM(CMA) = 0) THEN 
            (SUM(VMA) + SUM(CMA)) / 10000.0
        -- Check if CRE and VRE have values, or if VRE has data and CRE is 0
        WHEN (SUM(CRE) > 0 AND SUM(VRE) > 0) OR (SUM(VRE) > 0 AND SUM(CRE) = 0) THEN 
            (SUM(CRE) + SUM(VRE)) / 10000.0
        -- Check if CBE and VBE have values or (CBE > 0 and VBE = 0)
        WHEN (SUM(CBE) > 0 AND SUM(VBE) > 0) OR (SUM(CBE) > 0 AND SUM(VBE) = 0) THEN 
            (SUM(CBE) + SUM(VBE)) / 10000.0
        -- If none of the conditions are met, return 'Not Present Data'
        ELSE 'Not Present Data'
    END AS Bud_codehead_level
FROM Bud_codehd_master
WHERE majhd IN (2076)   AND minorhd IN (103)
-------------------------------------------------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE 
    majhd IN (2076) 
    AND minorhd IN (104) 
    AND ch IN (23004);
    
    
    SELECT * FROM Bud_codehd_master WHERE 
    majhd IN (2076) 
    AND minorhd IN (104) AND  ch IN (23004);
------------------------------------------------------------------------

SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 AND SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 AND SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN (2076)   AND minorhd IN (106) AND  ch IN (35101, 35102, 35103, 35109, 35110, 35111) 



----------------------------------------------------------------

SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 AND SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 AND SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM Bud_codehd_master
WHERE majhd IN (2076)   AND minorhd IN (107) AND  ch IN (36101, 36102, 36103, 36104) 


-----------------------------------------------------------------------------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 AND SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 AND SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE 
    majhd IN (2076) 
    AND sub_head IN ("A", "B") 
    AND minorhd IN (112) 
    AND ch IN (53101, 53102, 53103, 53104, 53201, 53202, 53301, 53302, 53303, 53304, 53305, 53306, 53307, 53308);
----------------------------------------------------------------------------------------------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
 WHERE majhd IN(2076) AND minorhd IN(113)AND sub_head  IN ("A", "B", "G") AND ch IN (54001, 54002, 55101, 55102,55103,55101,55102)
 
 
 

-------------------------------------------------------------navy--------------------------------------------


SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
 WHERE majhd IN(2077) AND minorhd IN(101)
 
 
 
 
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
 WHERE majhd IN(2077) AND minorhd IN(104)
 
 
 
 
 
 
 
 SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN (2077) 
AND minorhd IN(112) 
AND sub_head IN ("A","B")
AND ch IN (69001,69002,69003,69101,69102,69103,69104,69105,69106,69107,69108,69109,69110,69111,69112,69113)

 
 
 
 #------------------------------air force ---------------------------
 
 SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN (2078) 
AND minorhd IN(101) 



 
  SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN (2078) 
AND minorhd IN(104) 

 #------------------------------------------------DGOF------------------------------------------------
 SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2079) AND minorhd IN(004) AND ch IN(81201,81202,81203,81204,81205,81206)
AND sub_head IN ( "A")

 
 
 SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2079) AND minorhd IN(800) AND ch IN(81009 ,81010)
AND sub_head IN ( "h")


#------------------------------------------------DRDO------------------------------------------------


SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2080) AND minorhd IN(101) 



SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2080) AND minorhd IN(102) 


#--------------------------------------above allcode is for Pay all 2076 to 2080-------------------------------



#--------------------------------------Army Store 2076-------------------------------


#--------------------------------------Army Store 106-------------------------------

SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2076) AND minorhd IN(106)AND ch IN(35105, 35106,35132)


#--------------------------------------Army Store 107-------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2076) 
AND minorhd IN(107)
AND sub_head IN ("C", "D")
AND ch IN(36301,36302,36303,36304,36401, 36402, 36403, 36404, 36405, 36406, 36407, 36408, 36409, 36410);



#---- or
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE 
    majhd IN (2076) 
    AND minorhd IN (107)
    AND sub_head IN ('C', 'D')
    AND ch BETWEEN 36301 AND 36410;

#--------------------------------------Army Store 110-------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2076) 
AND minorhd IN(110)

#--------------------------------------Army Store 112-------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2076) 
AND minorhd IN(112)
AND sub_head IN ('F', 'H')
AND ch IN (53601, 53602, 53603, 53604, 53605, 53606, 53607, 53608, 53609, 53610,
53611, 53612, 53613, 53614, 53615, 53616, 53617, 53618, 53619, 53620, 53621,53801, 53802, 53803, 53804, 53805, 53806, 53807, 53808, 53809, 53810)




#--------------------------------------Army Store 113-------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2076) 
AND minorhd IN(113)
AND sub_head IN ('D', 'H')
AND ch IN (54301,54302,54303,54401,54402,54403,54501,54502,54503,54601,54602,54603,54700,54800,55201,55202,55301,55302,55401,55402,55501,55502)



#--------------------------------------Army Work -------------------------------




#--------------------------------------Army work  113-------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA and CMA are both greater than 0
        WHEN SUM(COALESCE(VMA, 0)) > 0 OR  SUM(COALESCE(CMA, 0)) > 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE and VRE are both greater than 0
        WHEN SUM(COALESCE(CRE, 0)) > 0 OR  SUM(COALESCE(VRE, 0)) > 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) > 0 OR SUM(COALESCE(VBE, 0)) > 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master
WHERE majhd IN(2076) 
AND minorhd IN(107)
AND sub_head IN ('G')
AND ch IN (36700)

#--------------------------------------Army work  111 -------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(-VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (111)
    AND sub_head IN ('E')
    AND ch IN (49506);


#--------------------------------------Army work  112 -------------------------------
SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (112)
    AND sub_head IN ('G')
    AND ch IN (53700);

#--------------------------------------Army work  113 -------------------------------

SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (113)
    AND sub_head IN ('E')
    AND ch IN (54901);

#--------------------------------------Army work  113 -------------------------------

SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (113)
    AND sub_head IN ('E')
    AND ch IN (54901);




#--------------------------------------Army Miss -------------------------------

SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (106)
    AND ch IN (35112,35130);




SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (107)
    AND sub_head IN ("E","F")
    AND ch IN (36500,36600);
    


SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (112)
    AND sub_head IN ("D")
    AND ch IN (53401, 53402, 53403, 53404, 53405, 53406, 53407, 53408, 53409, 53410);


SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (113)
    AND sub_head IN ("F")
    AND ch IN (55001,55002,55003);



SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (800)
  

#--------------------------------------------Army Transpotation---------------------------------------


SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (105)
   
    

SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (106)
    AND ch IN (35107)
    

  
SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (107)
    AND Sub_head IN("B")
    AND ch IN (36201,36202,36203)
    


SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (112)
    AND Sub_head IN("E")
    AND ch IN (53501,53502,53503);
    


SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (113)
    AND Sub_head IN("C")
    AND ch IN (54201,54202,54203);
    


SELECT 
    CASE
        -- Step 1: Check if VMA or CMA have non-null values
        WHEN SUM(COALESCE(VMA, 0)) <> 0 OR SUM(COALESCE(CMA, 0)) <> 0 THEN 
            (SUM(COALESCE(VMA, 0)) + SUM(COALESCE(CMA, 0))) / 10000.0
        -- Step 2: Check if CRE or VRE have non-null values
        WHEN SUM(COALESCE(CRE, 0)) <> 0 OR SUM(COALESCE(VRE, 0)) <> 0 THEN 
            (SUM(COALESCE(CRE, 0)) + SUM(COALESCE(VRE, 0))) / 10000.0
        -- Step 3: If neither of the above, add CBE and VBE
        ELSE 
            CASE 
                WHEN SUM(COALESCE(CBE, 0)) <> 0 OR SUM(COALESCE(VBE, 0)) <> 0 THEN 
                    (SUM(COALESCE(CBE, 0)) + SUM(COALESCE(VBE, 0))) / 10000.0
                ELSE 'Not Present Data'
            END
    END AS Bud_codehead_level
FROM 
    Bud_codehd_master   
    
WHERE 
    majhd IN (2076) 
    AND minorhd IN (101)
   



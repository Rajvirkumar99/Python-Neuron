DROP VIEW master_all

#---------------------------------- Final Query--------------------------------------------



CREATE VIEW master_all AS
SELECT t.*,majhd,m1.grantno1,majhd_desc,submajhdid,submajhd,submajhd_desc,minhdid,minorhd,minorhd_desc,subhdid,sub_head,sub_head_desc,dethdid,detailhd,detailhd_desc,chid,ch,ch_desc,rc FROM mast6_codeheads22425 AS m6
RIGHT JOIN trans_main2425 AS t ON t.codehead=m6.ch  AND t.rc1=m6.rc
INNER JOIN mast5_detailhd2 AS m5 ON dethdid1=dethdid
INNER JOIN mast4_subhd2 AS m4 ON subhdid1=subhdid
INNER JOIN mast3_minor_hd2 AS m3 ON minhdid1=minhdid
INNER JOIN mast2_submaj_hd2 AS m2 ON submajhdid1=submajhdid
INNER JOIN mast1_major_hd AS m1 ON majhd=majhd1


#---------------------------------- Testing expediture--------------------------------------------

SELECT DISTINCT(minorhd) FROM mast6_codeheads22425 AS m6
INNER JOIN mast5_detailhd2 AS m5 ON dethdid1=dethdid
INNER JOIN mast4_subhd2 AS m4 ON subhdid1=subhdid
INNER JOIN mast3_minor_hd2 AS m3 ON minhdid1=minhdid
INNER JOIN mast2_submaj_hd2 AS m2 ON submajhdid1=submajhdid
INNER JOIN mast1_major_hd AS m1 ON majhd=majhd1
WHERE majhd=2076


#----------------------------------Service wise expenditure--------------------------------------------

SELECT majhd,SUM(amt*(majhd=2076))/10000000 AS army_exp,(vbe+cbe)*(budmajhdid=2076)/10000 AS Army_bdg ,SUM(amt*(majhd=2077))AS navy_exp,(vbe+cbe)*(budmajhdid=2077)/10000 AS Navy_bdg,
SUM(amt*(majhd=2078))AS Airforce,(vbe+cbe)*(budmajhdid=2078)/10000 AS Airforce_bdg,SUM(amt*(majhd=2079))AS Ord_fys,(vbe+cbe)*(budmajhdid=2079)/10000 AS Ord_fys_bdg,
SUM(amt*(majhd=2080))AS drdo,(vbe+cbe)*(budmajhdid=2080)/10000 AS DRDO_bdg FROM  master_all
INNER JOIN bud_majhd2425 ON majhd=budmajhdid
WHERE majhd IN(2076,2077,2078,2079,2080) GROUP BY majhd


SELECT majhd FROM mast1_major_hd WHERE NOT IN (2076,2077,2078,2079,2080,76,77,78,79,80)

# ---------------- Budget Calculation on Grant level----------------------

SELECT (SUM(vbe) + SUM(cbe)) / 10000 AS "CapitalOutlay On Defence Services"
FROM bud_minhd2425
WHERE budminhdid IN (50, 52, 101, 102, 103, 104, 111, 112, 113, 202, 204, 205, 206, 209);


SELECT (SUM(vbe) + SUM(cbe)) / 10000 AS "Defence Pensions"
FROM bud_minhd2425
WHERE budminhdid IN (101, 102, 103, 104, 105, 108, 115, 117, 800, 902, 911);

SELECT (SUM(vbe) + SUM(cbe)) / 10000 AS "Ministry of Defence (Civil)" 
FROM bud_minhd2425
WHERE budminhdid IN (66, 67, 75, 76, 109, 158, 165, 181, 184, 220, 245, 330, 447);

SELECT (SUM(vbe) + SUM(cbe)) / 10000 AS "Ministry of Defence (Civil)" 
FROM bud_minhd2425
WHERE budminhdid IN (66, 67, 75, 76, 109, 158, 165, 181, 184, 220, 245, 330, 447);

SELECT (SUM(vbe) + SUM(cbe)) / 10000 AS "Defence Services (Revenue)" 
FROM bud_minhd2425
WHERE budminhdid IN (38, 39, 41, 42, 43, 44, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 58, 59, 
                     110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 123, 124, 
                     125, 126, 127, 128, 129, 130, 132, 133, 134, 135, 137, 138, 151, 152, 
                     153, 154, 155, 156, 157, 317, 318, 320, 450, 451, 452, 472);
                     
                     
                    
 #---------------------------- Pay & Allowances---------------------                                     

#----------------------------101------ salary calculation---------------------

SELECT 
    majhd, minorhd,
    ROUND(SUM(amt * (RC1 = 'C')) / 10000000, 2) AS Pay_Allowance
FROM 
    master_all
WHERE 
    majhd IN (2076) AND minorhd IN (101)
    
GROUP BY 
    majhd,minorhd
ORDER BY 
    majhd AND minorhd;

#--------------------------------103-----------------------
SELECT 
    majhd,minorhd,
    ROUND(SUM(amt * (RC1 = 'C')) / 10000000, 2) AS Pay_Allowance
FROM 
    master_all
WHERE 
    majhd =2076 AND minorhd =103
    
GROUP BY 
    majhd,minorhd
ORDER BY 
    majhd AND minorhd;

#--------------------------------104-----------------------
SELECT 
    majhd,minorhd,
    ROUND(SUM(amt * (RC1 = 'C')) / 10000000, 2) AS Pay_Allowance
FROM 
    master_all
WHERE 
    majhd =2076 AND minorhd =104
    AND ch NOT IN(23004)
    
GROUP BY 
    majhd,minorhd;

#------------------106------------------
SELECT majhd,minorhd,ROUND(SUM(amt * (RC1 = 'C')) / 10000000, 2) AS Pay_Allowance FROM master_all
WHERE  majhd =2076 AND  minorhd= 106 AND ch IN (35101,35102,35103,35109,35110,35111) GROUP BY majhd,minorhd;

#------------------107------------------
SELECT majhd,minorhd,ROUND(SUM(amt * (RC1 = 'C')) / 10000000, 2) AS Pay_Allowance FROM master_all
WHERE  majhd =2076 AND  minorhd= 107 AND sub_head IN ('A') AND ch IN(36101,36102,36103,36104) GROUP BY majhd,minorhd;

#------------------112------------------
SELECT majhd,minorhd,ROUND(SUM(amt * (RC1 = 'C')) / 10000000, 2) AS Pay_Allowance FROM master_all
WHERE  majhd =2076 AND  minorhd= 112 AND ch IN(53101,53102,53103,53104.53105,53201,53202,53301,53302,53303,53304,53305,53306,53307,53308) GROUP BY majhd,minorhd;

#------------------113------------------
SELECT majhd,minorhd,ROUND(SUM(amt * (RC1 = 'C')) / 10000000, 2) AS Pay_Allowance FROM master_all
WHERE  majhd =2076 AND  minorhd= 113 AND sub_head IN ('A','B','G') AND ch IN(54001,54002,54101,54102,54103,54106,55101,55102)   GROUP BY majhd,minorhd;
#------------------114------------------
SELECT majhd,minorhd,ROUND(SUM(amt * (RC1 = 'C')) / 10000000, 2) AS Pay_Allowance FROM master_all
WHERE  majhd =2076 AND  minorhd= 114  GROUP BY majhd,minorhd;









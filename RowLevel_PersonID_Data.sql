--Termination counts by month
SELECT DISTINCT peo.PERSON_ID as "Person ID",
asmt.SUPERVISOR_ID as "Manager ID",
  CASE
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
    THEN 'FY'
      || TO_CHAR(to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
    ELSE 'FY'
      || TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
  END AS "Fiscal Year",
  CASE
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 5
    THEN 'Q1'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 6
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 8
    THEN 'Q2'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 9
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 11
    THEN 'Q3'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 12
    OR to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 2
    THEN 'Q4'
    ELSE 'UNSPECIFIED'
  END AS "Fiscal Quarter",
  CASE
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 5
    THEN
      CASE
        WHEN to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
        THEN 'FY'
          || TO_CHAR(to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
        ELSE 'FY'
          || TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
      END
      || 'Q1'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 6
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 8
    THEN
      CASE
        WHEN to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
        THEN 'FY'
          || TO_CHAR(to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
        ELSE 'FY'
          || TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
      END
      || 'Q2'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 9
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 11
    THEN
      CASE
        WHEN to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
        THEN 'FY'
          || TO_CHAR(to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
        ELSE 'FY'
          || TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
      END
      || 'Q3'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 12
    OR to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 2
    THEN
      CASE
        WHEN to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
        THEN 'FY'
          || TO_CHAR(to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
        ELSE 'FY'
          || TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
      END
      || 'Q4'
    ELSE 'UNSPECIFIED'
  END AS "Fiscal Year_Qtr",
  to_date('01-'
  || SUBSTR(SVC.actual_termination_date, 4, 6)) AS "Month",
  CASE
    WHEN
      CASE
        WHEN SVC.LEAVING_REASON IN('RH_RS')
        THEN 'Voluntary'
        WHEN SVC.LEAVING_REASON IN('T', 'TC')
        THEN 'Involuntary'
        WHEN SVC.LEAVING_REASON IN('D')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'Voluntary'
    AND
      CASE
        WHEN SVC.ATTRIBUTE2 IN('R13', 'R14', 'R15')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'UNSPECIFIED'
    THEN '2-Voluntary'
    WHEN
      CASE
        WHEN SVC.LEAVING_REASON IN('RH_RS')
        THEN 'Voluntary'
        WHEN SVC.LEAVING_REASON IN('T', 'TC')
        THEN 'Involuntary'
        WHEN SVC.LEAVING_REASON IN('D')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'Involuntary'
    AND
      CASE
        WHEN SVC.ATTRIBUTE2 IN('R13', 'R14', 'R15')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'UNSPECIFIED'
    THEN '3-Involuntary'
    WHEN
      CASE
        WHEN SVC.ATTRIBUTE2 IN('R13', 'R14', 'R15')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'Other'
    THEN '4-Other'
  END AS "Data Flag",
  CASE
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('BA', 'Legal')
    THEN 'Legal'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('BoD/Exec', 'Finance')
    THEN 'Finance &'
      || ' Exec'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Facilities')
    THEN 'GWS'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('R&'
      || 'D', 'GES')
    THEN 'R&'
      || 'D'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GLS')
    THEN 'GLS'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GPS', 'SDM')
    THEN 'Consulting'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GSS')
    THEN 'CEE'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('IT')
    THEN 'IT'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Marketing')
    THEN 'Marketing'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Operations')
    THEN 'Operations'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('People')
    THEN 'People'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Sales')
    THEN 'Sales'
    ELSE 'UNSPECIFIED'
  END                                     AS "Dept by CC",
  substr(ORG.NAME, -3) as "Cost Center",
  ORG.NAME as "Organization",
  HR_LOC_REGION_MAP.LIST_VALUE_LONG_DESC  AS "Region",
  HR_LOC_COUNTRY_MAP.LIST_VALUE_LONG_DESC AS "Country",
  LOC.LOCATION_CODE                       AS "Location",
  PEO.SEX                                 AS "Gender",
  CASE
    WHEN ASMT.MANAGER_FLAG = 'Y'
    THEN 'Y'
    ELSE 'N'
  END AS "Manager Flag",
  CASE
    WHEN ROUND((to_date(SVC.actual_termination_date) - PEO.DATE_OF_BIRTH)/365.25,2) < 30.0000
    THEN '< 30 Years'
    WHEN ROUND((to_date(SVC.actual_termination_date) - PEO.DATE_OF_BIRTH)/365.25,2) BETWEEN 30.0000 AND 39.9999
    THEN '30-40 Years'
    WHEN ROUND((to_date(SVC.actual_termination_date) - PEO.DATE_OF_BIRTH)/365.25,2) BETWEEN 40.0000 AND 49.9999
    THEN '40-50 Years'
    WHEN ROUND((to_date(SVC.actual_termination_date) - PEO.DATE_OF_BIRTH)/365.25,2) > 50.0000
    THEN '> 50 Years'
    ELSE 'No DOB'
  END AS "Age Band",
  CASE
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END <= 0.5000
    THEN '0-6 months'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END BETWEEN 0.5001 AND 1.0000
    THEN '6-12 Months'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END BETWEEN 1.0001 AND 2.0000
    THEN '1-2 Years'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END BETWEEN 2.0001 AND 4.0000
    THEN '2-4 Years'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END BETWEEN 4.0001 AND 7.0000
    THEN '4-7 Years'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END >= 7.0001
    THEN '7+ Years'
    ELSE NULL
  END AS "Tenure Band",
  JOBS.ATTRIBUTE2 AS "Tech Designation",
  SUBSTR(jobs.name, INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1, (INSTR(jobs.name, '.', INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1))-(INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1)) as "Job Title",
  substr(jobs.name, 0, INSTR(jobs.name, '.')-1) as "Job Function",
  SUBSTR(jobs.name, INSTR(jobs.name, '.')+1, (INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1)-(INSTR(jobs.name, '.')+2)) AS "Job Family",
  GRAD.NAME AS "Pay Grade",
  'Termination' as "Change Reason",
  PEO.PERSON_TYPE_ID AS "Person Type"
  --COUNT(DISTINCT PEO.PERSON_ID) AS "Count"
FROM RHEDW_STG.STG_EBS_PER_ALL_PPL_F PEO,
  RHEDW_STG.STG_EBS_PER_PERIODS_OF_SERVICE SVC,
  RHEDW_STG.STG_EBS_PER_ALL_ASSIGNMENTS_F ASMT,
  RHEDW_STG.STG_EBS_HR_LOCATIONS_ALL LOC,
  RHEDW_STG.STG_EBS_HR_ALL_ORGN_UNT ORG,
  --RHEDW_STG.STG_EBS_HR_ALL_ORGN_UNT ORG,
  RHEDW_STG.STG_EBS_PER_JOBS JOBS,
  RHEDW_STG.STG_EBS_PER_GRADES GRAD,
  RHEDW.DW_GENERIC_LKP HR_CC_DEPT_MAP,
  RHEDW.DW_GENERIC_LKP HR_LOC_REGION_MAP,
  RHEDW.DW_GENERIC_LKP HR_LOC_COUNTRY_MAP
WHERE SVC.actual_termination_date BETWEEN PEO.EFFECTIVE_START_DATE AND PEO.EFFECTIVE_END_DATE
--AND SVC.actual_termination_date BETWEEN '01-mar-2010' AND '01-feb-2016'
AND SVC.actual_termination_date BETWEEN :StartDate AND :EndDate
AND SVC.PERSON_ID = PEO.PERSON_ID
--AND ASMT.ORGANIZATION_ID               = ORG.ORGANIZATION_ID
AND SVC.actual_termination_date BETWEEN ASMT.EFFECTIVE_START_DATE AND ASMT.EFFECTIVE_END_DATE
AND ASMT.JOB_ID                        = JOBS.JOB_ID
AND ASMT.GRADE_ID = GRAD.GRADE_ID
AND JOBS.NAME NOT                     IN('Unclassified.Intern.Intern.INTRN','Unclassified.Contractor.Unpaid Intern.999')
AND ASMT.EMPLOYMENT_CATEGORY          IN('FR','PR')
AND ASMT.PRIMARY_FLAG                  = 'Y'
AND PEO.STG_DEL_FLG                   <> 'Y'
AND ASMT.STG_DEL_FLG                  <> 'Y'
AND LOC.STG_DEL_FLG                   <> 'Y'
AND JOBS.STG_DEL_FLG                  <> 'Y'
AND ORG.STG_DEL_FLG                 <> 'Y'
AND SVC.STG_DEL_FLG (+)               <> 'Y'
AND HR_CC_DEPT_MAP.DELETED_FLG(+)     <> 'Y'
AND HR_LOC_REGION_MAP.DELETED_FLG(+)  <> 'Y'
AND HR_LOC_COUNTRY_MAP.DELETED_FLG(+) <> 'Y'
AND SVC.LEAVING_REASON                IN('RH_RS', 'T', 'TC', 'D')
AND PEO.PERSON_ID                      = ASMT.PERSON_ID
AND ASMT.ASSIGNMENT_TYPE               = 'E'
AND ASMT.LOCATION_ID                   = LOC.LOCATION_ID
AND ASMT.ORGANIZATION_ID               = ORG.ORGANIZATION_ID
  --Grouping by Department
AND HR_CC_DEPT_MAP.SUBJECT_AREA_NM(+) IN('HR')
AND HR_CC_DEPT_MAP.LIST_NM(+)         IN('HR_CC_DEPT_MAP')
AND HR_CC_DEPT_MAP.EXPRTN_DT(+)        = TO_DATE('99991231', 'yyyymmdd')
AND HR_CC_DEPT_MAP.LIST_VALUE_CD(+)    = SUBSTR(ORG.NAME, -3)
  --Grouping by Region
AND HR_LOC_REGION_MAP.SUBJECT_AREA_NM(+) IN('HR')
AND HR_LOC_REGION_MAP.LIST_NM(+)         IN('HR_LOC_REGION_MAP')
AND HR_LOC_REGION_MAP.EXPRTN_DT(+)        = TO_DATE('99991231', 'yyyymmdd')
AND LOC.LOCATION_CODE                     =HR_LOC_REGION_MAP.LIST_VALUE_CD(+)
  --Grouping by Country
AND HR_LOC_COUNTRY_MAP.SUBJECT_AREA_NM(+) IN('HR')
AND HR_LOC_COUNTRY_MAP.LIST_NM(+)         IN('HR_LOC_COUNTRY_MAP')
AND HR_LOC_COUNTRY_MAP.EXPRTN_DT(+)        = TO_DATE('99991231', 'yyyymmdd')
AND LOC.LOCATION_CODE                      =HR_LOC_COUNTRY_MAP.LIST_VALUE_CD(+)
GROUP BY
  CASE
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
    THEN 'FY'
      || TO_CHAR(to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
    ELSE 'FY'
      || TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
  END,
  CASE
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 5
    THEN 'Q1'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 6
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 8
    THEN 'Q2'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 9
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 11
    THEN 'Q3'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 12
    OR to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 2
    THEN 'Q4'
    ELSE 'UNSPECIFIED'
  END,
  CASE
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 5
    THEN
      CASE
        WHEN to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
        THEN 'FY'
          || TO_CHAR(to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
        ELSE 'FY'
          || TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
      END
      || 'Q1'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 6
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 8
    THEN
      CASE
        WHEN to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
        THEN 'FY'
          || TO_CHAR(to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
        ELSE 'FY'
          || TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
      END
      || 'Q2'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 9
    AND to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 11
    THEN
      CASE
        WHEN to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
        THEN 'FY'
          || TO_CHAR(to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
        ELSE 'FY'
          || TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
      END
      || 'Q3'
    WHEN to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 12
    OR to_number(TO_CHAR(to_date('01-'
      || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) <= 2
    THEN
      CASE
        WHEN to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'mm')) >= 3
        THEN 'FY'
          || TO_CHAR(to_number(TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')) + 1)
        ELSE 'FY'
          || TO_CHAR(to_date('01-'
          || SUBSTR(SVC.actual_termination_date, 4, 6)),'yy')
      END
      || 'Q4'
    ELSE 'UNSPECIFIED'
  END,
  SUBSTR(SVC.actual_termination_date, 4, 6),
  CASE
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('BA', 'Legal')
    THEN 'Legal'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('BoD/Exec', 'Finance')
    THEN 'Finance &'
      || ' Exec'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Facilities')
    THEN 'GWS'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('R&'
      || 'D', 'GES')
    THEN 'R&'
      || 'D'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GLS')
    THEN 'GLS'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GPS', 'SDM')
    THEN 'Consulting'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GSS')
    THEN 'CEE'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('IT')
    THEN 'IT'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Marketing')
    THEN 'Marketing'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Operations')
    THEN 'Operations'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('People')
    THEN 'People'
    WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Sales')
    THEN 'Sales'
    ELSE 'UNSPECIFIED'
  END,
  HR_LOC_REGION_MAP.LIST_VALUE_LONG_DESC,
  substr(ORG.NAME, -3),
  HR_LOC_COUNTRY_MAP.LIST_VALUE_LONG_DESC,
  --LOC.TOWN_OR_CITY,
  LOC.LOCATION_CODE,
  PEO.SEX,
  CASE
    WHEN ROUND((to_date(SVC.actual_termination_date) - PEO.DATE_OF_BIRTH)/365.25,2) < 30.0000
    THEN '< 30 Years'
    WHEN ROUND((to_date(SVC.actual_termination_date) - PEO.DATE_OF_BIRTH)/365.25,2) BETWEEN 30.0000 AND 39.9999
    THEN '30-40 Years'
    WHEN ROUND((to_date(SVC.actual_termination_date) - PEO.DATE_OF_BIRTH)/365.25,2) BETWEEN 40.0000 AND 49.9999
    THEN '40-50 Years'
    WHEN ROUND((to_date(SVC.actual_termination_date) - PEO.DATE_OF_BIRTH)/365.25,2) > 50.0000
    THEN '> 50 Years'
    ELSE 'No DOB'
  END,
  CASE
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END <= 0.5000
    THEN '0-6 months'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END BETWEEN 0.5001 AND 1.0000
    THEN '6-12 Months'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END BETWEEN 1.0001 AND 2.0000
    THEN '1-2 Years'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END BETWEEN 2.0001 AND 4.0000
    THEN '2-4 Years'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END BETWEEN 4.0001 AND 7.0000
    THEN '4-7 Years'
    WHEN
      CASE
        WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.ADJUSTED_SVC_DATE)/365.25,4)
        WHEN SVC.DATE_START IS NOT NULL
        THEN ROUND((to_date(SVC.actual_termination_date) - SVC.DATE_START)/365.25,4)
        ELSE ROUND((to_date(SVC.actual_termination_date) - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
      END >= 7.0001
    THEN '7+ Years'
    ELSE NULL
  END,
  CASE
    WHEN ASMT.MANAGER_FLAG = 'Y'
    THEN 'Y'
    ELSE 'N'
  END,
  CASE
    WHEN
      CASE
        WHEN SVC.LEAVING_REASON IN('RH_RS')
        THEN 'Voluntary'
        WHEN SVC.LEAVING_REASON IN('T', 'TC')
        THEN 'Involuntary'
        WHEN SVC.LEAVING_REASON IN('D')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'Voluntary'
    AND
      CASE
        WHEN SVC.ATTRIBUTE2 IN('R13', 'R14', 'R15')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'UNSPECIFIED'
    THEN '2-Voluntary'
    WHEN
      CASE
        WHEN SVC.LEAVING_REASON IN('RH_RS')
        THEN 'Voluntary'
        WHEN SVC.LEAVING_REASON IN('T', 'TC')
        THEN 'Involuntary'
        WHEN SVC.LEAVING_REASON IN('D')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'Involuntary'
    AND
      CASE
        WHEN SVC.ATTRIBUTE2 IN('R13', 'R14', 'R15')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'UNSPECIFIED'
    THEN '3-Involuntary'
    WHEN
      CASE
        WHEN SVC.ATTRIBUTE2 IN('R13', 'R14', 'R15')
        THEN 'Other'
        ELSE 'UNSPECIFIED'
      END = 'Other'
    THEN '4-Other'
  END,
  JOBS.ATTRIBUTE2,
  SUBSTR(jobs.name, INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1, (INSTR(jobs.name, '.', INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1))-(INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1)),
  peo.PERSON_ID,
  asmt.SUPERVISOR_ID,
  GRAD.NAME,
  PEO.PERSON_TYPE_ID,
  ORG.NAME,
  substr(jobs.name, 0, INSTR(jobs.name, '.')-1),
  SUBSTR(jobs.name, INSTR(jobs.name, '.')+1, (INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1)-(INSTR(jobs.name, '.')+2))
UNION
--Active by Month
SELECT "Person ID",
  "Manager ID",
  "Fiscal Year",
  "Fiscal Quarter",
  "Fiscal Year_Qtr",
  "a_date"           AS "Month",
  '1-Headcount'      AS "Data Flag",
  "Dept by CC",
  "Cost Center",
  "Organization",
  "Region",
  "Country",
  "Location",
  "Gender",
  "Manager Flag",
  "Age Band",
  "Tenure Band",
  "Tech Designation",
  "Job Title",
  "Job Function",
  "Job Family",
  "Pay Grade",
  "Change Reason",
  "Person Type"
FROM
  (SELECT DISTINCT
    CASE
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
      THEN 'FY'
        || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
      ELSE 'FY'
        || TO_CHAR(to_date("a_date"),'yy')
    END AS "Fiscal Year",
    CASE
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 5
      THEN 'Q1'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 6
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 8
      THEN 'Q2'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 9
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 11
      THEN 'Q3'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 12
      OR to_number(TO_CHAR(to_date("a_date"),'mm'))   <= 2
      THEN 'Q4'
      ELSE 'UNSPECIFIED'
    END AS "Fiscal Quarter",
    CASE
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 5
      THEN
        CASE
          WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
          THEN 'FY'
            || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
          ELSE 'FY'
            || TO_CHAR(to_date("a_date"),'yy')
        END
        || 'Q1'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 6
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 8
      THEN
        CASE
          WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
          THEN 'FY'
            || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
          ELSE 'FY'
            || TO_CHAR(to_date("a_date"),'yy')
        END
        || 'Q2'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 9
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 11
      THEN
        CASE
          WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
          THEN 'FY'
            || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
          ELSE 'FY'
            || TO_CHAR(to_date("a_date"),'yy')
        END
        || 'Q3'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 12
      OR to_number(TO_CHAR(to_date("a_date"),'mm'))   <= 2
      THEN
        CASE
          WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
          THEN 'FY'
            || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
          ELSE 'FY'
            || TO_CHAR(to_date("a_date"),'yy')
        END
        || 'Q4'
      ELSE 'UNSPECIFIED'
    END AS "Fiscal Year_Qtr",
    to_date("a_date") as "a_date",
    CASE
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('BA', 'Legal')
      THEN 'Legal'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('BoD/Exec', 'Finance')
      THEN 'Finance &'
        || ' Exec'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Facilities')
      THEN 'GWS'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('R&'
        || 'D', 'GES')
      THEN 'R&'
        || 'D'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GLS')
      THEN 'GLS'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GPS', 'SDM')
      THEN 'Consulting'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GSS')
      THEN 'CEE'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('IT')
      THEN 'IT'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Marketing')
      THEN 'Marketing'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Operations')
      THEN 'Operations'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('People')
      THEN 'People'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Sales')
      THEN 'Sales'
      ELSE 'UNSPECIFIED'
    END                                     AS "Dept by CC",
    substr(ORG.NAME, -3) as "Cost Center",
    ORG.NAME as "Organization",
    HR_LOC_REGION_MAP.LIST_VALUE_LONG_DESC  AS "Region",
    HR_LOC_COUNTRY_MAP.LIST_VALUE_LONG_DESC AS "Country",
    --LOC.TOWN_OR_CITY                        AS "City",
    LOC.LOCATION_CODE                       AS "Location",
    PEO.SEX                                 AS "Gender",
    CASE
      WHEN ASMT.MANAGER_FLAG = 'Y'
      THEN 'Y'
      ELSE 'N'
    END AS "Manager Flag",
    CASE
      WHEN ROUND((to_date("a_date") - PEO.DATE_OF_BIRTH)/365.25,2) < 30.0000
      THEN '< 30 Years'
      WHEN ROUND((to_date("a_date") - PEO.DATE_OF_BIRTH)/365.25,2) BETWEEN 30.0000 AND 39.9999
      THEN '30-40 Years'
      WHEN ROUND((to_date("a_date") - PEO.DATE_OF_BIRTH)/365.25,2) BETWEEN 40.0000 AND 49.9999
      THEN '40-50 Years'
      WHEN ROUND((to_date("a_date") - PEO.DATE_OF_BIRTH)/365.25,2) > 50.0000
      THEN '> 50 Years'
      ELSE 'No DOB'
    END AS "Age Band",
    CASE
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END <= 0.5000
      THEN '0-6 months'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END BETWEEN 0.5001 AND 1.0000
      THEN '6-12 Months'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END BETWEEN 1.0001 AND 2.0000
      THEN '1-2 Years'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END BETWEEN 2.0001 AND 4.0000
      THEN '2-4 Years'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END BETWEEN 4.0001 AND 7.0000
      THEN '4-7 Years'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END >= 7.0001
      THEN '7+ Years'
      ELSE NULL
    END AS "Tenure Band",
    JOBS.ATTRIBUTE2 AS "Tech Designation",
    SUBSTR(jobs.name, INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1, (INSTR(jobs.name, '.', INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1))-(INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1)) as "Job Title",
   peo.PERSON_ID as "Person ID",
   asmt.SUPERVISOR_ID as "Manager ID",
   GRAD.NAME AS "Pay Grade",
   ASMT.CHANGE_REASON as "Change Reason",
   PEO.PERSON_TYPE_ID AS "Person Type",
   substr(jobs.name, 0, INSTR(jobs.name, '.')-1) as "Job Function",
   SUBSTR(jobs.name, INSTR(jobs.name, '.')+1, (INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1)-(INSTR(jobs.name, '.')+2)) AS "Job Family"
    --COUNT(DISTINCT peo.PERSON_ID) AS "CT"
  FROM RHEDW_STG.STG_EBS_PER_ALL_PPL_F peo,
    RHEDW_STG.STG_EBS_PER_ALL_ASSIGNMENTS_F ASMT,
    RHEDW_STG.STG_EBS_HR_LOCATIONS_ALL LOC,
    RHEDW_STG.STG_EBS_HR_ALL_ORGN_UNT ORG,
    RHEDW_STG.STG_EBS_PER_JOBS JOBS,
    RHEDW_STG.STG_EBS_PER_GRADES GRAD,
    RHEDW.DW_GENERIC_LKP HR_CC_DEPT_MAP,
    RHEDW.DW_GENERIC_LKP HR_LOC_REGION_MAP,
    RHEDW.DW_GENERIC_LKP HR_LOC_COUNTRY_MAP,
    RHEDW_STG.STG_EBS_PER_PERIODS_OF_SERVICE SVC,
    (SELECT DISTINCT to_date('01-' || SUBSTR(add_months(:StartDate,-1) + LEVEL, 4, 6)) AS "a_date" -- Start date
      --last_day(add_months(:StartDate_Active,-1) + LEVEL) AS "a_date"
    FROM dual
    WHERE --last_day(add_months(:StartDate_Active,                                     -1) + LEVEL) <= :EndDate
   to_date('01-' || SUBSTR(add_months(:StartDate,-1) + LEVEL, 4, 6)) <= :EndDate 
      --CONNECT BY LEVEL                                        <= add_months(:EndDate,+2) - add_months(:StartDate_Active,-1)
   CONNECT BY LEVEL                                        <= add_months(:EndDate,+2) - add_months(:StartDate,-1)
    )
  WHERE PEO.current_employee_flag = 'Y'
  AND "a_date" BETWEEN ASMT.EFFECTIVE_START_DATE AND ASMT.effective_end_date
  AND ASMT.PRIMARY_FLAG                  = 'Y'
  AND PEO.STG_DEL_FLG                   <> 'Y'
  AND ASMT.STG_DEL_FLG                  <> 'Y'
  AND LOC.STG_DEL_FLG                   <> 'Y'
  AND SVC.STG_DEL_FLG(+)                <> 'Y'
  AND JOBS.STG_DEL_FLG                  <> 'Y'
  AND HR_CC_DEPT_MAP.DELETED_FLG(+)     <> 'Y'
  AND HR_LOC_REGION_MAP.DELETED_FLG(+)  <> 'Y'
  AND HR_LOC_COUNTRY_MAP.DELETED_FLG(+) <> 'Y'
  AND ASMT.EMPLOYMENT_CATEGORY          IN('FR','PR')
  AND to_date("a_date") < trunc(sysdate)
  AND PEO.PERSON_ID                      = ASMT.PERSON_ID
  AND ASMT.PERIOD_OF_SERVICE_ID          = SVC.PERIOD_OF_SERVICE_ID(+)
  AND ASMT.LOCATION_ID                   = LOC.LOCATION_ID
  AND ASMT.ORGANIZATION_ID               = ORG.ORGANIZATION_ID
  AND ASMT.ASSIGNMENT_TYPE               = 'E'
  AND ASMT.JOB_ID                        = JOBS.JOB_ID
  AND ASMT.GRADE_ID = GRAD.GRADE_ID
  AND JOBS.NAME NOT                     IN('Unclassified.Intern.Intern.INTRN','Unclassified.Contractor.Unpaid Intern.999')
    /*Grouping by Department*/
  AND HR_CC_DEPT_MAP.SUBJECT_AREA_NM(+) IN('HR')
  AND HR_CC_DEPT_MAP.LIST_NM(+)         IN('HR_CC_DEPT_MAP')
  AND HR_CC_DEPT_MAP.EXPRTN_DT(+)        = TO_DATE('99991231', 'yyyymmdd')
  AND HR_CC_DEPT_MAP.LIST_VALUE_CD(+)    = SUBSTR(ORG.NAME, -3)
    --+++++++++++++++++++++++++++++
    /*Grouping by Region*/
  AND HR_LOC_REGION_MAP.SUBJECT_AREA_NM(+) IN('HR')
  AND HR_LOC_REGION_MAP.LIST_NM(+)         IN('HR_LOC_REGION_MAP')
  AND HR_LOC_REGION_MAP.EXPRTN_DT(+)        = TO_DATE('99991231', 'yyyymmdd')
  AND LOC.LOCATION_CODE                     =HR_LOC_REGION_MAP.LIST_VALUE_CD(+)
    --+++++++++++++++++++++++++++++
    /*Grouping by Country*/
  AND HR_LOC_COUNTRY_MAP.SUBJECT_AREA_NM(+) IN('HR')
  AND HR_LOC_COUNTRY_MAP.LIST_NM(+)         IN('HR_LOC_COUNTRY_MAP')
  AND HR_LOC_COUNTRY_MAP.EXPRTN_DT(+)        = TO_DATE('99991231', 'yyyymmdd')
  AND LOC.LOCATION_CODE                      =HR_LOC_COUNTRY_MAP.LIST_VALUE_CD(+)
    --+++++++++++++++++++++++++++++
  AND "a_date" BETWEEN peo.effective_start_date AND peo.EFFECTIVE_END_DATE
  GROUP BY
    CASE
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
      THEN 'FY'
        || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
      ELSE 'FY'
        || TO_CHAR(to_date("a_date"),'yy')
    END,
    CASE
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 5
      THEN 'Q1'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 6
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 8
      THEN 'Q2'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 9
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 11
      THEN 'Q3'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 12
      OR to_number(TO_CHAR(to_date("a_date"),'mm'))   <= 2
      THEN 'Q4'
      ELSE 'UNSPECIFIED'
    END,
    CASE
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 5
      THEN
        CASE
          WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
          THEN 'FY'
            || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
          ELSE 'FY'
            || TO_CHAR(to_date("a_date"),'yy')
        END
        || 'Q1'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 6
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 8
      THEN
        CASE
          WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
          THEN 'FY'
            || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
          ELSE 'FY'
            || TO_CHAR(to_date("a_date"),'yy')
        END
        || 'Q2'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 9
      AND to_number(TO_CHAR(to_date("a_date"),'mm'))  <= 11
      THEN
        CASE
          WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
          THEN 'FY'
            || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
          ELSE 'FY'
            || TO_CHAR(to_date("a_date"),'yy')
        END
        || 'Q3'
      WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 12
      OR to_number(TO_CHAR(to_date("a_date"),'mm'))   <= 2
      THEN
        CASE
          WHEN to_number(TO_CHAR(to_date("a_date"),'mm')) >= 3
          THEN 'FY'
            || TO_CHAR(to_number(TO_CHAR(to_date("a_date"),'yy')) + 1)
          ELSE 'FY'
            || TO_CHAR(to_date("a_date"),'yy')
        END
        || 'Q4'
      ELSE 'UNSPECIFIED'
    END,
    "a_date",
    CASE
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('BA', 'Legal')
      THEN 'Legal'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('BoD/Exec', 'Finance')
      THEN 'Finance &'
        || ' Exec'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Facilities')
      THEN 'GWS'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('R&'
        || 'D', 'GES')
      THEN 'R&'
        || 'D'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GLS')
      THEN 'GLS'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GPS', 'SDM')
      THEN 'Consulting'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('GSS')
      THEN 'CEE'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('IT')
      THEN 'IT'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Marketing')
      THEN 'Marketing'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Operations')
      THEN 'Operations'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('People')
      THEN 'People'
      WHEN HR_CC_DEPT_MAP.LIST_VALUE_LONG_DESC IN('Sales')
      THEN 'Sales'
      ELSE 'UNSPECIFIED'
    END,
    HR_LOC_REGION_MAP.LIST_VALUE_LONG_DESC,
    HR_LOC_COUNTRY_MAP.LIST_VALUE_LONG_DESC,
   substr(ORG.NAME, -3),
    --LOC.TOWN_OR_CITY,
    LOC.LOCATION_CODE,
    PEO.SEX,
    CASE
      WHEN ASMT.MANAGER_FLAG = 'Y'
      THEN 'Y'
      ELSE 'N'
    END,
    CASE
      WHEN ROUND((to_date("a_date") - PEO.DATE_OF_BIRTH)/365.25,2) < 30.0000
      THEN '< 30 Years'
      WHEN ROUND((to_date("a_date") - PEO.DATE_OF_BIRTH)/365.25,2) BETWEEN 30.0000 AND 39.9999
      THEN '30-40 Years'
      WHEN ROUND((to_date("a_date") - PEO.DATE_OF_BIRTH)/365.25,2) BETWEEN 40.0000 AND 49.9999
      THEN '40-50 Years'
      WHEN ROUND((to_date("a_date") - PEO.DATE_OF_BIRTH)/365.25,2) > 50.0000
      THEN '> 50 Years'
      ELSE 'No DOB'
    END,
    CASE
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END <= 0.5000
      THEN '0-6 months'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END BETWEEN 0.5001 AND 1.0000
      THEN '6-12 Months'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END BETWEEN 1.0001 AND 2.0000
      THEN '1-2 Years'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END BETWEEN 2.0001 AND 4.0000
      THEN '2-4 Years'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END BETWEEN 4.0001 AND 7.0000
      THEN '4-7 Years'
      WHEN
        CASE
          WHEN SVC.ADJUSTED_SVC_DATE IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.ADJUSTED_SVC_DATE)/365.25,4)
          WHEN SVC.DATE_START IS NOT NULL
          THEN ROUND((to_date("a_date") - SVC.DATE_START)/365.25,4)
          ELSE ROUND((to_date("a_date") - PEO.ORIGINAL_DATE_OF_HIRE)/365.25,4)
        END >= 7.0001
      THEN '7+ Years'
      ELSE NULL
    END,
    JOBS.ATTRIBUTE2,
    SUBSTR(jobs.name, INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1, (INSTR(jobs.name, '.', INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1))-(INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1)),
   peo.PERSON_ID,
   asmt.SUPERVISOR_ID,
   GRAD.NAME,
   ASMT.CHANGE_REASON,
   PEO.PERSON_TYPE_ID,
   ORG.NAME,
   substr(jobs.name, 0, INSTR(jobs.name, '.')-1),
   SUBSTR(jobs.name, INSTR(jobs.name, '.')+1, (INSTR(jobs.name, '.', INSTR(jobs.name, '.')+1)+1)-(INSTR(jobs.name, '.')+2))
  ORDER BY "a_date"
  )
GROUP BY "Fiscal Year",
  "Fiscal Quarter",
  "Fiscal Year_Qtr",
  "a_date",
  "Dept by CC",
  "Cost Center",
  "Region",
  "Gender",
  "Country",
  "Location",
  "Manager Flag",
  "Age Band",
  "Tenure Band",
  "Tech Designation",
  "Job Title",
  "Person ID",
  "Manager ID",
  "Pay Grade",
  "Change Reason",
  "Person Type",
  "Organization",
  "Job Function",
  "Job Family";
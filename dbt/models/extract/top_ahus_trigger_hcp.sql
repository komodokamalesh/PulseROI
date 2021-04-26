{{
  config(
    materialized='table', 
    transient=false
  	)
}}

--filter top hcps that deal with ahus

select hcp_1_npi
, count (distinct upk_key2) as patient_count
from {{ref('ahus_mx_encounters')}}
where hcp_1_npi is not null
group by hcp_1_npi
order by patient_count DESC
limit 1000
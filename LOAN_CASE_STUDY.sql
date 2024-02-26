select count(id) as total_loan from loan
-----------------
select count(id) as total_loan_mtd from loan 
where MONTH(issue_date)='12' AND YEAR(issue_date)=2021
-------------------
---total  loan amount  given
select SUM(loan_amount) total_amount_funded  from loan
where MONTH(issue_date)='12' AND YEAR(issue_date)=2021
--- total loan amount receiced 
select SUM(total_payment)  total_amount_received  from loan
---avg intrest  rate 
select ROUND(AVG(int_rate),4)*100 interest_rate  from loan
--MTD intrest  rate 
select ROUND(AVG(int_rate),4)*100 interest_rate  from loan
where MONTH(issue_date)='12' AND YEAR(issue_date)=2021
---------------
---average dti from the loan  data 
select Round(AVG(dti),4)*100  as avg_dti  from loan 




-------------- Good loan vs Bad loan

---  good loan  anaylsis

--per
select 
(COUNT(CASE WHEN loan_status='Fully Paid' OR  loan_status='Current' Then id end) *100 )
/
COUNT(id) as  good_loan_percentage
from loan
-- total  good loans 
select  count(id) good_loan_application from loan
where loan_status='Fully Paid' or loan_status='Current'
-- funded  amount
select  SUM(loan_amount)  Good_loan_Application  from loan
where loan_status='Fully Paid' or loan_status='Current'
-- total  got back
select  SUM(total_payment)  Good_loan_Application  from loan
where loan_status='Fully Paid' or loan_status='Current'
---- bad
--%
select 
(COUNT(CASE WHEN  loan_status='Charged Off ' Then id end) *100 )
/
COUNT(id) as  bad_loan_percentage
from loan

----
select  count(id) bad_loan_application from loan
where  loan_status='Charged Off'
-- bad loan funded amount 
select  SUM(loan_amount)  Bad_loan_Amount from loan
where loan_status='Charged Off'
------ total  get back 
select  SUM(total_payment)  Good_loan_Application  from loan
where loan_status='Charged Off'


-----------loan  status analysis 

select loan_status,
Count(id) total_loan, 
Sum(loan_amount) total_loan_received,
AVG(int_rate*100)  intrest_rate,
AVG(dti*100) as DTI 
from loan 
group by loan_status
----------Month wise analysis of the loan 

select 
MONTH(issue_date),
DATENAME(Month,issue_date) month_name,
COUNT(id) as total_loan_amount,
SUM(loan_amount)  as total_funded_amount,
SUM(total_payment) as total_received_amount
from loan 
group by DATENAME(Month,issue_date),MONTH(issue_date)
order by  Month(issue_date)

---region wise ananlysis 

select address_state,
COUNT(id) as total_loan_amount,
SUM(loan_amount)  as total_funded_amount,
SUM(total_payment) as total_received_amount
from 
loan 
group by address_state
order by address_state desc
---------- term wise  analysis 
select term,
COUNT(id) as total_loan_amount,
SUM(loan_amount)  as total_funded_amount,
SUM(total_payment) as total_received_amount
from 
loan 
group by term 
order by term 

----
----------purpose wise analysis 
select purpose,
COUNT(id) as total_loan_amount,
SUM(loan_amount)  as total_funded_amount,
SUM(total_payment) as total_received_amount
from 
loan 
group by purpose
order by COUNT(id) desc 
---hous wise analysis 
select home_ownership,
COUNT(id) as total_loan_amount,
SUM(loan_amount)  as total_funded_amount,
SUM(total_payment) as total_received_amount
from 
loan 
group by home_ownership
order by COUNT(id) desc 
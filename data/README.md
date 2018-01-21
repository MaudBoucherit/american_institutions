# American Institutions App - Data
This folder contains the raw dataset of the American Institutions App.

Maud Boucherit, Jan 2018   

## Description of the data

I will be visualizing a dataset of approximately 7,800 American post-secondary institutions. The data were collected regarding the academic year 2015-2016. It contains 31 variables that provide basic descriptive information about it (name, location, private status), the average annual cost of attendance, information about the student body (share of women, ethnic distribution, incomes distribution), the number of students having financial aid, if college was completed, and average and median earnings of former students, from 6 to 10 years after graduation.    

These data come from federal reporting from institutions, data on federal financial aid, and tax information.   
The full original dataset can be found [here](https://collegescorecard.ed.gov/data/) along with the documentation report and the data dictionary.   

## Data dictionary

#### About the school

Some information about the school itself and its location:
- Name,
- City,
- State,
- Locale: its neighborhood, either 'City', 'Suburb', 'Town' or 'Rural',
- Control: if the institution is private or public.

#### About the cost of attendance

Some information about the cost of attendance, the financial aids and the repayment:
- Cost_att: the annual cost of attendance,
- Federal_loan: the proportion of students with a federal student loan,
- Pell_Grant: the proportion of student with a Pell Grant,
- Monthly_debt: median debt of completers expressed in 10-year monthly payments.

#### About the student body

Some information about the students attending the school:
- Women: the proportion of female students,
- Dependent: the proportion of dependent students,
- Married: the proportion of married students,
- pct_white, pct_black, pct_hispanic, pct_asian: the proportion of students per ethnic group,
- Low_income: aided students with family incomes less than $30,000,
- Mid1_income: aided students with family incomes between $30,001-$48,000,
- Mid2_income: aided students with family incomes between $48,001-$75,000,
- High1_income: aided students with family incomes between $75,001-$110,000,
- High2_income: aided students with family incomes more than $110,001,

#### About the earnings

Some information about the completion and earnings:
- Completion_rate,
- Mean_earning_*: mean earnings for completers * years after entry, where * is between 6 and 10,
- Mean_earning_male_6, Mean_earning_female_6: mean earnings by gender 6 years after entry,
- Mean_earning_male_10, Mean_earning_female_10: mean earnings by gender 10 years after entry.

## The states dictionnary

The states dictionnary [states.csv](states.csv) contains the postal state code and the state complete name of each state or American territory from the scorecard dataset.

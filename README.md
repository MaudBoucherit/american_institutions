<h1 align="center">
  <br>
American Institutions App
<br>
</h1>

![](figures/america.jpg)

<h4 align="center"><a>
Created by Maud Boucherit

January 2018
</a></h4>

<h4 align="center"><a>

[![R Version](https://img.shields.io/badge/R%20Version-%3E%3D%203.4-blue.svg)](https://cran.r-project.org/) 
[![License](https://img.shields.io/badge/License-MIT-orange.svg)](LICENSE.md) 

</a></h4>


A Shiny app that displays information about American institutions.

App: https://maudboucherit.shinyapps.io/american_institutions/

## Overview

When applying for post-secondary education, one first needs to select some school of interest. But the United States provides plenty universities and colleges. So American students can feel lost. How can they choose among all these choices? To help students make this important decision, I propose building a data visualization app that allows them to compare institutions all over the United States. They can put in relation tuition costs and future earning records. They can find records of past federal financial aid. They can also explore some demographic information about the student body, like the proportion of students by ethnicity, by gender, or even the average entry age.

## Data

I am using the [scorecard](data/scorecard.csv) dataset.   
More information about this dataset is available [here](data/README.md).

## Usage scenario & tasks

Michael is 17 years old. He is currently attending high school in Santa Fe and wants to attend college next year. To choose which school matches his demands, Michael needs to [filter] institutions according to his criteria and then [compare] them on some variables of interest. He also wants to [discover] more precise information about this or that school in particular. By using the American Institutions App, Michael can specify information about his dreamed school like the state, the local area or the control of the institution (public/private). He can also select a range for the annual cost of attendance. He will then see an overview of general information about each school matching his selection. He can compare universities about their student bodies like the ethnic diversity and the proportion of undergraduates receiving a federal student loan.    
If Michael finds a school appealing, he can select it in the second section of the app to display new information. He can now see the completion and employment rates of this school, along with a progression plot showing the average earning of former students from 6 to 10 years after graduation. With the help of this app, Michael would be able to narrow down the number of schools matching his needs.

## Description of the app

You can find a detailed documentation of this app [here](DOCUMENTATION.md).

## Description

​	This repository contains problems for second stage of fifth annual SamCode programming contests and repositories used for scoring and ranking participants.

​	Contest was held at [Quera](https://quera.ir)

### Problems

​	This folder contains contest problems.

### base

​	This folder holds base code for running test on codes giving input and getting outputs.

​	This base is later modified to also calculate test score for each output.

### p1_test

​	This folder holds modified version of base code to run tests, giving input and calculate test score for output. (for problem 1)

### p2_test

​	This folder holds modified version of base code to run tests, giving input and calculate test score for output. (for problem 2)

### p3_test

​	This folder holds modified version of base code to run tests, giving input and calculate test score for output. (for problem 3)

### get_score.py

​	This python script turns teams test scores in their final test score for each individual test and then sums up results and stores them in one file.

### get_overall_score.py

​	This python script sums up scores of 3 test for each team then ranks them based on their score and store team names and their score (in descending order of score) in one file.
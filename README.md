# Calculating Sample Size for Reliability Studies

*David N Borg (1), Aaron JE Bach (2), Julia L O’Brien (3), Kristin L Sainani (4)*

Affiliations:
(1) Griffith University, Menzies Health Institute Queensland, The Hopkins Centre;
(2) Griffith University, National Climate Change Adaptation Research Facility (NCCARF);
(3) Queensland University of Technology, School of Mathematical Sciences;
(4) Stanford University, Department of Epidemiology and Population Health;

# Paper Aim
This article first reviews the exercise, sport, and rehabilitation literature to determine how frequently sample size calculations are reported in reliability studies using an intraclass correlation coefficent. We then explain how sample size calculations can be performed for such studies and provide sample size lookup tables to assist researchers with study planning.

# Data and Code
This repository contains two datasets and six R files. The dataset titled 'Reliability search_12-02-22.xlsx' contains all information extracted from the 92 studies surveyed. The dataset 'Confidence interval interpretation.xlsx' contains information related to the interpretation of 95% confidence intervals reported by 49/92 studies.

The R files are: the analysis reported in the main paper ('reliability-analysis-main-paper.R'), the analysis reported in supplement 1 ('reliability-analysis-supplement.R'), reanalysis of the example study in the paper ('borg-2018-reanalysis.R'), analysis of the 95% confidence intervals reported by 49/92 studies ('confidence-interval-interpretation.R'), and code to replicate figure 1 ('icc-null-sample-size-calculation.R'). We also include the Bonnet, Zou and Walter formulas to replicate the in text sample size equations ('Bonett-Zou-Walter-formulas.R').

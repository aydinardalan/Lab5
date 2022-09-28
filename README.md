Kolada’s API
================
Aydin Ardalan , Seyed Mehdi Mir Shojaei

<!-- README.md is generated from README.Rmd. Please edit that file -->

# Lab5

<!-- badges: start -->

[![R-CMD-check](https://github.com/aydinardalan/Lab5/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/aydinardalan/Lab5/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Repository for the course Advanced Programming in R at Linköping
University. Assignment 5.

We are going to use the Kolada API using JSON, the API has a
documentation and follows the REST principle. The documentation can be
found here.

A Tutorial how to consume a REST-API in R can be found here.

The packages needed are httr for the HTTP communication and jsonlite for
mapping JSON data to data.frames.

## Installation

You can install the development version of Lab5 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aydinardalan/Lab5")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(Lab5)
#> Warning: replacing previous import 'jsonlite::validate' by 'shiny::validate'
#> when loading 'Lab5'
Municipality("lund")
#>     id title type
#> 1 1281  Lund    K
head(Municipality_groups("1280"))
#>               id municipality                     title
#> 1 V11E1280128053         1280 AL- SALAMAH SPRÅKFÖRSKOLA
#> 2 V11E1280128054         1280           ALMENS FÖRSKOLA
#> 3 V11E1280128055         1280       ALMGÅRDENS FÖRSKOLA
#> 4 V11E1280128056         1280   ALMVIKSGÅRDENS FÖRSKOLA
#> 5 V11E1280128057         1280        ALMÄNGENS FÖRSKOLA
#> 6 V11E1280128058         1280        ANNELUNDS FÖRSKOLA
kpi("kvinnofridskränkning")
#>   auspices
#> 1        X
#>                                                                                                                                                                    description
#> 1 Anmälda brott mot grov kvinnofridskränkning i kommunen, antal/100 000 inv. Statistiken redovisas efter den kommun där brottet har begåtts (brottsplats). Källa: BRÅ och SCB.
#>   has_ou_data     id is_divided_by_gender municipality_type operating_area
#> 1       FALSE N07402                    0                 K     Befolkning
#>   ou_publication_date perspective prel_publication_date publ_period
#> 1                  NA      Övrigt                    NA        2022
#>   publication_date
#> 1       2023-02-22
#>                                                                      title
#> 1 Anmälda brott om grov kvinnofridskränkning i kommunen, antal/100 000 inv
kpi_groups("kostnad")
#>            id
#> 1 G2KPI168155
#> 2 G2KPI171247
#> 3  G2KPI74526
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    members
#> 1                                                                                                                                                                                                                                               N11024, N11038, N13020, N13032, N15001, N15045, N17001, N17030, N20029, N20900, N28016, N28018, N28021, N28026, N30001, N30026, Nettokostnadsavvikelse förskola inkl. öppen förskola, (%), Nettokostnadsavvikelse förskola inkl öppen förskola, miljoner kronor, Nettokostnadsavvikelse fritidshem inkl. öppen fritidsverksamhet, (%), Nettokostnadsavvikelse fritidshem, inkl. öppen fritidsverksamhet, miljoner kronor, Nettokostnadsavvikelse grundskola F-9, (%), Nettokostnadsavvikelse grundskola F-9, miljoner kronor, Nettokostnadsavvikelse gymnasieskola, (%), Nettokostnadsavvikelse gymnasieskola, miljoner kronor, Nettokostnadsavvikelse äldreomsorg, miljoner kronor, Nettokostnadsavvikelse äldreomsorg, (%), Nettokostnad funktionsnedsättning LSS och SFB, kr/inv, Nettokostnadsavvikelse LSS, (%), Nettokostnadsavvikelse LSS, miljoner kronor, Referenskostnad LSS, kr/inv, Nettokostnadsavvikelse individ- och familjeomsorg, (%), Nettokostnadsavvikelse individ- och familjeomsorg, miljoner kronor
#> 2 N00095, N00096, N03066, N03067, N05002, N05010, N07036, N07037, N09018, N09022, N09100, N09102, N10037, N10038, N20001, N20011, N30005, N30101, N40007, N40008, N40010, N40011, N45030, N45031, Kostnad egentlig verksamhet, kr/inv, Nettokostnad egentlig verksamhet, kr/inv, Kostnad kommunens verksamhet totalt, kr/inv, Nettokostnad kommunens verksamhet totalt, kr/inv, Nettokostnad politisk verksamhet, kr/inv, Kostnad politisk verksamhet, kr/inv, Kostnad infrastruktur, skydd mm, kr/inv, Nettokostnad infrastruktur, skydd m.m., kr/inv, Nettokostnad fritidsverksamhet, kr/inv, Nettokostnad kulturverksamhet, kr/inv, Kostnad kulturverksamhet, kr/inv, Kostnad fritidsverksamhet, kr/inv, Kostnad pedagogisk verksamhet, kr/inv, Nettokostnad pedagogisk verksamhet, kr/inv, Kostnad äldre och funktionsnedsättning (SoL, LSS, SFB), kr/inv, Nettokostnad äldre och funktionsnedsättning (SoL, LSS, SFB), kr/inv, Nettokostnad individ- och familjeomsorg, kr/inv, Kostnad individ- och familjeomsorg, kr/inv, Kostnad flyktingmottagande, kr/inv, Kostnad arbetsmarknadsåtgärder, kr/inv, Nettokostnad flyktingmottagande, kr/inv, Nettokostnad arbetsmarknadsåtgärder, kr/inv, Kostnad affärsverksamhet, kr/inv, Nettokostnad affärsverksamhet, kr/inv
#> 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            N60007, N70059, N70060, N70061, N80043, N85012, U70020, Nettokostnad politisk verksamhet, kr/inv, Nettokostnad läkemedel, totalt (exkl. tandvård), kr/inv, Nettokostnad hälso- och sjukvård (exkl. tandvård), kr/inv, Nettokostnad hälso- och sjukvård totalt (inkl. läkemedel), kr/inv, Nettokostnad tandvård, kr/inv, Nettokostnad regional utveckling totalt, kr/inv, Strukturjusterad hälso- och sjukvårdskostnad, kr/inv
#>                              title
#> 1           Nettokostnadsavvikelse
#> 2 Kostnader för olika verksamheter
#> 3             Verksamhetskostnader
advancedSearch(kpi_list="N07402",municipality_list="1281",year_list=2021)
#>      kpi municipality period          values
#> 1 N07402         1281   2021 1, T, , 6.28061
```

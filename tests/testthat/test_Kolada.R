# Examples for testing:
municipality = "lund"
mun_group = "skola"
kpi = "kvinnofridskränkning"
kpi_group = "kostnad"
search_res = list(kpi_list = list("N00945"), year_list = list(2009,2010))

## Testing user inputs
test_that("Municipalities has wrong user input", {
  expect_error(Municipality("c", 2000))
  expect_error(Municipality(25, "c"))
  expect_error(Municipality(25, list(2000, 2019, 2011)))
  expect_error(Municipality(list(2000, 2001, 2002), 2010))
  expect_error(Municipality(data.frame(), 2000))
  expect_error(Municipality(25, list()))
})

test_that("Wrong user input is detected from kpi()", {
  expect_error(kpi("N00700", 1281, list(2018, 2019, 2020)))
  expect_error(gkpi(c("N00700,U00405"), 1281, list(2018, 2019, 2020)))
  expect_error(kpi(list("N00700,U00405"), 1281, c(2018, 2019, 2020)))
  expect_error(kpi(list("N00700,U00405"), c(1281, 1281), list(2018, 2019, 2020)))
  expect_error(kpi(list("N00700,U00405"), data.frame(), list(2018, 2019, 2020)))
  expect_error(kpi(list(), 1281, list(2018, 2019, 2020)))
  expect_error(kpi("N00700", 1281))
  expect_error(kpi("N00700", c()))
  expect_error(kpi(list(), 1281))
})

test_that("Wrong user input is detected from municipality groups", {
  expect_error(Municipality_groups("N00700", 1281, list(2018, 2019, 2020)))
  expect_error(Municipality_groups(c("N00700,U00405"), 1281, list(2018, 2019, 2020)))
  expect_error(Municipality_groups(list("N00700,U00405"), 1281, c(2018, 2019, 2020)))
  expect_error(Municipality_groups(list("N00700,U00405"), c(1281, 1281), list(2018, 2019, 2020)))
  expect_error(Municipality_groups(list("N00700,U00405"), data.frame(), list(2018, 2019, 2020)))
  expect_error(Municipality_groups(list(), 1281, list(2018, 2019, 2020)))
  expect_error(Municipality_groups("N00700", 1281))
  expect_error(Municipality_groups("N00700", c()))
  expect_error(Municipality_groups(list(), 1281))
})

test_that("Wrong user input is detected from search", {
  expect_error(advancedSearch("N00914", 1440, list(2010, 2011, 2012)))
  expect_error(advancedSearch(c("N00914,U00405"), 1440, list(2010, 2011, 2012)))
  expect_error(advancedSearch(list("N00914,U00405"), 1440, c(2010, 2011, 2012)))
  expect_error(advancedSearch(list("N00914,U00405"), c(1440, 1440), list(2010, 2011, 2012)))
  expect_error(advancedSearch(list("N00914,U00405"), data.frame(), list(2010, 2011, 2012)))
  expect_error(advancedSearch(list(), 1440, list(2010, 2011, 2012)))
  expect_error(advancedSearch("N00914", 1440))
  expect_error(advancedSearch("N00914", c()))
  expect_error(advancedSearch(list(), 1440))
})

## Testing functionality
test_that("Municipality() is working", {
  df = Municipality(municipality)
  expect_true(is.list(df))
  expect_true(is.character(df$id))
  expect_true(is.character(df$title))
  expect_true(is.character(df$type))
})

test_that("kpi() is working", {
  df = kpi(kpi)
  expect_true(is.list(df))
  expect_true(is.character(df$auspices))
  expect_true(is.character(df$municipality_type))
  expect_true(is.character(df$perspective))
  expect_true(is.numeric(df$is_divided_by_gender))
  expect_true(is.character(df$title))
})

test_that("Municipality_groups() is working", {
  df = Municipality_groups(mun_group)
  expect_true(is.list(df))
  expect_true(is.character(df$id))
  expect_true(is.character(df$type))
  expect_true(is.character(df$title))
})

test_that("kpi_groups() is working", {
  df = kpi_groups(kpi_group)
  expect_true(is.list(df))
  expect_true(is.character(df$id))
  expect_true(is.list(df$members))
  expect_true(is.character(df$title))
})

test_that("advancedSearch() is working", {
  df = advancedSearch(kpi_list= search_res$kpi_list, year_list= search_res$year_list)
  expect_true(is.list(df))
  expect_true(is.character(df$kpi))
  expect_true(is.character(df$municipality))
  expect_true(is.numeric(df$period))
  expect_true(is.list(df$values))
})


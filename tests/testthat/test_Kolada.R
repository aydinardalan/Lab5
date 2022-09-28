# context("Kolada")
# require(httr)
# require(jsonlite)

# Examples for testing:
mun = "lund"
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

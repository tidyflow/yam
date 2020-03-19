
get_pressures <- function(locations = NULL, water_body = NULL) {
  if (!is.null(water_body)) {
    water_body <- paste("RR49_WATER_BODY_PRESSURES.WATER_BODY_ID = '", paste(unique(water_body), sep = ""), "' ", sep = "")
  } else {
    water_body <- paste0("RR49_WATER_BODY_PRESSURES.WATER_BODY_ID IS NOT NULL ")
  }

  if (!is.null(locations)) {
    locations <- paste("AND RR49_WATER_BODY_PRESSURES.LOCATION_CODE = '", paste(unique(locations), sep = ""), "' ", sep = "")
  } else {
    locations <- ""
  }

  query <- paste("SELECT *
  FROM RR49_WATER_BODY_PRESSURES
                 WHERE ",
                 locations,
                 water_body,
                 "",
                 sep = ""
  )
  query <- ROracle::dbSendQuery(channelRep(), paste(query))
  results <- ROracle::fetch(query)
  DBI::dbDisconnect(channelRep())
  return(results)
}
local SCHEMA = {
  primary_key = {"api_id", "identifier", "period", "period_date"},
  table = "ratelimiting_metrics",
  fields = {
    api_id = {type = "id", required = true, foreign = "apis:id"},
    identifier = {type = "string", required = true},
    period = {type = "string", required = true},
    period_date = {type = "timestamp", required = true}
  },
  marshall_event = function(self, t)
    return {}
  end
}

return {ratelimiting_metrics = SCHEMA}

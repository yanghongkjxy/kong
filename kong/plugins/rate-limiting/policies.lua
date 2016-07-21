local singletons = require "kong.singletons"
local cache = require "kong.tools.database_cache"
local ngx_log = ngx.log
local ngx_timer_at = ngx.timer.at

return {
  ["local"] = {
    increment = function(api_id, identifier, current_timestamp, value)
      error("TODO")
    end,
    usage = function(api_id, identifier, current_timestamp, name)
      error("TODO")
    end
  },
  ["cluster"] = {
    increment = function(api_id, identifier, current_timestamp, value)
      local incr = function(premature, api_id, identifier, current_timestamp, value)
        if premature then return end
        local _, stmt_err = singletons.dao.ratelimiting_metrics:increment(api_id, identifier, current_timestamp, value)
        if stmt_err then
          ngx_log(ngx.ERR, "failed to increment: ", tostring(stmt_err))
        end
      end

      local ok, err = ngx_timer_at(0, incr, api_id, identifier, current_timestamp, 1)
      if not ok then
        ngx_log(ngx.ERR, "failed to create timer: ", err)
      end
    end,
    usage = function(api_id, identifier, current_timestamp, name)
      local current_metric, err = singletons.dao.ratelimiting_metrics:find(api_id, identifier, current_timestamp, name)
      if err then
        return nil, err
      end
      return current_metric and current_metric.value or 0
    end
  }
}
local helpers = require "spec.02-integration.02-dao.helpers"
local Factory = require "kong.dao.factory"
local timestamp = require "kong.tools.timestamp"

helpers.for_each_dao(function(kong_config)
  if kong_config.database == "postgres" then
    describe("Increment with #"..kong_config.database, function()
      local factory
      setup(function()
        factory = Factory(kong_config)
        assert(factory:run_migrations())

        factory:truncate_tables()
      end)
      after_each(function()
        factory:truncate_tables()
      end)

      it("increments", function()
        local periods = timestamp.get_timestamps(timestamp.get_utc())

        local where = {
          api_id = "5b23a6d8-5a48-4119-a631-b29795e8a4fc",
          identifier = "some_identifier",
          period = "minute",
          period_date = periods.minute
        }

        local res, err = factory.ratelimiting_metrics:increment(10, where)
        assert.True(res)
        assert.is_nil(err)

        local res, err = factory.ratelimiting_metrics:find(where)
        assert.is_table(res)
        assert.is_nil(err)

        assert.equal(10, res.value)
        
        local res, err = factory.ratelimiting_metrics:increment(10, where)
        assert.True(res)
        assert.is_nil(err)

        local res, err = factory.ratelimiting_metrics:find(where)
        assert.is_table(res)
        assert.is_nil(err)

        assert.equal(20, res.value)
      end)
    end)
  end
end)

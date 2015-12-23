return {
  ["plugins_available"] = {type = "array",
    default = {"ssl", "jwt", "acl", "cors", "oauth2", "tcp-log", "udp-log", "file-log",
               "http-log", "key-auth", "hmac-auth", "basic-auth", "ip-restriction",
               "mashape-analytics", "request-transformer", "response-transformer",
               "request-size-limiting", "rate-limiting", "response-ratelimiting", "syslog", "loggly", "datadog"}
  },
  ["nginx_working_dir"] = {type = "string", default = "/usr/local/kong"},
  ["listen_address"] = {type = "string", default = "0.0.0.0"},
  ["proxy_port"] = {type = "number", default = 8000},
  ["proxy_ssl_port"] = {type = "number", default = 8443},
  ["admin_api_port"] = {type = "number", default = 8001},
  ["cluster_listening_port"] = {type = "number", default = 7946},
  ["cluster_rpc_listening_port"] = {type = "number", default = 7373},
  ["dns_resolver"] = {type = "string", default = "dnsmasq", enum = {"server", "dnsmasq"}},
  ["dns_resolvers_available"] = {
    type = "table",
    content = {
      ["server"] = {
        type = "table",
        content = {
          ["address"] = {type = "string", default = "8.8.8.8:53"}
        }
      },
      ["dnsmasq"] = {
        type = "table",
        content = {
          ["port"] = {type = "number", default = 8053}
        }
      }
    }
  },
  ["cluster"] = {
    type = "table",
    content = {
      ["auto-join"] = {type = "boolean", default = true},
      ["advertise"] = {type = "string", nullable = true},
      ["encrypt"] = {type = "string", nullable = true}
    }
  },
  ["database"] = {type = "string", default = "cassandra"},
  ["databases_available"] = {
    type = "table",
    content = {
      ["cassandra"] = {
        type = "table",
        content = {
          ["contact_points"] = {type = "array", default = {"localhost:9042"}},
          ["keyspace"] = {type = "string", default = "kong"},
          ["replication_strategy"] = {type = "string", default = "SimpleStrategy", enum = {"SimpleStrategy", "NetworkTopologyStrategy"}},
          ["replication_factor"] = {type = "number", default = 1},
          ["data_centers"] = {type = "table", default = {}},
          ["username"] = {type = "string", nullable = true},
          ["password"] = {type = "string", nullable = true},
          ["ssl"] = {
            type = "table",
            content = {
              ["enabled"] = {type = "boolean", default = false},
              ["verify"] = {type = "boolean", default = false},
              ["certificate_authority"] = {type = "string", nullable = true}
            }
          }
        }
      }
    }
  },
  ["ssl_cert_path"] = {type = "string", nullable = true},
  ["ssl_key_path"] = {type = "string", nullable = true},
  ["send_anonymous_reports"] = {type = "boolean", default = true},
  ["memory_cache_size"] = {type = "number", default = 128, min = 32},
  ["nginx"] = {type = "string", nullable = true}
}
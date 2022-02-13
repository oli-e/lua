-- config.lua
local config = require("lapis.config")

local config = require("lapis.config")
config("development", {
  mysql = {
    host = "127.0.0.1:3307",
    user = "",
    password = "",
    database = "MYDATABASE"
  }
})



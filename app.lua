local lapis = require("lapis")
local app = lapis.Application()

local Model = require("lapis.db.model").Model

local Products = Model:extend("products", {
    primary_key = {"product_id", "product_name"}
  })

local respond_to = require("lapis.application").respond_to

app:match("/", respond_to({
  GET = function(self)
    if self.params.product_id then 
      local product = Products:find(self.params.product_id)
      return product
    else
      local cols = Products:columns()
      return cols
    end
  end,
  DELETE = function(self)
    local product = Products:find(self.params.product_id)
    product:delete() 
  end,
  PUT = function(self)
    local product = Products:find(self.params.product_id)
    if self.params.product_id and self.params.product_name then
      product.product_id = self.params.product_id
      product.product_name = self.params.product_name
      product:update("product_id", "product_name")
    end
  end,
  POST = function(self)
    local newProduct = Products:create("products", {
      product_id = self.params.product_id,
      product_name = self.params.product_name
    })
    return "Product added!"
  end
}))

app:match("/hello", function(self)
  return { json = { hello = "world" } }
end)

return app
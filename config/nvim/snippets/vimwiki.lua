local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s({trig="diary", desc="This is a template for a diary entry in my vimwiki"},
  {
    t({"# " .. os.date("%Y-%m-%d"), ""}),
    t({"",""}),
    t({"* **"}),
    i(0),
    t({"**"}),
  })
}

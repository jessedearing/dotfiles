local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Insert a commment prefixed with a todo annotation defaulting to TODO and then suffixed with the name of the current user
return {
  s({trig="todo", desc="Insert a TODO comment"},
  {
    t({string.format(vim.bo.commentstring, "")}),
    i(2, "TODO"),
    t(" "),
    i(1),
    t({string.format(" <%s> %s", os.date("%Y-%m-%d"), vim.g.snips_author)}),
  })
}

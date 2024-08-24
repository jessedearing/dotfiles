local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Insert a commment prefixed with a todo annotation defaulting to TODO and then suffixed with the name of the current user
return {
  s({trig="todo", desc="Insert a TODO comment"},
  {
    f(function(_, snip)
      local MiniComment = require("mini.comment")
      local cursor = vim.api.nvim_win_get_cursor(0)
      return string.format(MiniComment.get_commentstring({cursor[1], cursor[2]+1}), "")
    end),
    i(2, "TODO"),
    t(" "),
    i(1),
    t({string.format(" <%s> %s", os.date("%Y-%m-%d"), vim.g.snips_author)}),
  })
}

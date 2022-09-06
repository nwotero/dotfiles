lvim.builtin.which_key.mappings["l"]["L"] = {
  function()
    require("lsp_lines").toggle()
  end,
  "Toggle LSP Lines"
}

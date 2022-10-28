lvim.builtin.which_key.mappings["l"]["L"] = {
  function()
    require("lsp_lines").toggle()
  end,
  "Toggle LSP Lines"
}
-- Disable virtual_text since it's redundant due to lsp_lines.
lvim.lsp.diagnostics.virtual_text = false

require'lspconfig'.ghdl_ls.setup{}

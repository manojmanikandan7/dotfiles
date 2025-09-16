return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofmt,
        require("none-ls.formatting.ruff"),
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.golangci_lint,
        require("none-ls.diagnostics.eslint"),
        require("none-ls.diagnostics.ruff"),
      },
    })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
  end,
}

return {
  {
    -- Indent lines
    "echasnovski/mini.indentscope",
    version = false,
    keys = {
      {
        "<C-M>i",
        function()
          vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
          if vim.g.miniindentscope_disable then
            vim.notify("Disabled indent scope", vim.log.levels.INFO)
          else
            vim.notify("Enabled indent scope", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle indentscope",
      },
    },
    event = "BufReadPre",
    opts = {
      draw = {
        delay = 50,
      },
      mappings = {
        goto_top = "",
        goto_bottom = "",
      },
      symbol = "│",
    },
    init = function()
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,

    -- use opts = {} for passing setup options
  },
}

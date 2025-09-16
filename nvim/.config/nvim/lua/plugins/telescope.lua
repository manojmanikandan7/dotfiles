return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            prompt_position = "top"
          }
        },
        -- pickers = {
        -- 	find_files = {
        -- 		theme = "dropdown",
        -- 	},
        -- 	live_grep = {
        -- 		theme = "dropdown",
        -- 	},
        -- 	oldfiles = {
        -- 		theme = "dropdown",
        -- 	},
        -- },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      require("telescope").load_extension("ui-select")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
    end,
  },
}

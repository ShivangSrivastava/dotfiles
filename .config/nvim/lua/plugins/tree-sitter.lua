return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/playground",
  },
  build = ":TSUpdateSync",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup {
      auto_install = true, highlight = { enable = true },
      indent = { enable = true },
      playground = {
        enable = true,
      },
    }
  end
}

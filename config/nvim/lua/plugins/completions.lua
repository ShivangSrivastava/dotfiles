return {
  {
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",     -- Snippet completions
      "rafamadriz/friendly-snippets", -- Predefined snippets
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP completions
          { name = "luasnip" },  -- Snippet completions
          { name = "path" },     -- File path completions
          { name = "buffer" },   -- Buffer content completions
        }),
      })

      -- Enable Python-specific snippet handling
      cmp.setup.filetype("python", {
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Python LSP completions
          { name = "luasnip" },  -- Python snippets
        }, {
          { name = "buffer" },   -- Buffer completions
        }),
      })
      cmp.setup.filetype('htmljinja', {
        sources = {
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },
}

-- ~/.config/nvim/lua/plugins/nvim-cpm.lua

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      return {
        snippet = {
          expand = function(args)
            vim.fn"vsnip#anonymous" -- Para usuarios de vsnip
            -- require('luasnip').lsp_expand(args.body) -- Para usuarios de luasnip
            -- require('snippy').expand_snippet(args.body) -- Para usuarios de snippy
            -- vim.fn"UltiSnips#Anon" -- Para usuarios de ultisnips
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- Para usuarios de vsnip
          -- { name = 'luasnip' }, -- Para usuarios de luasnip
          -- { name = 'ultisnips' }, -- Para usuarios de ultisnips
          -- { name = 'snippy' }, -- Para usuarios de snippy
        }, {
          { name = 'buffer' },
        })
      }
    end,
  }

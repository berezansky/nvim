require'keys/alias'

nm('<leader>gs', '<cmd>Gvdiffsplit!<cr>')
nm('<leader>gw', '<cmd>Gwrite<cr>')
nm('<leader>gdl', '<cmd>diffget //2<cr>')
nm('<leader>gdr', '<cmd>diffget //3<cr>')
nm('<leader>gl', '<cmd>GcLog -- %<cr>')

nm('gd', '<cmd>Telescope lsp_definitions<CR>')
nm('gi', '<cmd>Telescope lsp_implementations<CR>')
nm('gr', '<cmd>Telescope lsp_references<CR>')
nm('<leader>ff', '<cmd>Telescope find_files<CR>')
nm('<leader>fb', '<cmd>Telescope git_branches<CR>')
nm('<leader>fg', '<cmd>Telescope live_grep<CR>')
nm('<leader>d', '<cmd>Telescope diagnostics<CR>')

nm('<leader>nf', '<cmd>Neotree filesystem<cr>')
nm('<leader>nb', '<cmd>Neotree buffers<cr>')
nm('<leader>ng', '<cmd>Neotree git_status<cr>')
nm('<leader>nc', '<cmd>Neotree current reveal float<cr>')

nm('<leader>s', '<cmd>SymbolsOutline<cr>')
nm('<leader>e', '<cmd>Startify<CR>')

nm('<leader>Nf', '<cmd>Neogen func<cr>')
nm('<leader>Nt', '<cmd>Neogen type<cr>')
nm('<leader>Nc', '<cmd>Neogen class<cr>')

nm('<leader>du', '<cmd>DBUIToggle<CR>')
nm('<leader>df', '<cmd>DBUIFindBuffer<CR>')
nm('<leader>dr', '<cmd>DBUIRenameBuffer<CR>')
nm('<leader>dl', '<cmd>DBUILastQueryInfo<CR>')

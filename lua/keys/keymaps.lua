require'keys.alias'
require'keys.plugins'

im('jj', '<Esc>')
nm('<leader>w', '<cmd>write<CR>')
nm('<leader>q', '<cmd>quit<CR>')
nm('<leader><C-h>', '<cmd>Gsplit<CR>')
nm('<leader><C-v>', '<cmd>Gvsplit<CR>')
nm('<leader>vp', '<cmd>vertical resize +10<CR>')
nm('<leader>vm', '<cmd>vertical resize -10<CR>')
nm('<leader>hp', '<cmd>horizontal resize +10<CR>')
nm('<leader>hm', '<cmd>horizontal resize -10<CR>')
nm('<C-k>', '<C-w><Up>')
nm('<C-j>', '<C-w><Down>')
nm('<C-l>', '<C-w><Right>')
nm('<C-h>', '<C-w><Left>')
nm('<C-h>', '<C-w><Left>')
nm('<leader>ef', '<cmd>EslintFixAll<CR>')
nm('<leader>cs', '<cmd>colorscheme solarized<CR>')
nm('<leader>ct', '<cmd>colorscheme tokyonight-storm<CR>')

-- Clear Search
nm('//', '<cmd>:noh<cr>')

vim.keymap.set("n", "<leader>rs", function()
  vim.ui.input({ prompt = "Find and replace (separated by space): " }, function(input)
    if not input then return end
    local from, to = input:match("^(%S+)%s+(%S+)$")
    if from and to then
      vim.cmd(string.format("s/\\V%s/%s/g", from, to))
    else
      print("Please enter two words separated by a space")
    end
  end)
end, { desc = "Replace in line", noremap = true, silent = true })

vim.keymap.set("n", "<leader>ra", function()
  vim.ui.input({ prompt = "Find and replace (separated by space): " }, function(input)
    if not input then return end
    local from, to = input:match("^(%S+)%s+(%S+)$")
    if from and to then
      vim.cmd(string.format("%%s/\\V%s/%s/g", from, to))
    else
      print("Please enter two words separated by a space")
    end
  end)
end, { desc = "Replace in file", noremap = true, silent = true })

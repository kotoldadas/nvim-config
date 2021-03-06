vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  " augroup _lsp
  "   autocmd!
  "   autocmd BufWritePre * lua vim.lsp.buf.formatting()
  " augroup end
]])

local group = vim.api.nvim_create_augroup("Auto Formatting", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = vim.lsp.buf.formatting_sync,
    group = group
})

-- FileType dap-repl lua require('dap.ext.autocompl').attach()

vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-repl",
    callback = function()
        require("dap.ext.autocompl").attach()
    end,
})



-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end

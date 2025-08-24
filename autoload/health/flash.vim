
function! s:start(msg)
    execute $'lua vim.health.start("{a:msg}")'
endf

function! s:ok(msg)
    execute $'lua vim.health.ok("{a:msg}")'
endf

function! s:error(msg)
    execute $'lua vim.health.error("{a:msg}")'
endf

function! health#flash#check()
    call s:start("yeah")
    call s:ok("wow")
    call s:error("noo")
endf

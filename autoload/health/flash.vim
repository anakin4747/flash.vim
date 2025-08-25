
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
    if !executable("git")
        call s:error("git not installed")
    else
        call s:ok("found git")
    endif
endf


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
    call s:start("checking dependencies")

    for cmd in ['git', 'gh']
        if !executable(cmd)
            call s:error($"{cmd} not installed")
        else
            call s:ok($"found {cmd}")
        endi
    endfo

    call s:start("checking configuration")

    if !exists("g:flash_decks") || empty(g:flash_decks)
        call s:error("no decks configured")
    else
        call s:ok($'found decks:\n\t{join(flash#decks#get(), '\n\t')}')
    endi

    call system("gh auth status")
    if v:shell_error
        call s:error("not authenticated with gh")
    else
        call s:ok("authenticated with gh")
    endi

    call s:start("unit tests")
    call s:test_valid_deck()
endf

function! s:test_valid_deck()

    if !flash#decks#valid("good/deck")
        call s:error("good/deck failed validation")
    endi

    if flash#decks#valid("bad/deck/spec")
        call s:error("bad/deck/spec passed validation")
    endi

    if flash#decks#valid("/bad/deck/")
        call s:error("/bad/deck/ passed validation")
    endi

    if flash#decks#valid("bad")
        call s:error("'bad' failed validation")
    endi
endf

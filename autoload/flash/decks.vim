function! flash#decks#get(decks = get(g:, 'flash_decks'))
    return a:decks
endf

function! flash#decks#getlocal()
    return glob($'{stdpath("data")}/flash.vim/*/*')
        \ ->substitute($'{stdpath("data")}/flash.vim/', '', 'g')
        \ ->split()
endf

function! flash#decks#path(deck)
    return $'{stdpath("data")}/flash.vim/{a:deck}'
endf

function! flash#decks#url(deck)
    return $'https://github.com/{a:deck}'
endf

function! flash#decks#select(decks = flash#decks#get(), inputFunc = "inputlist")
    let indexed_decks = map(copy(a:decks), {i, deck -> printf('%d. %s', i, deck)})

    while v:true
        call flash#log#info("select deck:")
        let selected_index = call(a:inputFunc, [indexed_decks])

        let deck = get(a:decks, selected_index, "")

        if deck != ""
            return deck
        endi

        call flash#log#warning("bad selection")
    endw
endf

function! flash#decks#existsLocally(deck)
    if type(a:deck) != v:t_string
        return v:false
    endi

    if filereadable(flash#decks#path(a:deck))
        return v:true
    endi

    return v:false
endf

function! flash#decks#existsRemotely(deck)
    if type(a:deck) != v:t_string
        return v:false
    endi

    " head is used to send SIGPIPE to stop git earlier
    call system($"git ls-remote -q {flash#decks#url(a:deck)} | head -n1")

    if v:shell_error
        return v:false
    endi

    return v:false
endf

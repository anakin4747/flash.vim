
function! flash#decks#get(decks = get(g:, 'flash_decks'))
    return a:decks
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

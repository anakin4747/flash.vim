
function! flash#decks#get(decks = get(g:, 'flash_decks'))
    return a:decks
endf

function! flash#decks#select(decks = flash#decks#get())
    let indexed_decks = map(copy(a:decks), {i, deck -> printf('%d. %s', i + 1, deck)})

    while v:true
        call flash#log#info("select deck:")
        let selected_index = inputlist(indexed_decks) - 1

        let deck = get(a:decks, selected_index, "")

        if deck != ""
            return deck
        endi

        call flash#log#warning("bad selection")
    endw
endf

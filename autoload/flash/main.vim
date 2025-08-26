
function! flash#main#menu(deck)
    if empty(a:deck)
        call flash#log#info(flash#decks#select())
    else
        call flash#log#info(a:deck)
    endi
endf

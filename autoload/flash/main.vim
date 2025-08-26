
function! flash#main#menu(deck)
    if empty(a:deck)
        let deck = flash#decks#select()
    else
        let deck = a:deck
    endi

    if !flash#decks#existsLocally(deck) && !flash#util#ping()
        call flash#log#info($"{flash#decks#path(deck)} does not exist locally and could not ping 1.1.1.1")
        call flash#log#info("creating deck locally")
    elseif !flash#decks#existsLocally(deck) && !flash#decks#existsRemotely(deck)
        call flash#log#info($"{flash#decks#path(deck)} does not exist locally")
        call flash#log#info($"and {flash#decks#url(deck)} and does not exist remotely")
        call flash#log#info("creating deck locally")
    elseif !flash#decks#existsLocally(deck) && flash#decks#existsRemotely(deck)
        call flash#log#info($"{flash#decks#path(deck)} does not exist locally")
        call flash#log#info($"but {flash#decks#url(deck)} does exist remotely")
        call flash#log#info("cloning deck")
    elseif flash#decks#existsLocally(deck) && flash#decks#existsRemotely(deck)
        call flash#log#info($"{flash#decks#path(deck)} exists locally")
        call flash#log#info($"and {flash#decks#url(deck)} exists remotely")
        call flash#log#info("attempting to pull deck")
        " pull it but if pulling fails let user manage the git repo by telling
        " them where to find it on the system
    elseif flash#decks#existsLocally(deck) && !flash#decks#existsRemotely(deck)
        call flash#log#info($"{flash#decks#path(deck)} exists locally but does not exist remotely")
        call flash#log#info("please create the remote to save deck")
    endi

    " when to push? after making additions to deck

    " start going through the flash cards

endf

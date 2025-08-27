
function! flash#main#menu(deck) abort
    if empty(a:deck)
        let deck = flash#decks#select()
    else
        let deck = a:deck
    endi

    try
        if !flash#decks#existsLocally(deck) && !flash#util#ping()
            call flash#log#info($"{flash#decks#path(deck)} does not exist locally")
            call flash#log#info($"no internet: could NOT ping 1.1.1.1")
            call flash#log#info("creating deck locally")
            call flash#decks#create(deck)
        elseif !flash#decks#existsLocally(deck) && !flash#decks#existsRemotely(deck)
            call flash#log#info($"{flash#decks#path(deck)} does NOT exist locally")
            call flash#log#info($"{flash#decks#url(deck)} does NOT exist remotely")
            call flash#log#info("creating deck locally")
            call flash#decks#create(deck)
        elseif !flash#decks#existsLocally(deck) && flash#decks#existsRemotely(deck)
            call flash#log#info($"{flash#decks#path(deck)} does NOT exist locally")
            call flash#log#info($"{flash#decks#url(deck)} does exist remotely")
            call flash#log#info("cloning deck")
            call flash#decks#clone(deck)
        elseif flash#decks#existsLocally(deck) && flash#decks#existsRemotely(deck)
            call flash#log#info($"{flash#decks#path(deck)} exists locally")
            call flash#log#info($"{flash#decks#url(deck)} exists remotely")
            call flash#log#info("attempting to pull deck")
            call flash#decks#pull(deck)
            " pull it but if pulling fails let user manage the git repo by telling
            " them where to find it on the system
        endi
    catch "exit"
        call flash#log#info("exiting")
        return
    endt

    call flash#log#good("start deck")

    " when to push? after making additions to deck
    "
    " when to create remotes? after making additions to a deck, and there is
    " internet connect, confirm first before creating remote

    " start going through the flash cards

endf

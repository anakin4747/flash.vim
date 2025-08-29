
function! flash#main#menu(deck) abort
    if empty(flash#decks#get()) && empty(a:deck)
        call flash#log#warning("no decks configured or found locally")
        call flash#log#info("create a deck with `:Flash name-of/new-deck` or configure decks in g:flash_decks")
        call flash#log#info("exiting")
        return
    endi

    if empty(a:deck)
        let deck = flash#decks#select()
    else
        let deck = a:deck
        if deck == "clean"
            try
                " TODO: confirm with user first
                " TODO: report what was deleted
                call flash#log#info($"deleting all local decks and their contents")
                call delete($"{stdpath('data')}/flash.vim", "rf")
            catch
                call flash#log#warning($"failed to delete '{stdpath('data')}/flash.vim'")
            endt
            return
        endi
    endi

    try
        if !flash#decks#existsLocally(deck) && !flash#util#ping()
            call flash#log#info($"{flash#decks#path(deck)} does not exist locally")
            call flash#log#info($"no internet: could NOT ping 1.1.1.1")
            call flash#decks#create(deck)
        elseif !flash#decks#existsLocally(deck) && !flash#decks#existsRemotely(deck)
            call flash#log#info($"{flash#decks#path(deck)} does NOT exist locally")
            call flash#log#info($"{flash#decks#url(deck)} does NOT exist remotely")
            call flash#decks#create(deck)
        elseif !flash#decks#existsLocally(deck) && flash#decks#existsRemotely(deck)
            call flash#log#info($"{flash#decks#path(deck)} does NOT exist locally")
            call flash#log#info($"{flash#decks#url(deck)} does exist remotely")
            call flash#decks#clone(deck)
        elseif flash#decks#existsLocally(deck) && flash#decks#existsRemotely(deck)
            call flash#log#info($"{flash#decks#path(deck)} exists locally")
            call flash#log#info($"{flash#decks#url(deck)} exists remotely")
            call flash#decks#pull(deck)
            " pull it but if pulling fails let user manage the git repo by telling
            " them where to find it on the system
        endi

        call flash#log#good("start deck")

        call flash#decks#start(deck)

    catch "exit"
        call flash#log#info("exiting")
        return
    endt

    " when to push? after making additions to deck
    "
    " when to create remotes? after making additions to a deck, and there is
    " internet connect, confirm first before creating remote

    " start going through the flash cards

endf

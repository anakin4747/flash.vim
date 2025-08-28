function! flash#decks#get(decks = get(g:, 'flash_decks', []))
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

    if isdirectory(flash#decks#path(a:deck))
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

function! flash#decks#valid(deck)
    return type(a:deck) == v:t_string && a:deck =~ '^[^/]\+/[^/]\+$'
endf

function! flash#decks#create(deck)

    if !flash#decks#valid(a:deck)
        call flash#log#warning($"invalid deck name '{a:deck}'")
        throw "exit"
    endi

    let path = flash#decks#path(a:deck)
    call flash#log#info($"hit enter to create the deck '{a:deck}' locally: ")
    if nr2char(getchar()) != "\r"
        throw "exit"
    endi

    try
        call mkdir(path, "p")
    catch
        call flash#log#warning($"failed to create {path} for {a:deck}")
        throw "exit"
    endt

    let git_init_cmd = $'git -C {path} init -b main'
    let res = system(git_init_cmd)
    if v:shell_error
        call flash#log#warning($"failed to run '{git_init_cmd}'")
        call flash#log#warning($"result: '{res}'")
        throw "exit"
    endi

    call flash#log#good($"created {path} for {a:deck}")

    try
        call json_encode([])->split()->writefile($"{path}/cards.json")
    catch
        call flash#log#warning($"failed to create '{path}/cards.json'")
        throw "exit"
    endt
endf

function! flash#decks#createRemote(deck)
    call flash#log#info($"hit enter to create the deck '{a:deck}' remotely: ")
    if nr2char(getchar()) != "\r"
        throw "exit"
    endi

    let gh_repo_create_cmd = $"gh repo create {a:deck} --confirm {g:gh_repo_create_args}"

    let res = system(gh_repo_create_cmd)
    if v:shell_error
        call flash#log#warning($"failed to run '{gh_repo_create_cmd}'")
        call flash#log#warning($"result: '{res}'")
        throw "exit"
    endi
endf

function! flash#decks#clone(deck)
    call flash#log#warning("clone not yet implemented")
    throw "exit"
endf

function! flash#decks#pull(deck)
    call flash#log#warning("pull not yet implemented")
    throw "exit"
endf

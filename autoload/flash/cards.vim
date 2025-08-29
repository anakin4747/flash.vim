
function! flash#cards#create(cards, path)

    while v:true
        call flash#log#info("hit enter to create a new card ")
        if !flash#util#enter_hit()
            break
        endi

        let new_card = s:new_card()
        call flash#log#info($"new card: '{new_card}'")

        call flash#log#info("hit enter to save new card ")
        if !flash#util#enter_hit()
            break
        endi

        call extend(a:cards, new_card)

        call flash#log#info($"cards: '{a:cards}'")

        try
            call json_encode(a:cards)->split('\n')->writefile($"{a:path}/cards.json")
            call flash#log#good($"wrote cards to '{a:path}/cards.json'")
        catch
            call flash#log#warning($"failed to write to '{a:path}/cards.json'")
        endt

    endw

    return a:cards
endf

function! s:new_card()

    call flash#log#info("type new card's question:")
    let question = input("")

    let answers = []

    while v:true
        try
            call flash#log#info("type new card's answers (<C-c> to stop):")
            let answers += [input("")]
        catch
            break
        endt
    endw

    let card = [#{question: question, answers: answers}]

    call flash#log#good($"generated new card: {card}")

    return card
endf

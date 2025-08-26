" flash.vim - vim flash cards for learning French
"
" Author:    Anakin Childerhose
" Version:   0.1

" The main menu should first display a list of decks to choose from
"
" Where should the decks be? stdpath("data")
"
" Decks should be stored as git repos and any change to them should be made as
" an automatic commit that gets pushed to its remote
"
" Need to create functions for
"   - creating decks
"   - editing decks
"   - listing decks
"   - removing decks
"
" How will you configure the remote of the decks?
" How can you list the repos of decks you have already written?
"
"   a lua table of a list of decks like:
"
"   vim.g.flash_decks = {
"       "anakin4747/logement.deck",
"       "anakin4747/vêtements.deck"
"   }
"
" If there is no internet connection the plugin should only throw a warning
" and be able to operate the same without internet (only not able to push or
" pull)


" Commands {{{

function! s:completeDecks(ArgLead, CmdLine, CursorPos)
    return flash#decks#get()
endf

command! -nargs=? -complete=customlist,s:completeDecks Flash
    \ call flash#main#menu("<args>")

" }}}

" vim: foldmethod=marker


let s:repo = "flash.vim"

if !exists('s:hould_log')
    let s:hould_log = v:false
endi

function! flash#log#toggle()
    let s:hould_log = !s:hould_log
endf

function! flash#log#callingFunc(sfile = expand('<sfile>')) abort
    return a:sfile->substitute('function ', '', '')
                \ ->split('\.\.')[-2]
                \ ->substitute('^<SNR>\d\+_', 's:', '')
endf

function! flash#log#debug(msg)
    if !s:hould_log
        return
    endi

    echohl QuickFixLine
    echom $"{s:repo}: debug: {flash#log#callingFunc()}: {a:msg}"
    echohl None
endf

function! flash#log#info(msg)
    echohl ModeMsg
    echom $"{s:repo}: info: {a:msg}"
    echohl None
endf

function! flash#log#warning(msg)
    echohl WarningMsg
    echom $"{s:repo}: warning: {a:msg}"
    echohl None
endf

function! flash#log#error(msg)
    echohl ErrorMsg
    echom $"{s:repo}: error: {flash#log#callingFunc()}: {a:msg}"
    echohl None
endf

function! flash#log#good(msg)
    echohl Title
    echom $"{s:repo}: {a:msg}"
    echohl None
endf

function! flash#log#usage()
    call flash#log#good("usage:")
    "call flash#log#good(" first:")
    "call flash#log#good("   :D[bg] [ PROGRAM ] [ COREDUMP ]")
    "call flash#log#good("   :D[bg] [ PID ]")
    "call flash#log#good("   :D[bg] [ PROCESS_NAME ]")
    "call flash#log#good("   :D[bg] [ IP ] [ PORT ]")
    "call flash#log#good(" then:")
    "call flash#log#good("   :D[bg]")
endf

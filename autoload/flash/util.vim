
function! flash#util#ping()
    call flash#log#info("pinging 1.1.1.1 to check internet connectivity")

    call system("ping -c 1 1.1.1.1")

    if v:shell_error
        return v:false
    endi

    return v:true
endf

function! flash#util#enter_hit()
    return nr2char(getchar()) == "\r"
endf

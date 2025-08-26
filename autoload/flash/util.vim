
function! flash#util#ping()
    call system("ping -c 1 1.1.1.1")

    if v:shell_error
        return v:false
    endi

    return v:true
endf

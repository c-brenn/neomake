" vim: ts=4 sw=4 et

function! neomake#makers#ft#elm#EnabledMakers()
    return ['elmmake']
endfunction

function! neomake#makers#ft#elm#elmmake()
    " merge the error message and suggested fix
    let mapexpr = 'substitute(v:val, "\",\"subregion.*,\"details\":\""," ", "g")'
    return {
        \ 'exe': 'elm-make',
        \ 'args': ['--report=json', '--output=/dev/null'],
        \ 'mapexpr': mapexpr,
        \ 'errorformat':
            \ '[{"tag":"%.%#"\,' .
            \ '"overview":"%m"\,' .
            \ '%.%#\' .
            \ '"region":{"start":{"line":%l\,"column":%c' .
            \ '%.%#\,' .
            \ '"file":"%f"}]',
        \ 'cwd': '%:p:h',
        \ 'postprocess': function('FixNewLines'),
        \ 'buffer_output': 1
        \ }
endfunction

function FixNewLines(entry)
    let a:entry.text = substitute(a:entry.text, "\\\\n", "\n", "g")
endfunction

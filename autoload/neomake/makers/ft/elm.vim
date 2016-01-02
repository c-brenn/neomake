" vim: ts=4 sw=4 et

function! neomake#makers#ft#elm#EnabledMakers()
    return ['elmmake']
endfunction

function! neomake#makers#ft#elm#elmmake()
    let mapexpr = 'substitute(v:val, "\\\\n", " ", "g")'
    let output_file = fnameescape('/dev/null')
    return {
        \ 'exe': 'elm-make',
        \ 'args': ['--report=json', '--output=/dev/null'],
        \ 'mapexpr': mapexpr,
        \ 'errorformat':
            \ '[{"tag":"%.%#"\,' .
            \ '"overview":"%m"\,"subregion"' .
            \ '%.%#\,' .
            \ '"region":{"start":{"line":%l\,"column":%c' .
            \ '%.%#\,' .
            \ '"file":"%f"}]'
        \ }
endfunction

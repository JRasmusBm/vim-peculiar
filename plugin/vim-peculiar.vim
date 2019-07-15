function! s:lines(...) abort
  return [line("'["), line("']")]
endfunction

function! s:run_peculiar(prompt) abort
  let cmd = input("Run: " . a:prompt)
  exec a:prompt . cmd
endfunction

function! s:gObject(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let [lnum1, lnum2] = s:lines(a:0, a:1) 
    let search = input("Run (Leave empty for last search): g/\\v")
    let prompt = lnum1 . "," . lnum2 . "g/\\v" . search . "/". "norm "
    call s:run_peculiar(prompt)
  endif
endfunction

function! s:vObject(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let [lnum1, lnum2] = s:lines(a:0, a:1) 
    let search = input("Run (Leave empty for last search): v/\\v")
    let prompt = lnum1 . "," . lnum2 . "v/\\v" . search . "/". "norm "
    call s:run_peculiar(prompt)
  endif
endfunction

function! s:pObject(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let [lnum1, lnum2] = s:lines(a:0, a:1) 
    input("Run (Leave empty for last search): v/\v")
    let prompt = lnum1 . "," . lnum2 . "norm "
    call s:run_peculiar(prompt)
  endif
endfunction

nnoremap <expr> <Plug>PeculiarObject <SID>pObject()
nnoremap <expr> <Plug>PeculiarG <SID>gObject()
nnoremap <expr> <Plug>PeculiarV <SID>vObject()

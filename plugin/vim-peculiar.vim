function! s:go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [lnum1, lnum2] = [a:1, a:2]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif
  let prompt = lnum1 . "," . lnum2 . "norm "
  let cmd = input("Run: " . prompt)
  exec prompt . cmd
endfunction

nnoremap <expr> <Plug>PeculiarObject <SID>go()

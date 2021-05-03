function! peculiar#lines(...) abort
  return line("'[") . "," . line("']")
endfunction

let s:max_depth = 100
function! peculiar#last_norm_command() abort
  for current_depth in range(s:max_depth)
    let current_value = histget(":", -current_depth)
    if match(current_value, "norm") != -1
      return current_value
    endif
  endfor

  throw "No recent norm command found!"
endfunction

function! peculiar#repeat(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let lines = peculiar#lines(a:0, a:1) 
    let cmd = peculiar#last_norm_command()
    execute substitute(cmd, '[0-9]\+,[0-9]\+', lines, "")
  endif
endfunction

let s:should_prompt=0
function! peculiar#prompt() abort
  let cmd = histget(":")
  call histdel(":", -1)
  if s:should_prompt
    call feedkeys(":" . cmd . repeat("\<BS>", 22) . "norm ")
    let s:should_prompt=0
  endif
endfunction

function! peculiar#v(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let s:should_prompt=1
    let lines = peculiar#lines(a:0, a:1) 
    call feedkeys(":" . lines . "v//call peculiar#prompt()" . repeat("\<Left>", 23))
  endif
endfunction

function! peculiar#n(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let lines = peculiar#lines(a:0, a:1) 
    let s:should_prompt=1
    call histadd(":", "keeppatterns " . lines . "g/\\v.*/call peculiar#prompt()")
    call peculiar#prompt()
  endif
endfunction

function! peculiar#g(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let s:should_prompt=1
    let lines = peculiar#lines(a:0, a:1) 
    call feedkeys(":" . lines . "g//call peculiar#prompt()" . repeat("\<Left>", 23))
  endif
endfunction

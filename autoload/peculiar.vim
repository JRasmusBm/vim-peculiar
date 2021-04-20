function! peculiar#lines(...) abort
  return line("'[") . "," . line("']")
endfunction

let b:last_command=""
let b:last_modifier_string=""
let b:last_search=""

function! peculiar#repeat(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif
  let lines = peculiar#lines(a:0, a:1)
  let to_execute = lines . b:last_modifier_string . b:last_search
  if b:last_modifier_string != ""
    let to_execute = to_execute . "/"
  endif
  exec to_execute . "norm " . b:last_command
endfunction


function! peculiar#run_peculiar(lines, modifier_string, search) abort
  let prompt = a:lines . a:modifier_string . a:search
  if a:modifier_string != ""
    let prompt = prompt . "/"
  endif
  let prompt = prompt . "norm "
  let command = input("Run: " . prompt)
  let b:last_command = command
  let b:last_modifier_string = a:modifier_string
  let b:last_search = a:search
  if a:search != ""
    let @/ = a:search
  endif
  let to_execute = prompt . command
  call histadd("cmd", to_execute)
  exec to_execute
endfunction


function! peculiar#g_object(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let lines = peculiar#lines(a:0, a:1) 
    let search = input("Run (Leave empty for last search): g/\\v")
    if search == ""
      let search = @/
    endif
    call peculiar#run_peculiar(lines, "g/\\v", search)
  endif
endfunction

function! peculiar#v_object(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let lines = peculiar#lines(a:0, a:1) 
    let search = input("Run (Leave empty for last search): v/\\v")
    if search == ""
      let search = @/
    endif
    call peculiar#run_peculiar(lines, "v/\\v", search)
  endif
endfunction

function! peculiar#n_object(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  else
    let lines = peculiar#lines(a:0, a:1) 
    call peculiar#run_peculiar(lines, "", "")
  endif
endfunction

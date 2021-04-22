function! peculiar#lines(...) abort
  return line("'[") . "," . line("']")
endfunction

let s:last_command=""
let s:last_modifier_string=""
let s:last_search=""

function! peculiar#repeat(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif
  let lines = peculiar#lines(a:0, a:1)
  let to_execute = lines . s:last_modifier_string . s:last_search
  if s:last_modifier_string != ""
    let to_execute = to_execute . "/"
  endif
  exec to_execute . "norm " . s:last_command
endfunction

function! peculiar#run_peculiar(lines, modifier_string, search) abort
  let prompt = a:lines . a:modifier_string . a:search
  if a:modifier_string != ""
    let prompt = prompt . "/"
  endif
  let prompt = prompt . "norm "
  let command = input("Run: " . prompt)
  let s:last_command = command
  let s:last_modifier_string = a:modifier_string
  let s:last_search = a:search
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
    call peculiar#run_peculiar(lines, "g/\\v", ".*")
  endif
endfunction

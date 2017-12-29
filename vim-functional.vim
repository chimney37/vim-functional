" immutable data structures

function! Sorted(l)
    " create full copy so it's different from vim's sort() that does in place.
    let new_list = deepcopy(a:l)
    call sort(new_list)
    return new_list
endfunction

" return new list with elements reversed
function! Reversed(l)
    let new_list = deepcopy(a:l)
    call reverse(new_list)
    return new_list
endfunction

" returns new list with val appended at end of list
function! Append(l,val)
    let new_list = deepcopy(a:l)
    call add(new_list, a:val)
    return new_list
endfunction

" returns new List or Dict with element at index replaced by new value
function! Assoc(l, i, val)
    if type(a:l) == type([]) || type(a:l) == type({}) 
        let new_list_or_dict = deepcopy(a:l)
        let new_list_or_dict[a:i] = a:val
        return new_list_or_dict
    endif
endfunction

" Pop returns new List or Dict with element at given index removed
function! Pop(l, i)
    if type(a:l) == type([]) || type(a:l) == type({}) 
        let new_list = deepcopy(a:l)
        call remove(new_list, a:i)
        return new_list
    endif
endfunction

" higher-order functions: take other functions and do something
" map for functons that work with List or Dict
function! Mapped(fn, l)
    if type(a:l) == type([]) || type(a:l) == type({}) 
        let new_list_or_dict = deepcopy(a:l)
        " v:val is value of current item of List or Dictionary. Only valid while
        " evaluating the expression used with map and filter
        call map(new_list_or_dict, string(a:fn) . '(v:val)')
        return new_list_or_dict
    endif
endfunction

" filter for functions. keeps those in the List or Dict that were not filtered
function! Filtered(fn, l)
    if type(a:l) == type([]) || type(a:l) == type({}) 
        let new_list_or_dict = deepcopy(a:l)
        call filter(new_list_or_dict, string(a:fn) . '(v:val)')
        return new_list_or_dict
    endif
endfunction

" inverse of filter for functions. keeps those that were filtered from the
" List or Dict. ! negates the result of the predicate
function! Removed(fn, l)
    if type(a:l) == type([]) || type(a:l) == type({}) 
        let new_list_or_dict = deepcopy(a:l)
        call filter(new_list_or_dict, '!' . string(a:fn) . '(v:val)')
        return new_list_or_dict
endfunction

" Reduced: takes a List, do something with it using a Reduce function
function! Reduced(fn, l)
    if type(a:l) == type([]) || type(a:l) == type({})
        let new_value = deepcopy(a:l)
        execute 'let reduced_value = ' . string(a:fn) . '(new_value)'
    return reduced_value
endfunction

function! Sum(l)
    let sum = 0
    for i in a:l
        let sum += i
    endfor
    return sum
endfunction

set gfn=Source\ Code\ Pro\ Medium\ 10
colorscheme solarized
set listchars=nbsp:_,tab:▸\ ,trail:@

    " Interpret .md and .pdc files as Markdown
    au BufNewFile,BufRead *.md setlocal filetype=pandoc
    au BufNewFile,BufRead *.pdc setlocal filetype=pandoc
    au BufNewFile,BufRead *.page setlocal filetype=pandoc

        function! MarkdownFold()
            " See
            " http://occasionallycogent.com/post/5222794912/folding-fun-with-vim-and-markdown
            syntax enable
            setlocal syntax=pandoc
            setlocal foldmethod=syntax
            syntax region markdownFold start="^\z(#\+\) " end="\(^#\(\z1#*\)\@!#*[^#]\)\@=" transparent fold
        endfunction
        nnoremap <leader>mf :call MarkdownFold()<CR>

    augroup filetype_markdown
        autocmd!
        autocmd filetype pandoc nnoremap <buffer> <silent> <localleader><localleader> :!python3 generator/generator.py --files %<CR><CR>
        "autocmd filetype,BufNewFile,BufRead pdc setlocal syntax=pdc
        autocmd filetype pandoc setlocal linebreak nolist
    augroup END

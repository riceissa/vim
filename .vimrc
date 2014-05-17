filetype off
" See
" http://stackoverflow.com/questions/4261785/temporarily-disable-some-plugins-using-pathogen-in-vim
" for disabling plugins.
let g:pathogen_disabled = []

call add(g:pathogen_disabled, 'vim-autoclose')

" Gundo requires at least Vim 7.3
if v:version < '703' || !has('python')
    call add(g:pathogen_disabled, 'gundo')
endif

if !has('python')
    call add(g:pathogen_disabled, 'ultisnips')
endif

execute pathogen#infect()

set nocompatible
set nomodeline
set modelines=0
" Disable highlighting for matching brackets
    let loaded_matchparen = 1
" File type and syntax
    filetype plugin indent on
    filetype indent off
    syntax on
" Show invisible characters
    set list listchars=eol:$,extends:>,precedes:<,nbsp:_,tab:>-,trail:@
" Searching options
    set hlsearch ignorecase incsearch showmatch smartcase
" Indenting options
    set autoindent
    set nocindent
    set nosmartindent
    set expandtab shiftwidth=4 softtabstop=4 tabstop=4
" Custom user mappings
    " Leader mappings
        let mapleader=' '
        let localleader = '\\'
        nnoremap <silent> <leader>nh :nohlsearch<CR>
        nnoremap <silent> <leader>I :set list!<CR>
        nnoremap <silent> <leader>N :set number!<CR>
        nnoremap <leader>p :set paste! paste?<CR>
        function ToggleSpell()
            " See http://stackoverflow.com/q/23125636/3422337 for more
            " information on how this works
            if &spell
                set nospell
                syntax on
                echom "spelling was on ... turning off; syntax enabled"
            else
                set spell
                syntax off
                echom "spelling was off ... turning on; syntax disabled"
            endif
        endfunction
        function ToggleTextWidth()
            if &textwidth ==# 0
                set textwidth=72
                echom "textwidth is now 72"
            else
                set textwidth=0
                echom "textwidth is now 0"
            endif
        endfunction
        function ToggleRead()
            if &linebreak
                set nolinebreak list
            else
                set linebreak nolist
            endif
        endfunction
        cnoremap <C-v> "+gP
        nnoremap <leader>R :call ToggleRead()<CR>
        nnoremap <leader>sp :call ToggleSpell()<CR>
        "nnoremap <leader>sp :set spell! spell?<CR>
        nnoremap <leader>W :set wrap! wrap?<CR>
        nnoremap <silent> <leader>ev :tabnew $MYVIMRC<CR>
        nnoremap <leader>sv :source $MYVIMRC<CR>
        nnoremap <silent> <leader>es :tabnew ~/.vim/bundle/snipmate/snippets/<CR>
        nnoremap <silent> <leader>t :NERDTreeToggle<CR>
        nnoremap <leader>u :GundoToggle<CR>
        nnoremap <leader>cd :lcd %:p:h<CR>
            " Change local directory to current file's location
            " directory
        nnoremap <leader>" viw<Esc>a"<Esc>hbi"<Esc>lel
        nnoremap <leader>' viw<Esc>a'<Esc>hbi'<Esc>lel
        nnoremap <leader>m i\(<Esc>Ea\)<Esc>
        nnoremap _ :bp<CR>
        nnoremap <leader>T :call ToggleTextWidth()<CR>
        vnoremap fmt <Esc>:set textwidth=72<CR>gvgq<Esc>:set textwidth=0<CR>
            " Format visually selected region to be up to 72 characters.
            " Possible source of headaches: running this will set the
            " textwidth to 0 at the end, i.e., it will ignore the
            " original value for textwidth.
    " Windows
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l
    " Tabs
        nnoremap <silent> <C-t> :tabnew<CR>
        nnoremap <silent> <C-n> :tabn<CR>
        nnoremap <silent> <C-p> :tabp<CR>
    inoremap jj <Esc>
    inoremap kk <Esc>
    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk
    nnoremap gj j
    nnoremap gk k
    vnoremap gj j
    vnoremap gk k
    nnoremap Y y$
    nnoremap Q @@
    nnoremap <Enter> o<Esc>
    nnoremap <silent> K :bn<CR>
    onoremap p i(
    onoremap in( :<C-u>normal! f(vi(<CR>
    onoremap il( :<C-u>normal! F)vi(<CR>
" Other
    set backspace=indent,eol,start cmdheight=2 encoding=utf-8 gdefault
    set hidden nospell number ruler scrolloff=5 shiftround showcmd
    set showmode spellfile=~/.spell.en.add title ttyfast wildmenu wrap
    augroup paste
        autocmd!
        au InsertLeave * set nopaste
    augroup END
" HTML options
    augroup filetype_html
        autocmd!
        autocmd filetype html setlocal shiftwidth=2 softtabstop=2 tabstop=2
        autocmd filetype xhtml setlocal shiftwidth=2 softtabstop=2 tabstop=2
        autocmd filetype xml setlocal shiftwidth=2 softtabstop=2 tabstop=2
    augroup END
" LaTeX options
    let g:tex_flavor='latex'
    augroup filetype_tex
        autocmd!
        autocmd filetype tex nnoremap <buffer> <silent> <localleader><localleader> :!latexmk -pdf %<CR>
        autocmd filetype tex nnoremap <buffer> <silent> <localleader>la :!pdflatex %<CR>
        autocmd filetype tex nnoremap <buffer> <silent> <localleader>xe :!xelatex %<CR>
        autocmd filetype tex nnoremap <buffer> <silent> <localleader>ja :!platex % ; dvipdfmx -f /usr/share/texlive/texmf-dist/fonts/map/dvipdfmx/jfontmaps/otf-ipaex.map %:r.dvi<CR>
        autocmd filetype tex nnoremap <buffer> <silent> <localleader>jp :!platex % ; dvipdfmx -f /usr/share/texlive/texmf-dist/fonts/map/dvipdfmx/jfontmaps/otf-ipaex.map %:r.dvi<CR>
        " Make visually selected region be mathematically typeset.
        autocmd filetype tex vnoremap <buffer> <silent> ma <esc>`>a\)<esc>`<i\(<esc>
    augroup END
" Markdown options
    au BufNewFile,BufRead *.md set filetype=markdown
        " Interpret `.md` files as Markdown
    augroup filetype_markdown
        autocmd!
        autocmd filetype markdown nnoremap <buffer> <silent> <localleader><localleader> :!pandoc -o %:r.html --template=/home/issa/projects/riceissa.bitbucket.org/template.txt --toc --mathjax --variable includemaths=true %<CR><CR>
        autocmd filetype markdown nnoremap <buffer> <silent> <localleader>tm :!pandoc -o %:r.html --template=/home/issa/projects/riceissa.bitbucket.org/template.txt --toc --mathjax --variable includemaths=true %<CR><CR>
        autocmd filetype markdown nnoremap <buffer> <silent> <localleader>nm :!pandoc -o %:r.html --template=/home/issa/projects/riceissa.bitbucket.org/template.txt --mathjax --variable includemaths=true %<CR><CR>
        autocmd filetype markdown nnoremap <buffer> <silent> <localleader>tn :!pandoc -o %:r.html --template=/home/issa/projects/riceissa.bitbucket.org/template.txt --toc %<CR><CR>
        autocmd filetype markdown nnoremap <buffer> <silent> <localleader>nn :!pandoc -o %:r.html --template=/home/issa/projects/riceissa.bitbucket.org/template.txt %<CR><CR>
        autocmd filetype markdown nnoremap <buffer> <silent> <localleader>sm :!pandoc --strict -o %:r.html --template=/home/issa/projects/riceissa.bitbucket.org/simple_markdown_template.txt --toc %<CR><CR>
        autocmd filetype markdown nnoremap <buffer> <silent> <localleader>pp :!pandoc -o %:r.html --template=/home/issa/projects/riceissa.bitbucket.org/simple_markdown_template.txt %<CR><CR>
    augroup END
" Plugins
    " EasyMotion
        let g:EasyMotion_leader_key = '<leader><leader>'
" Abbreviations
    iabbrev adn and
    iabbrev nad and
    iabbrev teh the
    iabbrev het the
    iabbrev ehty they
    iabbrev hety they
    iabbrev tehn then
    iabbrev waht what
    iabbrev THen Then
    iabbrev THe The
    iabbrev ANd And
    iabbrev WHen When
    iabbrev HOw How
    iabbrev WHy Why
    iabbrev THis This
    iabbrev THere There
    iabbrev THey They
    iabbrev RIce Rice
    iabbrev countires countries
    iabbrev governmetn government
    iabbrev minumum minimum
    iabbrev dependece dependence
    iabbrev smae same
    iabbrev THus Thus
set background=light
" Custom digraphs
    " Use Python's ord("⟨char⟩") for the integer values of the
    " characters.
    dig el 8230
        " Hit `Ctrl-k` then type `el` to produce an ellipsis
    dig (< 10216
        " ⟨
    dig )> 10217
        " ⟩
" Type `:Clip` to load the current file into the clipboard. The
" alternative is to use gg"+yG from normal mode.
    command Clip :!cat % | xclip -sel clip

if has('gui_running')
    colorscheme solarized
endif

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "UltiSnips-custom-snippets"]

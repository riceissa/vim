# ~/.vim

*This is old; see <https://github.com/riceissa/dotfiles/> for newer versions.*

## Installation

    git clone git://github.com/riceissa/vim.git ~/.vim
    ln -s ~/.vim/.vimrc ~/.vimrc
    ln -s ~/.vim/.gvimrc ~/.gvimrc
    cd ~/.vim
    git submodule update --init --recursive

To generate helptags, run `call pathogen#helptags()` while using Vim.

Working with submodules is proving to be somewhat challenging.  For
instance after changing the location of a submodule, one must do `git
submodule sync` or `git submodule update` to get everything working
again.

Note for myself: if I later want to push changes to the GitHub
repository, I must do:

    git remote rm origin
    git remote add origin git@github.com:riceissa/vim.git

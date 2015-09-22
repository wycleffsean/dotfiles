# dotfiles
homesick castle


# Setup

```ruby
gem install homesick
homesick clone wycleffsean/dotfiles
homesick symlink dotfiles
```

## vim
Install Vundle
```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# if YCM needs to be recompiled
cd ~/.vim/bundle/YouCompleteMe/install.py
```

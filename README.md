# dotfiles
homesick castle

# Setup

```ruby
gem install homesick
homesick clone wycleffsean/dotfiles
homesick symlink dotfiles
```

## Homebrew

```
cd ~
brew tap Homebrew/bundle
brew bundle

brew install fzf universal-ctags ripgrep
```

## vim
Install Vundle
```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

### Install Powerline fonts
Download and set font in iTerm profile
[Inconsolata-g for Powerline](https://github.com/powerline/fonts/raw/master/Inconsolata-g/Inconsolata-g%20for%20Powerline.otf)

## PGP

```
# import keybase keys
keybase pgp export | gpg --import
keybase pgp export --secret | gpg --allow-secret-key-import --import
```

# macOS Upgrade Notes

2 general sets of problems
  - kext are invalidated
  - c environment is invalidated

To fix c environment...

```
xcode-select --install
# headers aren't installed by default with XCode 10 for some reason
# https://github.com/frida/frida/issues/338#issuecomment-424595668
# https://forums.developer.apple.com/thread/104296
open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14. pkg
```

## homebrew

`brew update` might show lots of warnings about bad gems

```
chruby 2.3.0 # idk why
gem pristine --all
# or uninstall relevant gems
```

## osxfuse

```
brew cask upgrade osxfuse # or brew cask reinstall osxfuse
brew reinstall ext4fuse
```

## ruby

This will need to be done for any installed ruby

```
gem pristine --all
```

## virtualbox

```
brew cask upgrade virtualbox # or cask reinstall
brew cask upgrade virtualbox-extension-pack # or cask reinstall
```

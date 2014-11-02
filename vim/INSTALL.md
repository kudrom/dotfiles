# VIM

1) You must clone the repository and run git submodule update --init

2) You must create a symbolic link to the $HOME/.vimrc file with:
ln -s path/to/dotfiles/vim/.vimrc $HOME

3) You must create a symbolic link of the autoload directory to the pathogen's autoload with:
ln -s path/to/dotfiles/vim/pathogen/autoload $HOME/.vim

4) You must create a symbolic links for the bundle and colors directories with:
ln -s path/to/dotfiles/vim /$HOME/.vim

Every time you want to update the plugins, run:
git submodule foreach git pull origin master
in the dotiles directory, and copy the pathogen script by hand

#!/bin/bash
# This script is my personal setup file - use at own risk

########## Variables
dotfiles=~/dotfiles                    # dotfiles directory
dotfilesOld=~/dotfiles_old             # old dotfiles backup directory
files="bashrc bash_aliases vimrc vim zshrc tmux.conf"    # list of files/folders to symlink in homedir

##########

install_dotfiles(){
    # create dotfiles_old in homedir
    echo "Creating $dotfilesOld for backup of any existing dotfiles in ~"
    mkdir -p $dotfilesOld
    echo "...done"

    # change to the dotfiles directory
    echo "Changing to the $dotfiles directory"
    cd $dotfiles
    echo "...done"

    # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
    for file in $files; do
        echo "Moving $file from ~ to $dotfilesOld"
        mv ~/.$file ~/dotfiles_old/
        echo "Creating symlink to $file in home directory."
        ln -s $dotfiles/$file ~/.$file
    done
}

# vim vundle
get_vundle(){
    echo "VIM: Checking if Vundle is installed"
    if [ ! -d ~/.vim/bundle ]; then
        mkdir -p ~/.vim/bundle
    fi

    if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
        echo "Installing Vundle"
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
}

# Install Vundle Plugins
install_vundle(){
    echo "Update/Install plugins using vundle"
    vim +PluginInstall +qall 
}

get_vimplug(){
    echo "VIM: Checking if VimPlug is installed"
    if [ ! -d ~/.vim/autoload ]; then
        mkdir -p ~/.vim/bundle
    fi

    if [ ! -e ~/.vim/autoload/plug.vim ]; then
        echo "Installing vim-plug"
        curl -fLo ~/.vim/autoload/plug.vim \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}
# Install Vundle Plugins
install_plug(){
    echo "Update/Install plugins using Vim-Plug"
    vim +PlugInstall +qall 
}

echo "Backup existing Aliases (in $dotfilesOld) and create aliases?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_dotfiles; break;;
        No ) echo "okay - thats ok, I guess"; break;; 
    esac
done

echo "Install Vim-Plug and get Plugins?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) get_vimplug; install_plug; break;;
        No ) echo "okay - thats ok, I guess"; break; 
    esac
done
echo "You might want to install the patched font for webdevIcons and arrows";



# install_dotfiles || exit 1
# get_vimplug || exit 1
# install_plug || exit 1
# install_vundle || exit 1

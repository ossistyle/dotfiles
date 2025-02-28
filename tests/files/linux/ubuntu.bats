#!/usr/bin/env bats

# bats test_tags=ubuntu:personal
@test "[ubuntu-personal] dotfiles" {
    directories_exists=(
        "${HOME}/.ssh"
        "${HOME}/.local/bin/common"
        "${HOME}/.oh-my-zsh/completions"
        "${HOME}/.oh-my-zsh/custom"
        "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
        "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
        "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
    )
    for directory in "${directories_exists[@]}"; do
        echo "Checking ${directory}"
        [ -d "${directory}" ]
    done


    files_exists=(
        "${HOME}/.profile"
        "${HOME}/.hushlogin"
        "${HOME}/.bashrc"
        "${HOME}/.zshrc"
        "${HOME}/.zshenv"
        "${HOME}/.zlogin"
        "${HOME}/.zlogout"        
        "${HOME}/.zprofile"
        "${HOME}/.p10k.zsh"
        "${HOME}/.opencommit"
        "${HOME}/.config/btop/btop.conf"
        "${HOME}/.config/git/config"
        "${HOME}/.config/git/cookies"
        "${HOME}/.config/git/ignore"
        "${HOME}/.config/kitty/kitty.conf"
        "${HOME}/.config/lazydocker/config.yml"
        "${HOME}/.config/nvim/init.lua"
        "${HOME}/.config/tmux/tmux.conf"
        "${HOME}/.ssh/authorized_keys"
        "${HOME}/.ssh/config"
        "${HOME}/.ssh/id_rsa.pub"
        "${HOME}/.ssh/id_rsa"
    )

    for file in "${files_exists[@]}"; do
        echo "Checking ${file}"
        [ -f "${file}" ]
    done

    

    files_not_exists=(
        
    )
    for file in "${files_not_exists[@]}"; do
        echo "Checking ${file}"
        [ ! -f "${file}" ]
    done
}

# bats test_tags=ubuntu:work
@test "[ubuntu-work] dotfiles" {
    files_exists=(
        "${HOME}/.zshrc"
        "${HOME}/.zshenv"
        "${HOME}/.zlogin"
        "${HOME}/.zlogout"        
        "${HOME}/.zprofile"
        "${HOME}/.p10k.zsh"
        "${HOME}/.opencommit"
        "${HOME}/.config/btop/btop.conf"
        "${HOME}/.config/git/config"
        "${HOME}/.config/git/cookies"
        "${HOME}/.config/git/ignore"
        "${HOME}/.config/kitty/kitty.conf"
        "${HOME}/.config/lazydocker/config.yml"
        "${HOME}/.config/nvim/init.lua"
        "${HOME}/.config/tmux/tmux.conf"
    )
    for file in "${files_exists[@]}"; do
        echo "Checking ${file}"
        [ -f "${file}" ]
    done

    directories_exists=(
        
    )
    for directory in "${directories_exists[@]}"; do
        echo "Checking ${directory}"
        [ -d "${directory}" ]
    done

    files_not_exists=(
        
    )
    for file in "${files_not_exists[@]}"; do
        echo "Checking ${file}"
        [ ! -f "${file}" ]
    done
}
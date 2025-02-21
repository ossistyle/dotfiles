#!/usr/bin/env bats

# bats test_tags=ubuntu:personal
@test "[ubuntu-personal] dotfiles" {
    files_exists=(
        "${HOME}/.zshrc"
        "${HOME}/.zprofile"
        "${HOME}/.p10k.zsh"
        "${HOME}/.opencommit"
        "${HOME}/.config/btop/btop.conf"
        "${HOME}/.config/git/config"
        "${HOME}/.config/git/cookies"
        "${HOME}/.config/git/ignore"
        "${HOME}/.config/kitty/kitty.conf"
        "${HOME}/.config/lazydocker/config.yml"
        "${HOME}/.config/nvim/init.vim"
        "${HOME}/.config/tmux/tmux.conf"
    )
    for file in "${files_exists[@]}"; do
        echo "Checking ${file}"
        [ -f "${file}" ]
    done

    directories_exists=(
        "${HOME}/.config/nvim/pack/twpayne/start"
        "${HOME}/.zprezto"
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

# bats test_tags=ubuntu:work
@test "[ubuntu-work] dotfiles" {
    files_exists=(
        "${HOME}/.zshrc"
        "${HOME}/.zprofile"
        "${HOME}/.p10k.zsh"
        "${HOME}/.opencommit"
        "${HOME}/.config/btop/btop.conf"
        "${HOME}/.config/git/config"
        "${HOME}/.config/git/cookies"
        "${HOME}/.config/git/ignore"
        "${HOME}/.config/kitty/kitty.conf"
        "${HOME}/.config/lazydocker/config.yml"
        "${HOME}/.config/nvim/init.vim"
        "${HOME}/.config/tmux/tmux.conf"
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
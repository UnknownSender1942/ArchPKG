#! /bin/bash
# pkg tool v1

echo "
      _        
 ___ | |__ ___ 
| . \| / // . |
|  _/|_\_\\_. |
|_|       <___'" | lolcat

# Default package manager
PACMAN="sudo pacman"

# Detect yay
if command -v yay >/dev/null 2>&1; then
    AUR="yay"
else
    echo "⚠️  yay not found, falling back to pacman only."
    AUR="$PACMAN"
fi

# --- Functions ---

update_system() {
    echo "┌───────────────────────────────┐"
    echo "│ Updating system...            │"
    echo "└───────────────────────────────┘"
    $PACMAN -Syu --noconfirm
    [ "$AUR" != "$PACMAN" ] && $AUR -Syu --noconfirm
}

install_pkg() {
    echo "┌───────────────────────────────┐"
    echo "│ Enter package name to install │"
    echo "└───────────────────────────────┘"
    read -p "> " pkg
    [ -n "$pkg" ] && $AUR -S "$pkg" || echo "No package entered."
}

remove_pkg() {
    echo "┌───────────────────────────────┐"
    echo "│ Enter package name to remove  │"
    echo "└───────────────────────────────┘"
    read -p "> " pkg
    [ -n "$pkg" ] && $PACMAN -Rns "$pkg" || echo "No package entered."
}

search_pkg() {
    echo "┌───────────────────────────────┐"
    echo "│ Enter package name to search  │"
    echo "└───────────────────────────────┘"
    read -p "> " pkg
    if [ -n "$pkg" ]; then
        echo "Searching for $pkg..."
        $AUR -Ss "$pkg" | less
    else
        echo "No package entered."
    fi
}

pkg_info() {
    echo "┌───────────────────────────────┐"
    echo "│ Enter package name for info   │"
    echo "└───────────────────────────────┘"
    read -p "> " pkg
    [ -n "$pkg" ] && $AUR -Si "$pkg" | less || echo "No package entered."
}

list_files() {
    echo "┌───────────────────────────────┐"
    echo "│ Enter package name to list    │"
    echo "└───────────────────────────────┘"
    read -p "> " pkg
    [ -n "$pkg" ] && $PACMAN -Ql "$pkg" | less || echo "No package entered."
}

clean_cache() {
    echo "┌───────────────────────────────┐"
    echo "│ Cleaning package cache...     │"
    echo "└───────────────────────────────┘"
    $PACMAN -Sc --noconfirm
    [ "$AUR" != "$PACMAN" ] && $AUR -Sc --noconfirm
}

list_installed() {
    echo "┌───────────────────────────────┐"
    echo "│ Installed packages            │"
    echo "└───────────────────────────────┘"
    $PACMAN -Qe | less
}

list_orphans() {
    echo "┌───────────────────────────────┐"
    echo "│ Orphaned packages             │"
    echo "└───────────────────────────────┘"
    orphans=$(pacman -Qdtq)
    if [ -n "$orphans" ]; then
        echo "$orphans"
    else
        echo "No orphaned packages."
    fi
}

remove_orphans() {
    echo "┌───────────────────────────────┐"
    echo "│ Removing orphaned packages... │"
    echo "└───────────────────────────────┘"
    orphans=$(pacman -Qdtq)
    [ -n "$orphans" ] && $PACMAN -Rns $orphans || echo "No orphaned packages."
}

update_repo_only() {
    if [ "$AUR" != "$PACMAN" ]; then
        echo "┌───────────────────────────────┐"
        echo "│ Updating repo packages only   │"
        echo "└───────────────────────────────┘"
        $AUR -Syu --repo
    else
        echo "This feature requires yay."
    fi
}

update_aur_only() {
    if [ "$AUR" != "$PACMAN" ]; then
        echo "┌───────────────────────────────┐"
        echo "│ Updating AUR packages only    │"
        echo "└───────────────────────────────┘"
        $AUR -Sua
    else
        echo "This feature requires yay."
    fi
}

# --- Menu ---
while true; do
    echo
    echo "1) Update system" | lolcat
    echo "2) Install package" | lolcat
    echo "3) Remove package" | lolcat
    echo "4) Search package" | lolcat
    echo "5) Clean cache" | lolcat
    echo "6) Show installed packages" | lolcat
    echo "7) Show orphaned packages" | lolcat
    echo "8) Remove orphaned packages" | lolcat
    echo "9) Show package info" | lolcat
    echo "10) List package files" | lolcat
    echo "11) Update repo packages only" | lolcat
    echo "12) Update AUR packages only" | lolcat
    echo "13) Exit" | lolcat
    echo "-------------------------------"
    read -p "Choose an option: " choice

    case $choice in
    1) update_system ;;
    2) install_pkg ;;
    3) remove_pkg ;;
    4) search_pkg ;;
    5) clean_cache ;;
    6) list_installed ;;
    7) list_orphans ;;
    8) remove_orphans ;;
    9) pkg_info ;;
    10) list_files ;;
    11) update_repo_only ;;
    12) update_aur_only ;;
    13)
        echo "I use Arch BTW..."
        exit 0
        ;;
    *) echo "Invalid option." ;;
    esac
done

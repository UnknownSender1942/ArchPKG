# ArchPKG tool v1
A lightweight, interactive Bash utility to manage packages on Arch Linux and derivatives, with support for both pacman and yay.
Ideal for users who want a terminal menu to handle common package management tasks quickly and colorfully.

# Features 
- Update your system (Pacman + AUR)
- Search for packages (with less-paging)
- Install and remove packages
- View installed packages and file lists
- Clean package cache and orphaned packages
- Check detailed package info
- Colorful ASCII UI with `lolcat`
- Automatically detects yay, falls back to pacman if not found

# Usage
```chmod +x pkg.sh```

```./pkg.sh```

#### Compatible With Any Arch Based Distro!

# Notes
- If yay is not installed, AUR-related actions will fall back to pacman, and some options (like updating AUR-only packages) will be disabled.
- This script is intended for new users who prefer easy to use terminal tools.

# Dependencies
- Arch based Distro
- bash
- lolcat (for color output)
- yay (optional but recommended for full functionality)

# License
MIT — do whatever you want with it.


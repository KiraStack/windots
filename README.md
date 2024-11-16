# Dotfiles

This repository houses my personal configuration files (dotfiles) to customize and optimize my development environment on Windows. The focus is currently on tools like [NeoVim](https://neovim.io/), [WezTerm](https://wezfurlong.org/wezterm/), and [Windows PowerShell](https://learn.microsoft.com/en-us/powershell/). Future updates will expand to include Arch Linux configurations, making this repository cross-platform.

## Features

- **NeoVim**: Customized editor setup, including plugins and keybindings for efficient development.
- **WezTerm**: Terminal emulator configuration for a clean and functional interface.
- **PowerShell**: Enhanced shell experience with aliases, functions, and a custom prompt.
- **Cross-Platform Plans**: Arch Linux support and configurations for additional tools are on the roadmap.

## Installation

To use these dotfiles, manually link the configuration files to their expected locations. Examples for Windows:

1. Clone the repository:
   ```powershell
   git clone https://github.com/VisoredPrograms/dotfiles.git C:\dotfiles
   ```

2. Create symbolic links to the appropriate directories or files. For example:
   ```powershell
   New-Item -ItemType SymbolicLink -Path $HOME\AppData\Local\nvim -Target C:\dotfiles\nvim
   New-Item -ItemType SymbolicLink -Path $HOME\.wezterm.lua -Target C:\dotfiles\wezterm.lua
   New-Item -ItemType SymbolicLink -Path $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Target C:\dotfiles\powershell\profile.ps1
   ```

3. Reload the relevant application to apply the configuration (e.g., restart PowerShell or reopen NeoVim).

## Configuration Overview

- **NeoVim (`nvim/`)**: Contains the main configuration file (`init.vim` or `init.lua`) and plugin settings.
- **WezTerm (`wezterm.lua`)**: Defines terminal appearance, fonts, and shortcuts.
- **PowerShell (`powershell/`)**: Includes a custom profile script to enhance functionality and workflow.

## Future Plans

This repository will expand to include Arch Linux support, featuring:

- Shell configurations for tools like Zsh and Fish.
- Enhanced setups for Tmux, Alacritty, and FZF.
- System-wide scripts and utilities for improved productivity.

## Notes

These dotfiles are tailored to my preferences and workflow. However, feel free to explore and adapt them for your own use. Feedback and suggestions are welcome.

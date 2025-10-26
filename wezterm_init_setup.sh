#!/usr/bin/env bash

# ─────────────────────────────────────────────
# 🎯 SETUP MODULAR PARA ENTORNO DEV EN WSL UBUNTU
# Autor: Diorge + Copilot
# ─────────────────────────────────────────────

set -e

# 📦 Instalar paquetes base
instalar_basicos() {
  echo "🔧 Instalando paquetes base..."
  sudo apt update
  sudo apt install -y git curl wget unzip build-essential software-properties-common
}

# 🐟 Instalar y configurar Fish Shell
instalar_fish() {
  echo "🐟 Instalando Fish Shell..."
  sudo apt install -y fish
  grep -q "exec fish" ~/.bashrc || echo "exec fish" >> ~/.bashrc
}

# 🦀 Instalar Rust y Zellij
instalar_zellij() {
  echo "🦀 Instalando Rust y Zellij..."
  if ! command -v cargo &> /dev/null; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
  fi
  cargo install --locked zellij
}

# 🧠 Instalar Node.js y Python
instalar_node_python() {
  echo "🧠 Instalando Node.js y Python..."
  sudo apt install -y nodejs npm python3 python3-pip
}

# 🧬 Instalar Neovim
instalar_neovim() {
  echo "🧬 Instalando Neovim..."
  sudo apt install -y neovim
}

# 🚀 Instalar GitHub Copilot CLI
instalar_copilot_cli() {
  echo "🚀 Instalando GitHub Copilot CLI..."
  sudo apt install -y gh
  npm install -g @githubnext/github-copilot-cli
  echo "🔐 Ejecuta 'gh auth login' para autenticar GitHub si no lo has hecho."
}

# 🌟 Clonar kickstart.nvim
instalar_kickstart() {
  echo "🌟 Clonando kickstart.nvim..."
  rm -rf ~/.config/nvim
  git clone https://github.com/nvim-lua/kickstart.nvim ~/.config/nvim
}

# 🎨 Aplicar tema Tokyo Night en Neovim
configurar_tokyo_night_nvim() {
  echo "🎨 Aplicando tema Tokyo Night en Neovim..."
  mkdir -p ~/.config/nvim/lua/plugins
  echo 'return { "folke/tokyonight.nvim", lazy = false, priority = 1000 }' > ~/.config/nvim/lua/plugins/colorscheme.lua

  if grep -q 'vim.cmd("colorscheme' ~/.config/nvim/init.lua; then
    sed -i '/vim.cmd("colorscheme/a\vim.cmd("colorscheme tokyonight")' ~/.config/nvim/init.lua
  else
    echo 'vim.cmd("colorscheme tokyonight")' >> ~/.config/nvim/init.lua
  fi
}

# 🖼️ Configurar WezTerm (requiere instalación manual)
configurar_wezterm() {
  echo "🖼️ Configurando WezTerm..."
  mkdir -p ~/.config/wezterm
  cat <<'EOF' > ~/.config/wezterm/wezterm.lua
local wezterm = require 'wezterm'

return {
  color_scheme = "Tokyo Night",
  font_size = 13.0,
  window_background_opacity = 0.85,
  enable_tab_bar = false,
  hide_mouse_cursor_when_typing = true,
  use_fancy_tab_bar = false,
}
EOF
  echo "📦 Recuerda instalar WezTerm manualmente desde: https://wezfurlong.org/wezterm/install.html"
}

# 🧩 Configurar Zellij con tema Tokyo Night
configurar_zellij() {
  echo "🧩 Configurando Zellij..."
  mkdir -p ~/.config/zellij
  cat <<EOF > ~/.config/zellij/config.kdl
theme "tokyo-night" {
  fg "white"
  bg "black"
  accent "blue"
}
EOF
}

# 🧪 Ejecutar todas las funciones
main() {
  instalar_basicos
  instalar_fish
  instalar_node_python
  instalar_zellij
  instalar_neovim
  instalar_copilot_cli
  instalar_kickstart
  configurar_tokyo_night_nvim
  configurar_wezterm
  configurar_zellij
  echo "✅ Entorno listo. Reinicia terminal para aplicar Fish y WezTerm."
}

main
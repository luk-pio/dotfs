#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"

echo "==> Enabling EPEL repository..."
sudo amazon-linux-extras install epel -y

echo "==> Installing yum packages..."
sudo yum install -y \
    git zsh tmux stow jq nmap telnet \
    gcc make curl unzip tar gzip

echo "==> Installing fzf..."
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash --no-fish
else
    echo "fzf already installed, skipping..."
fi

echo "==> Installing zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo "==> Installing neovim (AppImage)..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage "$LOCAL_BIN/nvim"

echo "==> Installing ripgrep..."
RG_VERSION="14.1.0"
curl -LO "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar xzf "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
mv "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg" "$LOCAL_BIN/"
rm -rf "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl"*

echo "==> Installing bat..."
BAT_VERSION="0.24.0"
curl -LO "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar xzf "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
mv "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl/bat" "$LOCAL_BIN/"
rm -rf "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl"*

echo "==> Installing delta..."
DELTA_VERSION="0.18.2"
curl -LO "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar xzf "delta-${DELTA_VERSION}-x86_64-unknown-linux-musl.tar.gz"
mv "delta-${DELTA_VERSION}-x86_64-unknown-linux-musl/delta" "$LOCAL_BIN/"
rm -rf "delta-${DELTA_VERSION}-x86_64-unknown-linux-musl"*

echo "==> Initializing git submodules..."
cd "$SCRIPT_DIR"
git submodule update --init --recursive

echo "==> Stowing dotfiles..."
cd "$SCRIPT_DIR/files"
for pkg in git-linux zsh tmux nvim claude ssh; do
    stow -v --adopt -t "$HOME" "$pkg"
done

echo "==> Installing Oh-My-Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh-My-Zsh already installed, skipping..."
fi

echo "==> Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
git clone https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM/plugins/zsh-autocomplete" 2>/dev/null || true
git clone https://github.com/joshskidmore/zsh-fzf-history-search.git "$ZSH_CUSTOM/plugins/zsh-fzf-history-search" 2>/dev/null || true

echo "==> Installing TPM and tmux plugins..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/bin/install_plugins

echo "==> Changing shell to zsh..."
chsh -s "$(which zsh)"

echo "==> Done! Log out and back in for zsh to take effect."

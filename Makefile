.PHONY: help stow-all stow-configs stow-bin stow-zsh stow-etc stow-walls unstow-all unstow-configs unstow-bin unstow-zsh unstow-etc unstow-walls clean-broken-links

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

stow-all: clean-broken-links stow-configs stow-bin stow-zsh stow-etc stow-walls ## Deploy all dotfiles (configurations, binaries, zsh, etc.)

stow-configs: ## Deploy .config files
	cd .config && stow -t $(HOME)/.config .

stow-bin: ## Deploy .local binaries
	cd .local && stow -t $(HOME)/.local .

stow-zsh: ## Deploy Zsh configurations
	stow -t $(HOME) zsh --adopt

stow-etc: ## Deploy system-wide configurations (/etc)
	cd etc-configs && sudo stow -t / .

stow-walls: ## Deploy wallpaper configurations
	stow -t $(HOME) walls

unstow-all: unstow-configs unstow-bin unstow-zsh unstow-etc unstow-walls ## Remove all symlinks

unstow-configs: ## Remove .config symlinks
	cd .config && stow -t $(HOME)/.config -D .

unstow-bin: ## Remove .local symlinks
	cd .local && stow -t $(HOME)/.local -D .

unstow-zsh: ## Remove Zsh symlinks
	stow -t $(HOME) -D zsh

unstow-etc: ## Remove system-wide symlinks
	cd etc-configs && sudo stow -t / -D .

unstow-walls: ## Remove wallpaper symlinks
	stow -t $(HOME) -D walls

clean-broken-links: ## Clean broken symlinks in ~/.config and ~/.local
	@echo "Cleaning broken symlinks in ~/.config..."
	find ~/.config -type l ! -exec test -e {} \; -delete 2>/dev/null || true
	@echo "Cleaning broken symlinks in ~/.local..."
	find ~/.local -type l ! -exec test -e {} \; -delete 2>/dev/null || true
	@echo "Done cleaning broken links"

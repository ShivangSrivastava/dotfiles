.PHONY: stow-all stow-configs stow-bin stow-zsh stow-etc stow-walls unstow-all unstow-configs unstow-bin unstow-zsh unstow-etc unstow-walls clean-broken-links

stow-all: clean-broken-links stow-configs stow-bin stow-zsh stow-etc stow-walls

stow-configs:
	cd .config && stow -t $(HOME)/.config .

stow-bin:
	cd .local && stow -t $(HOME)/.local .

stow-zsh:
	stow -t $(HOME) zsh --adopt

stow-etc:
	cd etc-configs && sudo stow -t / .

stow-walls:
	stow -t $(HOME) walls

unstow-all: unstow-configs unstow-bin unstow-zsh unstow-etc unstow-walls

unstow-configs:
	cd .config && stow -t $(HOME)/.config -D .

unstow-bin:
	cd .local && stow -t $(HOME)/.local -D .

unstow-zsh:
	stow -t $(HOME) -D zsh

unstow-etc:
	cd etc-configs && sudo stow -t / -D .

unstow-walls:
	stow -t $(HOME) -D walls

clean-broken-links:
	@echo "Cleaning broken symlinks in ~/.config..."
	find ~/.config -type l ! -exec test -e {} \; -delete 2>/dev/null || true
	@echo "Cleaning broken symlinks in ~/.local..."
	find ~/.local -type l ! -exec test -e {} \; -delete 2>/dev/null || true
	@echo "Done cleaning broken links"

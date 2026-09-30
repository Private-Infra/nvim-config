# nvim-config

Configuration Neovim ([AstroNvim](https://github.com/AstroNvim/AstroNvim) v6),
déployée dans `~/.config/nvim` sur les postes par ansible-home (rôle
`astro_nvim`).

## Ce qu'elle apporte

- **Langages de la stack** (packs AstroCommunity, `lua/community.lua`) :
  - Ansible et YAML, avec les schémas SchemaStore ;
  - Python : basedpyright, ruff, debugpy ;
  - bash (shellcheck, shfmt), Docker/compose (hadolint), JSON, TOML,
    Markdown, TypeScript, SQL, Lua.
- **Templates Jinja d'Ansible** : `x.sh.j2` s'ouvre en `sh.jinja2`, avec la
  coloration et le LSP du fichier rendu (`lua/plugins/astrocore.lua`).
- **Claude Code** dans nvim : `<Leader>A` (claudecode.nvim).
- **tmux** : `Ctrl+h/j/k/l` passe d'un split nvim à un pane tmux
  (vim-tmux-navigator, bindings côté tmux dans ansible-home).
- **Thème** : clair ou sombre selon `theme dark|light` du terminal, relu au
  retour du focus.
- **Presse-papier** par OSC 52 sous WSL et en SSH.
- **Obsidian** : `obsidian.nvim` sur le coffre de `OBSIDIAN_VAULT`, à définir
  dans `~/.config/zsh/local.zsh` du poste.

## Mises à jour

- **Plugins** : figés par `lazy-lock.json`. La CI les met à jour chaque lundi
  (`update-plugins.yml`), vérifie le démarrage, puis committe le lockfile ;
  les postes l'appliquent au déploiement suivant (`Lazy restore`).
  Ne pas lancer `:Lazy update` sur un poste : le déploiement remet le
  lockfile du dépôt.
- **Config** : chaque déploiement fait un fast-forward de `~/.config/nvim`,
  sauf si la copie a des modifications locales ou des commits non poussés.
- **Neovim** : version épinglée dans ansible-home (`astro_nvim_neovim_version`,
  suivie par Renovate) ; `NVIM_VERSION` des workflows s'aligne dessus.

## Vérifier

```bash
nvim --headless -S scripts/smoke-test.lua   # démarrage sans erreur, types de fichiers
```

La CI (`ci.yml`) le lance à chaque push, avec les plugins du lockfile.

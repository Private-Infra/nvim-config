-- AstroCommunity : langages de la stack et intégrations.
-- Importé dans `lazy_setup.lua` avant le dossier `plugins/`, dont les specs
-- peuvent donc surcharger celles-ci.
--
-- Chaque pack installe (via Mason) son LSP, ses formateurs et linters, et
-- ses parsers Treesitter. Les packs npm (yaml, json, bash, markdown,
-- typescript, docker) demandent node : présent sur les postes, pas sur le Pi.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Langages
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.ansible" }, -- yaml.ansible + pack yaml (schémas SchemaStore)
  { import = "astrocommunity.pack.python.base" }, -- Treesitter, debugpy (DAP)
  { import = "astrocommunity.pack.python.basedpyright" },
  { import = "astrocommunity.pack.python.ruff" }, -- lint + format, comme dans les dépôts
  { import = "astrocommunity.pack.bash" }, -- bashls, shellcheck, shfmt
  { import = "astrocommunity.pack.docker" }, -- Dockerfile, compose, hadolint
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.sql" },

  -- Intégrations
  { import = "astrocommunity.ai.claudecode-nvim" }, -- <Leader>A : Claude Code dans nvim
  { import = "astrocommunity.terminal-integration.vim-tmux-navigator" }, -- Ctrl+hjkl entre nvim et tmux
  { import = "astrocommunity.note-taking.obsidian-nvim" }, -- activé si un dossier d'OBSIDIAN_VAULT existe (plugins/user.lua)
}

-- Parsers Treesitter hors packs (ceux des langages viennent de community.lua).
-- Compilés localement : il faut un compilateur C (build-essential, installé
-- par le rôle astro_nvim d'ansible-home).

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      ensure_installed = { "vim", "vimdoc", "query", "regex", "gitcommit", "git_rebase", "diff", "jinja" },
    },
  },
}

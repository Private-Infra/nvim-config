-- Réglages propres à cette config, par-dessus les packs de community.lua.

-- Coffres Obsidian : OBSIDIAN_VAULT, défini par ansible-home (rôle
-- obsidian_cli), en liste les dossiers séparés par « : » comme PATH. Un espace
-- de travail par dossier présent, nommé comme lui, le premier par défaut ;
-- aucun, et obsidian.nvim ne se charge pas.
local coffres = vim.tbl_filter(
  function(chemin) return vim.fn.isdirectory(chemin) == 1 end,
  -- normalize : sans barre finale, le nom de l'espace et le motif de chargement restent justes
  vim.tbl_map(
    function(chemin) return vim.fs.normalize(vim.fn.expand(chemin)) end,
    vim.split(vim.env.OBSIDIAN_VAULT or "", ":", { plain = true, trimempty = true })
  )
)

---@type LazySpec
return {
  -- CLI tree-sitter : nvim-treesitter compile ses parsers avec. Installé
  -- aussi par ansible-home sur Linux (cli_tools) ; Mason le fournit ailleurs.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "tree-sitter-cli" })
    end,
  },
  -- Images dans le Markdown (diagrammes Mermaid, formules, images liées) :
  -- AstroNvim coupe image.doc. Affichées sous Ghostty (Mac), avec les outils
  -- de rendu posés par ansible-home (mac/homebrew) ; sans effet sous Windows
  -- Terminal, qui n'a pas le protocole d'images de kitty.
  {
    "folke/snacks.nvim",
    opts = function(_, opts) opts.image = vim.tbl_deep_extend("force", opts.image or {}, { doc = { enabled = true } }) end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    cond = #coffres > 0,
    event = vim
      .iter(coffres)
      :map(function(coffre) return { "BufReadPre " .. coffre .. "/*.md", "BufNewFile " .. coffre .. "/*.md" } end)
      :flatten()
      :totable(),
    cmd = "Obsidian",
    opts = function(_, opts)
      opts.workspaces = vim.tbl_map(
        function(coffre) return { name = vim.fn.fnamemodify(coffre, ":t"), path = coffre } end,
        coffres
      )
      return opts
    end,
  },
}

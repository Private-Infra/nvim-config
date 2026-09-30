-- Réglages propres à cette config, par-dessus les packs de community.lua.

-- Coffre Obsidian : chemin dans OBSIDIAN_VAULT, défini par ansible-home
-- (obsidian_vault_path). Sans lui, obsidian.nvim ne se charge pas.
local coffre = vim.env.OBSIDIAN_VAULT and vim.fn.expand(vim.env.OBSIDIAN_VAULT)

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
  {
    "obsidian-nvim/obsidian.nvim",
    cond = coffre ~= nil and vim.fn.isdirectory(coffre) == 1,
    event = coffre and { "BufReadPre " .. coffre .. "/*.md", "BufNewFile " .. coffre .. "/*.md" } or nil,
    cmd = "Obsidian",
    opts = function(_, opts)
      opts.workspaces = { { name = "coffre", path = coffre } }
      return opts
    end,
  },
}

-- Réglages propres à cette config, par-dessus les packs de community.lua.

-- Coffre Obsidian : chemin dans OBSIDIAN_VAULT (~/.config/zsh/local.zsh du
-- poste). Sans lui, obsidian.nvim ne se charge pas.
local coffre = vim.env.OBSIDIAN_VAULT and vim.fn.expand(vim.env.OBSIDIAN_VAULT)

---@type LazySpec
return {
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

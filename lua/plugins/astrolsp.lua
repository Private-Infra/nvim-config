-- LSP (`:h astrolsp`). Les serveurs eux-mêmes viennent des packs
-- (community.lua).

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      -- Formatage à l'enregistrement limité aux langages dont le formateur
      -- est aussi celui des dépôts (ruff, stylua, shfmt). Pas de YAML : un
      -- formateur générique réécrirait les rôles Ansible et leurs templates.
      format_on_save = {
        enabled = true,
        allow_filetypes = { "lua", "python", "sh", "bash" },
      },
      timeout_ms = 3000,
    },
  },
}

-- Apparence (`:h astroui`).
--
-- Le thème suit celui du terminal : `theme dark|light` (rôle theme_switcher
-- d'ansible-home) écrit ~/.config/theme/nvim-colorscheme. Relu au démarrage
-- ici, et au retour du focus dans polish.lua.

local M = {}

function M.mode_theme()
  local f = io.open(vim.fn.expand "~/.config/theme/nvim-colorscheme")
  if not f then return "dark" end
  local mode = f:read "*l"
  f:close()
  return mode == "light" and "light" or "dark"
end

M.colorschemes = { dark = "astrodark", light = "astrolight" }

_G.frosty_theme = M

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = M.colorschemes[M.mode_theme()],
  },
}

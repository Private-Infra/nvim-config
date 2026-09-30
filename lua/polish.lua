-- Exécuté en dernier, après le chargement des plugins.

-- Presse-papier par OSC 52 sous WSL et en SSH : le terminal (Windows
-- Terminal, Ghostty) reçoit la copie, sans xclip ni serveur X, y compris à
-- travers tmux (set-clipboard on).
if vim.fn.has "wsl" == 1 or vim.env.SSH_TTY then vim.g.clipboard = "osc52" end

-- Thème : suit `theme dark|light` sans redémarrer nvim, au retour du focus
-- (tmux transmet l'événement : focus-events on).
vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Suivre le thème clair/sombre du terminal",
  callback = function()
    local theme = _G.frosty_theme
    if not theme then return end
    local voulu = theme.colorschemes[theme.mode_theme()]
    if vim.g.colors_name ~= voulu then vim.cmd.colorscheme(voulu) end
  end,
})

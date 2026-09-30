-- Installation synchrone de tout ce que la config télécharge :
--   nvim --headless -S scripts/install.lua
-- 1. plugins au commit du lazy-lock.json ;
-- 2. parsers Treesitter de la config (compilés, il faut tree-sitter et cc) ;
-- 3. outils Mason des packs (LSP, formateurs, linters).
--
-- Chaque étape attend la fin de la précédente. Un nvim headless qui quitte
-- pendant une installation en arrière-plan laisse des dossiers à moitié
-- écrits dans ~/.cache/nvim, et le lancement suivant échoue en les
-- retrouvant (ENOTEMPTY). Utilisé par la CI et par ansible-home (rôle
-- astro_nvim).

local function etape(nom, fn)
  io.stdout:write(nom .. "…\n")
  local ok, err = pcall(fn)
  if not ok then io.stderr:write(("%s : %s\n"):format(nom, err)) end
  return ok
end

local ok = true

ok = etape("Plugins (lazy-lock.json)", function() vim.cmd "Lazy! restore" end) and ok

ok = etape("Parsers Treesitter", function()
  if vim.fn.executable "tree-sitter" ~= 1 then
    io.stdout:write "  tree-sitter absent : parsers installés au prochain lancement qui l'aura\n"
    return
  end
  local langs = require("astrocore").config.treesitter.ensure_installed
  if type(langs) == "table" and #langs > 0 then
    -- Attend aussi les installations déjà lancées par astrocore au démarrage.
    require("nvim-treesitter").install(langs):wait(20 * 60 * 1000)
  end
end) and ok

ok = etape("Outils Mason", function() vim.cmd "MasonToolsInstallSync" end) and ok

vim.cmd(ok and "qa!" or "cquit 1")

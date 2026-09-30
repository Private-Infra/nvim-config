-- Test de démarrage : la config se charge et ouvre les types de fichiers de
-- la stack sans erreur. Lancé par la CI (et à la main) :
--   nvim --headless -S scripts/smoke-test.lua
-- Code de sortie 1 si un message d'erreur apparaît ou si un type attendu
-- n'est pas reconnu.

local attendus = {
  ["roles/web/tasks/main.yml"] = "ansible",
  ["roles/web/templates/app.sh.j2"] = "sh.jinja2",
  ["roles/web/templates/config.yml.j2"] = "yaml.jinja2",
  ["script.py"] = "python",
  ["script.sh"] = "sh",
  ["Dockerfile"] = "dockerfile",
  ["notes.md"] = "markdown",
  ["init.lua"] = "lua",
}

local racine = vim.fn.tempname()
local erreurs = {}

vim.defer_fn(function()
  for chemin, attendu in pairs(attendus) do
    local fichier = racine .. "/" .. chemin
    vim.fn.mkdir(vim.fn.fnamemodify(fichier, ":h"), "p")
    vim.fn.writefile({}, fichier)
    vim.cmd("edit " .. vim.fn.fnameescape(fichier))
    if vim.bo.filetype ~= attendu then
      table.insert(erreurs, ("%s : type %q, attendu %q"):format(chemin, vim.bo.filetype, attendu))
    end
  end
  local messages = vim.api.nvim_exec2("messages", { output = true }).output
  for ligne in messages:gmatch "[^\n]+" do
    if ligne:match "E%d+:" or ligne:match "[Ee]rror" then table.insert(erreurs, "message : " .. ligne) end
  end
  if #erreurs > 0 then
    io.stderr:write("ÉCHEC\n" .. table.concat(erreurs, "\n") .. "\n")
    vim.cmd "cquit 1"
  else
    io.stdout:write "OK : config chargée, types reconnus, aucun message d'erreur\n"
    vim.cmd "qa!"
  end
end, 3000)

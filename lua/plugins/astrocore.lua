-- Options, types de fichiers et raccourcis de base (`:h astrocore`).

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        spelllang = { "fr", "en" },
        signcolumn = "yes",
        wrap = false,
        scrolloff = 8,
        undofile = true,
      },
      g = {
        -- Templates Jinja d'Ansible : ansible-vim (pack ansible) les passe en
        -- jinja2 ; avec cette table, en type composé (`sh.jinja2`) qui garde
        -- la coloration et le LSP du fichier rendu. Clés : regex « very
        -- magic » testées après un « / » du chemin, donc exclusives entre
        -- elles (l'ordre de la table n'est pas garanti).
        ansible_template_syntaxes = {
          ["[^/]*\\.sh\\.j2$"] = "sh",
          ["[^/]*\\.bash\\.j2$"] = "bash",
          ["[^/]*\\.zsh\\.j2$"] = "zsh",
          ["[^/]*\\.py\\.j2$"] = "python",
          ["[^/]*\\.ya?ml\\.j2$"] = "yaml",
          ["[^/]*\\.json\\.j2$"] = "json",
          ["[^/]*\\.toml\\.j2$"] = "toml",
          ["[^/]*\\.ini\\.j2$"] = "dosini",
          ["[^/]*tmux\\.conf\\.j2$"] = "tmux",
          ["[^/]*\\.(service|timer)\\.j2$"] = "systemd",
          ["[^/]*\\.md\\.j2$"] = "markdown",
          ["[^/]*\\.html\\.j2$"] = "html",
          ["[^/]*\\.lua\\.j2$"] = "lua",
          ["[^/]*\\.ps1\\.j2$"] = "ps1",
          ["Dockerfile[^/]*\\.j2$"] = "dockerfile",
        },
      },
    },
    mappings = {
      n = {
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
      },
    },
  },
}

local M = {}

-- Mappa dei progetti
local projects = {} 

local config = {}

function M.setup(user_config)
  local default_config = require("conifg")
  -- Merge the default config with the user config
  config = vim.tbl_deep_extend("force", default_config, user_config or {})

  projects = config.projects
end

function M.setup()
  vim.api.nvim_command("enew") -- apre un buffer vuoto
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "🛠️  Project Manager",
    "Seleziona un progetto:",
  })

  for key, proj in pairs(projects) do
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { string.format("[%s] %s", key, proj.name) })
  end

  -- Ascolta i tasti
  vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":q<CR>", { noremap = true })

  for key, proj in pairs(projects) do
    vim.keymap.set("n", key, function()
      -- Chiude Neovim e lo riapre nella directory del progetto
      local cmd = string.format("start cmd /k cd /d %q && nvim", proj.path)
      os.execute(cmd)
      vim.cmd("qall!")
    end, { buffer = true })
  end
end

return M

local M = {}

local config = {
  header = {},
  projects = {},
}

local selected_index = 1

function M.setup(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})
  M.render()
end

function M.render()
  vim.api.nvim_command("enew")
  vim.bo.bufhidden = "wipe"
  vim.bo.buftype = "nofile"
  vim.bo.swapfile = false
  vim.bo.buflisted = false
  vim.wo.cursorline = true

  local lines = vim.deepcopy(config.header)
  for i, proj in ipairs(config.projects) do
    local line = string.format(" [%d] %s : %s", i, proj.name, proj.path)
    table.insert(lines, line)
  end
  table.insert(lines, " [q] Exit")

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- Set cursor to the first project
  vim.api.nvim_win_set_cursor(0, { #config.header + 1, 0 })

  -- Keymaps
  vim.keymap.set("n", "<CR>", function()
    local row = vim.fn.line(".")
    local index = row - #config.header
    if config.projects[index] then
      local proj = config.projects[index]
      vim.cmd("cd " .. proj.path)
      vim.cmd("e .")
    end
  end, { buffer = true })

  vim.keymap.set("n", "q", ":q<CR>", { buffer = true })
end

return M


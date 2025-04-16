local M = {}

local config = {
  header = {},
  projects = {},
}

local selected_index = 1

function M.setup(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})
  
  -- Register command to switch between projects
  vim.api.nvim_create_user_command(
    "AlphaProjects",
    function(project)
      print(string.format("%s : %s", config.projects[project]))
    end,
    { desc = "Switch to next project" }
  )

end

return M


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
    "Pman",
    function(opts)
      print()

      local project_name = opts.args[0]

      print(project_name .. " : " .. config.projects[project_name])
    end,
    { nargs = 1, desc = "Switch to project" }
  )

end

return M


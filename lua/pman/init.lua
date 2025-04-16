local M = {}

local config = {
  header = {
    "  ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄  ",
    " █  █  █ █       █       █  █ █  █   █  █▄█  █ ",
    " █   █▄█ █    ▄▄▄█   ▄   █  █▄█  █   █       █ ",
    " █       █   █▄▄▄█  █ █  █       █   █       █ ",
    " █  ▄    █    ▄▄▄█  █▄█  █       █   █       █ ",
    " █ █ █   █   █▄▄▄█       ██     ██   █ ██▄██ █ ",
    " █▄█  █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█ ",
  },
  projects = {
    ["p1"] = "/path/to/project1",
    ["p2"] = "/path/to/project2",
    ["p3"] = "/path/to/project3",
  },
}

local selected_index = 1

function M.setup(user_config)
  -- config = vim.tbl_deep_extend("force", config, user_config or {})
  
  -- Register command to switch between projects
  vim.api.nvim_create_user_command(
    "Pman",
    function(opts)
      local project_name = opts.args[0]

      local path = config.projects[project_name]

      print(project_name .. " : " .. path)
    end,
    { nargs = 1, desc = "Switch to project" }
  )
end

return M


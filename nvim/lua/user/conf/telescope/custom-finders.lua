local M = {}

local _, builtin = pcall(require, "telescope.builtin")

function M.find_project_files()
    local ok = pcall(builtin.git_files)
  
    if not ok then
      builtin.find_files()
    end
end
return M
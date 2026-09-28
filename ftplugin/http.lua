vim.bo.commentstring = "# %s"
vim.wo.conceallevel = 0
vim.opt_local.comments:remove("n:>")

local dotenv = require("rest-nvim.dotenv")

vim.b._rest_nvim_count = 1
vim.b._rest_nvim_env_file = dotenv.find_relevent_env_file()

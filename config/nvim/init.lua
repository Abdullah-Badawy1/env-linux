-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.keymap.set("n", "<leader>r", function()
  vim.cmd("w")
  local file = vim.fn.expand("%")
  local file_no_ext = vim.fn.expand("%:r")
  local file_dir = vim.fn.expand("%:p:h")
  local file_ext = vim.fn.expand("%:e")

  -- Determine compiler based on file extension
  local compiler = ""
  local std_flag = ""
  local warning_flags = "-Wall -Wextra -Wpedantic -Wshadow -Wformat=2 -Wconversion -Wsign-conversion"

  if file_ext == "c" then
    compiler = "gcc"
    std_flag = "-std=c11"
  elseif file_ext == "cpp" or file_ext == "cc" or file_ext == "cxx" then
    compiler = "clang++"
    std_flag = "-std=c++20"
    -- Add C++ specific warnings
    warning_flags = warning_flags .. " -Wnon-virtual-dtor -Wold-style-cast -Woverloaded-virtual"
  else
    vim.notify("Not a C/C++ file!", vim.log.levels.ERROR)
    return
  end

  -- Create floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.7)
  local buf = vim.api.nvim_create_buf(false, true)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
  })

  -- Run compilation and execution
  local cmd = string.format(
    "cd '%s' && %s %s %s -g -O0 -fno-omit-frame-pointer -fstack-protector-strong '%s' -o '%s' && ./'%s'; echo ''; echo 'Press ENTER to close...'; read",
    file_dir,
    compiler,
    std_flag,
    warning_flags,
    file,
    file_no_ext,
    vim.fn.fnamemodify(file_no_ext, ":t")
  )

  vim.fn.termopen(cmd)
  vim.cmd("startinsert")

  -- Close window with Esc in both normal and terminal mode
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":q<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "t", "<Esc>", "<C-\\><C-n>:q<CR>", { noremap = true, silent = true })
end, { desc = "Compile & Run C/C++ (floating terminal)" })

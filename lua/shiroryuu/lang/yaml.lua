-- =============================================================================
--  Jinja HTML Filetype Detection
-- =============================================================================
-- This module provides functionality to automatically detect if a file is
-- an HTML file using Jinja templating and sets the filetype accordingly.
-- This allows for loading specific LSPs, linters, and syntax highlighters.
--
-- To use this, you can call M.setup() from an autocommand, for example:
--
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*.html" },
--   callback = function()
--     require("your_module_name").setup()
--   end,
-- })
-- =============================================================================

local M = {}

local function is_ansible()
	local bufnr = 0

	local path = vim.api.nvim_buf_get_name(bufnr)
	local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "/n")

	-- check if file is in roles, tasks, or handlers folder
	local path_regex = vim.regex [[(tasks\|roles\|handlers)/]]

	if path_regex and path_regex:match_str(path) then
		return true
	end

	local regex = vim.regex [["hosts:\|tasks:"]]
	if regex and regex:match_str(content) then
		return true
	end

	return false
end

--
-- Checks if the current buffer contains an HTML file with Jinja syntax.
--
-- @return boolean: `true` if it's a Jinja HTML file, `false` otherwise.
--
local function is_jinja_html()
	-- Use 0 to represent the current buffer.
	local bufnr = 0

	-- Get the full path of the buffer.
	local path = vim.api.nvim_buf_get_name(bufnr)

	-- 1. First, ensure it's an HTML file to avoid running on other filetypes.
	-- We check for a ".html" extension at the end of the path.
	if not string.match(path, "%.html$") then
		return false
	end

	-- For performance, we only read the first 100 lines to check for content.
	-- This is usually enough to find template tags.
	local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, 100, false), "\n")

	-- 2. Check if the file path contains "/templates/".
	-- This is a very common convention for storing Jinja templates in web frameworks
	-- like Flask and Django.
	local path_regex = vim.regex [[/templates/]]
	if path_regex and path_regex:match_str(path) then
		return true
	end

	-- 3. If the path doesn't match, check the file's content for Jinja syntax.
	-- This regex looks for the three main Jinja delimiters:
	--   {{ ... }} for expressions (variables)
	--   {% ... %} for statements (loops, conditionals)
	--   {# ... #} for comments
	local jinja_syntax_regex = vim.regex [[\{\{.*\}\}\|\{%.*%\}|\{#.*#\}]]
	if jinja_syntax_regex and jinja_syntax_regex:match_str(content) then
		return true
	end

	-- If none of the checks pass, it's likely a standard HTML file.
	return false
end

--
-- Main setup function to be called by an autocommand.
-- It runs the detection logic and sets the filetype if necessary.
--
function M.setup()
	if is_ansible() then
		--load ansible lsp and ansible linter
		vim.bo.filetype = "yaml.ansible"
		-- load default yaml linter
    else if is_jinja_html() then
		-- Set the filetype to 'jinja.html'. This is a common convention
		-- that tools like Tree-sitter and various LSPs can use to provide
		-- combined support for both Jinja and HTML syntax.
		vim.bo.filetype = "jinja.html"

		-- You can uncomment the line below for debugging purposes to confirm
		-- that the detection is working as expected.
		-- print("Jinja HTML detected: set filetype to jinja.html")
	end
end

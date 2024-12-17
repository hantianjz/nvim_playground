print("!@34")

P(vim.api.nvim_list_runtime_paths())

local logger = require("plenary.log").new({ plugin = "my_plugin", level = "info", use_console = "sync" })
logger.info("@13")
logger.info("@13")

local function ts_diff(start_ts, end_ts)
  local sec = end_ts.sec - start_ts.sec
  local nsec = end_ts.nsec - start_ts.nsec
  if nsec < 0 then
    nsec = 1000000000 + nsec
    sec = sec - 1
  end
  local pad = string.rep("0", 9-string.len(""..nsec))

  return sec.. "."..pad..nsec
end

local a  = vim.uv.clock_gettime("realtime")
local b  = vim.uv.clock_gettime("realtime")
P(a)
P(b)
print("diff: ",  ts_diff(a, b))

P(vim.api.nvim_get_autocmds({ group="semhl", buffer=2}))
P(vim.bo[1].filetype)

print(math.random(1))

local function recursive_child_iter(node, table_to_insert, desired_types)
  if node:iter_children() then
    for child in node:iter_children() do
      if desired_types then
        if vim.tbl_contains(desired_types, child:type()) then
          table.insert(table_to_insert, child)
        end
      else
        table.insert(table_to_insert, child)
      end

      recursive_child_iter(child, table_to_insert, desired_types)
    end
  end
end


local start_ts = vim.uv.clock_gettime("realtime")
local parser = vim.treesitter.get_parser(1)
local trees = parser:parse()
local root = trees[1]:root()

children = {}
recursive_child_iter(root, children, { "identifier", "type_identifier", "field_identifier" })

for _, nn in ipairs(children) do
  local node_text = vim.treesitter.get_node_text(nn, 1)
  --print(node_text)
end
local end_ts = vim.uv.clock_gettime("realtime")
print(ts_diff(start_ts, end_ts))

local start_ts = vim.uv.clock_gettime("realtime")
local parser = vim.treesitter.get_parser(1)
local tree = parser:parse()[1]

local query = vim.treesitter.query.parse(parser:lang(), "(identifier) @id")
P(query)
for id, node, metadata, match in query:iter_captures(tree:root(), 1, 76, 77) do
  local type = node:type() -- type of the captured node
  local row1, col1, row2, col2 = node:range() -- range of the capture
  print(vim.treesitter.get_node_text(node, 1).."- ".. node:parent():type().." -".."; ["..row1..":"..col1.."; "..row2..":"..col2.."]")
end

local end_ts = vim.uv.clock_gettime("realtime")
print(ts_diff(start_ts, end_ts))
print(ts_diff(start_ts, end_ts))

if next({}) then
  print("true")
else
  print("false")
end
abecd

vim.api.nvim_buf_set_extmark(1, 2, 88, 2, { end_col = 7, hl_group = "sfg_1138e5" })


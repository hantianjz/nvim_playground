print("!@34")
P(vim.api.nvim_list_runtime_paths())

logger = require("plenary.log").new({ plugin = "my_plugin", level = "info", use_console = "sync" })
logger.info("@13")
logger.info("@13")

function ts_diff(start_ts, end_ts) 
  local sec = end_ts.sec - start_ts.sec
  local nsec = end_ts.nsec - start_ts.nsec
  if nsec < 0 then
    nsec = 1000000000 + nsec
    sec = sec - 1
  end
  pad = string.rep("0", 9-string.len(""..nsec))

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

local buffer = 1
if vim.treesitter.language.add('lua') then
  vim.treesitter.start(buffer, 'lua')
end


function on_change()
print("changed tree")
end
local parser = vim.treesitter.get_parser( buffer)
parser:register_cbs({on_changetree=on_change}, true)
local trees = parser:parse()

local root = trees[1]:root()


local children = {}
recursive_child_iter(root, children, { "identifier", "type_identifier", "field_identifier" })

for _, nn in ipairs(children) do
  local node_text = vim.treesitter.get_node_text(nn, buffer)
end

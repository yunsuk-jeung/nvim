local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local vscode = require 'vscode'

local function call(command)
  return function()
    vscode.call(command)
  end
end

-- Let VS Code handle its native find shortcut.
map({ 'n', 'x', 'i' }, '<C-f>', call 'actions.find', opts)

-- Normal mode mappings for folding
map('n', 'za', call 'editor.toggleFold', opts)
map('n', 'zR', call 'editor.unfoldAll', opts)
map('n', 'zM', call 'editor.foldAll', opts)
map('n', 'zo', call 'editor.unfold', opts)
map('n', 'zO', call 'editor.unfoldRecursively', opts)
map('n', 'zc', call 'editor.fold', opts)
map('n', 'zC', call 'editor.foldRecursively', opts)

-- Fold level mappings
map('n', 'z1', call 'editor.foldLevel1', opts)
map('n', 'z2', call 'editor.foldLevel2', opts)
map('n', 'z3', call 'editor.foldLevel3', opts)
map('n', 'z4', call 'editor.foldLevel4', opts)
map('n', 'z5', call 'editor.foldLevel5', opts)
map('n', 'z6', call 'editor.foldLevel6', opts)
map('n', 'z7', call 'editor.foldLevel7', opts)

-- Visual mode mapping
map('x', 'zV', call 'editor.foldAllExcept', opts)

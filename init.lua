require("jgj.core")
require("jgj.lazy")

-- Set borders for all floating windows
vim.o.winborder = 'rounded'

-- silence annoying telescope warnings. This should be fixed by next release
local notify_original = vim.notify
vim.notify = function(msg, ...)
  if
    msg
    and (
        msg:match 'jump_to_location is deprecated'
        or msg:match 'position_encoding param is required'
        or msg:match 'Defaulting to position encoding of the first client'
        or msg:match 'multiple different client offset_encodings'
    )
  then
    return
  end
  return notify_original(msg, ...)
end

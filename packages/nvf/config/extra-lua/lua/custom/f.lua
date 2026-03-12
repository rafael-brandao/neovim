local M = {}


M.fun = function(t)
  local f = t[1]
  local args = { unpack(t, 2) }
  return function()
    return f(unpack(args))
  end
end


M.fn = function(f, ...)
  local args = { ... }
  return function(...)
    return f(unpack(args), ...)
  end
end


M.safely = function(id, f)
  local ok, err = pcall(f)
  if not ok then
    vim.notify(
      string.format('[%s] Error: %s', id, err),
      vim.log.levels.ERROR
    )
  end
end


M.later = function(f, id)
  vim.schedule(function()
    M.safely(id or 'later', f)
  end)
end


return M

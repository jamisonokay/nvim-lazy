 local function split_tag(line, min_attrs)
  local indent, name, rest = line:match("^(%s*)<([%a][%w%.:%-]*)%s+(.+)$")
  if not indent then return nil end

  local attrs, cur = {}, {}
  local quote, depth = nil, 0
  local selfclose, after = false, nil
  local i, n = 1, #rest

  local function flush()
    if #cur > 0 then
      attrs[#attrs + 1] = table.concat(cur)
      cur = {}
    end
  end

  while i <= n do
    local c = rest:sub(i, i)
    if quote then
      cur[#cur + 1] = c
      if c == "\\" and i < n then
        i = i + 1
        cur[#cur + 1] = rest:sub(i, i)
      elseif c == quote then
        quote = nil
      end
    elseif c == '"' or c == "'" or c == "`" then
      quote = c
      cur[#cur + 1] = c
    elseif c == "{" then
      depth = depth + 1
      cur[#cur + 1] = c
    elseif c == "}" then
      depth = depth - 1
      cur[#cur + 1] = c
    elseif depth == 0 and c:match("%s") then
      flush()
    elseif depth == 0 and c == ">" then
      flush()
      after = rest:sub(i + 1)
      break
    else
      cur[#cur + 1] = c
    end
    i = i + 1
  end

  if not after then return nil end -- тег не закрыт на этой строке

  -- самозакрывающийся тег: `/` в конце последнего атрибута или отдельный токен
  local last = attrs[#attrs]
  if last == "/" then
    table.remove(attrs)
    selfclose = true
  elseif last and last:sub(-1) == "/" and not last:find("=$") then
    attrs[#attrs] = last:sub(1, -2)
    selfclose = true
  end

  -- условные атрибуты templ (`if cond { attr }`) не трогаем
  for _, a in ipairs(attrs) do
    if a == "if" or a == "else" then return nil end
  end

  if #attrs < min_attrs then return nil end

  local out = { indent .. "<" .. name }
  for _, a in ipairs(attrs) do
    out[#out + 1] = indent .. "\t" .. a
  end
  out[#out + 1] = indent .. (selfclose and "/>" or ">") .. after
  return out
end

local function split_attrs(lines)
  local min_attrs = 2 -- сколько атрибутов минимум, чтобы разбивать
  local result = {}
  for _, line in ipairs(lines) do
    local trimmed = line:match("^%s*(.*)$")
    local split = nil
    -- только открывающие теги; `</...>` и `<!...>` пропускаем
    if trimmed:match("^<%a") then
      split = split_tag(line, min_attrs)
    end
    if split then
      vim.list_extend(result, split)
    else
      result[#result + 1] = line
    end
  end
  return result
end

return {
    split_attrs = split_attrs,
}

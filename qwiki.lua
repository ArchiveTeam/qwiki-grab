dofile("urlcode.lua")
dofile("table_show.lua")
JSON = (loadfile "JSON.lua")()

local url_count = 0
local tries = 0
local item_type = os.getenv('item_type')
local item_value = os.getenv('item_value')

local downloaded = {}

load_json_file = function(file)
  if file then
    local f = io.open(file)
    local data = f:read("*all")
    f:close()
    return JSON:decode(data)
  else
    return nil
  end
end

read_file = function(file)
  if file then
    local f = assert(io.open(file))
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

wget.callbacks.download_child_p = function(urlpos, parent, depth, start_url_parsed, iri, verdict, reason)
  local url = urlpos["url"]["url"]
  local html = urlpos["link_expect_html"]
  local parenturl = parent["url"]
  local html = nil
  
  if downloaded[url] == true then
    return false
  end
  
  if item_type == "page" then
    if string.match(url, "/v/"..item_value)
      or string.match(url, "cdn[0-9]+%.qwiki%.com")
      or string.match(url, "p%.typekit%.com")
      or string.match(url, "use%.typekit%.com")
      or string.match(url, "[^%.]+%.cloudfront%.net")
      or string.match(url, "[^%.]+%.amazonaws.com")
      or string.match(url, "%.json")
      or string.match(url, "%.m3u8")
      or string.match(url, "ikiwq%.com")
      or string.match(url, "/api/")
      or string.match(url, "qwikis%-production%.qwiki%.com")
      or string.match(url, "/assets/") then
      return true
    else
      return false
    end
  end
  
end


wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  local html = nil
  
  if item_type == "page" then
    if string.match(url, "s1%.ikiwq%.com") then
      local newurl = string.gsub(url, "s1%.ikiwq%.com", "d1gk3e6myre8ic%.cloudfront%.net")
      if downloaded[newurl] ~= true then
        table.insert(urls, { url=newurl })
      end
    elseif string.match(url, "vp1%.ikiwq%.com") then
      local newurl = string.gsub(url, "vp1%.ikiwq%.com", "d2japcd9yzs5kz%.cloudfront%.net")
      if downloaded[newurl] ~= true then
        table.insert(urls, { url=newurl })
      end
    elseif string.match(url, "qp1%.ikiwq%.com") then
      local newurl = string.gsub(url, "qp1%.ikiwq%.com", "d124swhenejuz9%.cloudfront%.net")
      if downloaded[newurl] ~= true then
        table.insert(urls, { url=newurl })
      end
    elseif string.match(url, "d1gk3e6myre8ic%.cloudfront%.net") then
      local newurl = string.gsub(url, "d1gk3e6myre8ic%.cloudfront%.net", "s1%.ikiwq%.com")
      if downloaded[newurl] ~= true then
        table.insert(urls, { url=newurl })
      end
    elseif string.match(url, "d2japcd9yzs5kz%.cloudfront%.net") then
      local newurl = string.gsub(url, "d2japcd9yzs5kz%.cloudfront%.net", "vp1%.ikiwq%.com")
      if downloaded[newurl] ~= true then
        table.insert(urls, { url=newurl })
      end
    elseif string.match(url, "d124swhenejuz9%.cloudfront%.net") then
      local newurl = string.gsub(url, "d124swhenejuz9%.cloudfront%.net", "qp1%.ikiwq%.com")
      if downloaded[newurl] ~= true then
        table.insert(urls, { url=newurl })
      end
    end
    if string.match(url, item_value)
      or string.match(url, "%.json")
      or string.match(url, "%.m3u8") then
      html = read_file(file)
      
      for customurl in string.gmatch(html, '"(http[s]?://[^"]+)"') do
        if string.match(customurl, "/v/"..item_value)
          or string.match(customurl, "cdn[0-9]+%.qwiki%.com")
          or string.match(customurl, "p%.typekit%.com")
          or string.match(customurl, "use%.typekit%.com")
          or string.match(customurl, "[^%.]+%.cloudfront%.net")
          or string.match(customurl, "[^%.]+%.amazonaws.com")
          or string.match(customurl, "%.json")
          or string.match(customurl, "%.m3u8")
          or string.match(customurl, "ikiwq%.com")
          or string.match(customurl, "/api/")
          or string.match(customurl, "qwikis%-production%.qwiki%.com")
          or string.match(customurl, "/assets/") then
          if downloaded[customurl] ~= true then
            table.insert(urls, { url=customurl })
          end
          if string.match(customurl, "s1%.ikiwq%.com") then
            local newurl = string.gsub(customurl, "s1%.ikiwq%.com", "d1gk3e6myre8ic%.cloudfront%.net")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "vp1%.ikiwq%.com") then
            local newurl = string.gsub(customurl, "vp1%.ikiwq%.com", "d2japcd9yzs5kz%.cloudfront%.net")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "qp1%.ikiwq%.com") then
            local newurl = string.gsub(customurl, "qp1%.ikiwq%.com", "d124swhenejuz9%.cloudfront%.net")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "d1gk3e6myre8ic%.cloudfront%.net") then
            local newurl = string.gsub(customurl, "d1gk3e6myre8ic%.cloudfront%.net", "s1%.ikiwq%.com")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "d2japcd9yzs5kz%.cloudfront%.net") then
            local newurl = string.gsub(customurl, "d2japcd9yzs5kz%.cloudfront%.net", "vp1%.ikiwq%.com")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "d124swhenejuz9%.cloudfront%.net") then
            local newurl = string.gsub(customurl, "d124swhenejuz9%.cloudfront%.net", "qp1%.ikiwq%.com")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          end
        end
      end
      for customurlnf in string.gmatch(html, '"(/[^"]+)"') do
        if string.match(customurlnf, "/v/"..item_value)
          or string.match(customurlnf, "cdn[0-9]+%.qwiki%.com")
          or string.match(customurlnf, "p%.typekit%.com")
          or string.match(customurlnf, "use%.typekit%.com")
          or string.match(customurlnf, "[^%.]+%.cloudfront%.net")
          or string.match(customurlnf, "[^%.]+%.amazonaws.com")
          or string.match(customurlnf, "ikiwq%.com")
          or string.match(customurlnf, "/api/")
          or string.match(customurlnf, "qwikis%-production%.qwiki%.com")
          or string.match(customurlnf, "/assets/") then
          local base = "http://www.qwiki.com"
          local customurl = base..customurlnf
          if downloaded[customurl] ~= true then
            table.insert(urls, { url=customurl })
          end
          if string.match(customurl, "s1%.ikiwq%.com") then
            local newurl = string.gsub(customurl, "s1%.ikiwq%.com", "d1gk3e6myre8ic%.cloudfront%.net")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "vp1%.ikiwq%.com") then
            local newurl = string.gsub(customurl, "vp1%.ikiwq%.com", "d2japcd9yzs5kz%.cloudfront%.net")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "qp1%.ikiwq%.com") then
            local newurl = string.gsub(customurl, "qp1%.ikiwq%.com", "d124swhenejuz9%.cloudfront%.net")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "d1gk3e6myre8ic%.cloudfront%.net") then
            local newurl = string.gsub(customurl, "d1gk3e6myre8ic%.cloudfront%.net", "s1%.ikiwq%.com")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "d2japcd9yzs5kz%.cloudfront%.net") then
            local newurl = string.gsub(customurl, "d2japcd9yzs5kz%.cloudfront%.net", "vp1%.ikiwq%.com")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "d124swhenejuz9%.cloudfront%.net") then
            local newurl = string.gsub(customurl, "d124swhenejuz9%.cloudfront%.net", "qp1%.ikiwq%.com")
            if downloaded[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          end
        end
      end
      for tsurl in string.gmatch(html, "#EXTINF:[0-9]+,[^0123456789abcdefghijklmnopqrstuvwxyz]+([^%.]+%.ts)") do
        local base = string.match(url, "(http://[^/]+/[^/]+/[^/]+/[^/]+/)")
        local fulltsurl = base..tsurl
        if downloaded[fulltsurl] ~= true then
          table.insert(urls, { url=fulltsurl })
        end
        if string.match(fulltsurl, "s1%.ikiwq%.com") then
          local newurl = string.gsub(fulltsurl, "s1%.ikiwq%.com", "d1gk3e6myre8ic%.cloudfront%.net")
          if downloaded[newurl] ~= true then
            table.insert(urls, { url=newurl })
          end
        elseif string.match(fulltsurl, "vp1%.ikiwq%.com") then
          local newurl = string.gsub(fulltsurl, "vp1%.ikiwq%.com", "d2japcd9yzs5kz%.cloudfront%.net")
          if downloaded[newurl] ~= true then
            table.insert(urls, { url=newurl })
          end
        elseif string.match(fulltsurl, "qp1%.ikiwq%.com") then
          local newurl = string.gsub(fulltsurl, "qp1%.ikiwq%.com", "d124swhenejuz9%.cloudfront%.net")
          if downloaded[newurl] ~= true then
            table.insert(urls, { url=newurl })
          end
        elseif string.match(fulltsurl, "d1gk3e6myre8ic%.cloudfront%.net") then
          local newurl = string.gsub(fulltsurl, "d1gk3e6myre8ic%.cloudfront%.net", "s1%.ikiwq%.com")
          if downloaded[newurl] ~= true then
            table.insert(urls, { url=newurl })
          end
        elseif string.match(fulltsurl, "d2japcd9yzs5kz%.cloudfront%.net") then
          local newurl = string.gsub(fulltsurl, "d2japcd9yzs5kz%.cloudfront%.net", "vp1%.ikiwq%.com")
          if downloaded[newurl] ~= true then
            table.insert(urls, { url=newurl })
          end
        elseif string.match(fulltsurl, "d124swhenejuz9%.cloudfront%.net") then
          local newurl = string.gsub(fulltsurl, "d124swhenejuz9%.cloudfront%.net", "qp1%.ikiwq%.com")
          if downloaded[newurl] ~= true then
            table.insert(urls, { url=newurl })
          end
        end
      end
    end
  end
  
  return urls
end
  

wget.callbacks.httploop_result = function(url, err, http_stat)
  -- NEW for 2014: Slightly more verbose messages because people keep
  -- complaining that it's not moving or not working
  local status_code = http_stat["statcode"]
  
  url_count = url_count + 1
  io.stdout:write(url_count .. "=" .. status_code .. " " .. url["url"] .. ".  \n")
  io.stdout:flush()
  
  if (status_code >= 200 and status_code <= 399) or status_code == 403 then
    downloaded[url.url] = true
  end
  
  if status_code >= 500 or
    (status_code >= 400 and status_code ~= 404 and status_code ~= 403) then
    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 1")

    tries = tries + 1

    if tries >= 20 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  elseif status_code == 0 then
    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")

    tries = tries + 1

    if tries >= 10 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  end

  tries = 0

  -- We're okay; sleep a bit (if we have to) and continue
  -- local sleep_time = 0.1 * (math.random(75, 1000) / 100.0)
  local sleep_time = 0

  --  if string.match(url["host"], "cdn") or string.match(url["host"], "media") then
  --    -- We should be able to go fast on images since that's what a web browser does
  --    sleep_time = 0
  --  end

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end

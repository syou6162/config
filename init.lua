local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()      
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

remapKey({'ctrl'}, 'j', keyCode('kana'))

-- ホットキーの割り当て
-- アプリ名だとVSCodeで動かない場合があるため、bundleIDを使う
-- ref: https://github.com/Hammerspoon/hammerspoon/issues/2075
-- bundleIDは以下のコマンドで取得できる
-- lsappinfo info -only bundleid Finder

function toggleApp(key, modifiers, bundleID)
  hs.hotkey.bind(key, modifiers, function()
    local app = hs.application.get(bundleID)
    if app == nil then
      hs.application.launchOrFocusByBundleID(bundleID)
    elseif app:isFrontmost() then
      app:hide()
    else
      hs.application.launchOrFocusByBundleID(bundleID)
    end
  end)
end

toggleApp({"ctrl", "shift"}, "s", "com.tinyspeck.slackmacgap") -- Slack
toggleApp({"ctrl", "shift"}, "c", "com.google.Chrome")
toggleApp({"ctrl"}, "i", "com.microsoft.VSCode")
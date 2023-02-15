hs.hotkey.bind({"cmd", "ctrl"}, "V", function()
  hs.notify.new({ title="Hammerspoon", informativeText="Hello World!" }):send()
end)

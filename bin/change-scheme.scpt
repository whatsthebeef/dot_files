on run argv
   tell application "Terminal" 
      set current settings of first window to settings set (item 1 of argv) 
      -- set default settings to settings set (item 1 of argv) 
   end tell 
end run

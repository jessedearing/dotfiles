activate application "SystemUIServer"
tell application "System Events"
  tell process "SystemUIServer"
    set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
    tell btMenu
      click
      tell (menu item "Jesse Dearing's Keyboard" of menu 1)
        click
        if exists menu item "Disconnect" of menu 1 then
          click menu item "Disconnect" of menu 1
          return "Connecting..."
        else
          click btMenu -- Close main BT drop down if Connect wasn't present
          return "Connect menu was not found, are you already connected?"
        end if
      end tell
    end tell
  tell process "SystemUIServer"
    set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
    tell btMenu
      click
      tell (menu item "jessed's Trackpad" of menu 1)
        click
        if exists menu item "Disconnect" of menu 1 then
          click menu item "Disconnect" of menu 1
          return "Connecting..."
        else
          click btMenu -- Close main BT drop down if Connect wasn't present
          return "Connect menu was not found, are you already connected?"
        end if
      end tell
    end tell
  tell process "SystemUIServer"
    set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
    tell btMenu
      click
      tell (menu item "MPOW-059" of menu 1)
        click
        if exists menu item "Disconnect" of menu 1 then
          click menu item "Disconnect" of menu 1
          return "Connecting..."
        else
          click btMenu -- Close main BT drop down if Connect wasn't present
          return "Connect menu was not found, are you already connected?"
        end if
      end tell
    end tell
  end tell
end tell

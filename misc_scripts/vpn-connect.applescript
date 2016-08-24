on run argv
	try
    set vpnName to item 1 of argv
	on error
		set vpnName to "qa"
	end try
	tell application "Tunnelblick"
		connect vpnName
		set connState to ""
		repeat until connState = "CONNECTED"
			set connState to (get state of configuration 1 whose name = vpnName)
			delay 1
		end repeat
	end tell
end run

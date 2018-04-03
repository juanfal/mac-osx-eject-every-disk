-- mac-osx-eject-every-disk
-- juanfal 2018-04-03
-- This AppleScript can be executed at any moment in a Mac.
-- It doen's depend on any external routine and only call a shell command to
--   play sounds



-- It does the following steps:

-- 1. Hide all the windows to show the Finder Desktop
-- 2. Count the **mounted** disks
-- 3. If there are any mounted disks except the system disk and system virtual
--    disks it will try to eject them
-- 4. After the ejection ends, it re-counts to see if any disk is left, warning you if so

-- Note that the delays are there to allow you to free the keyboard modifiers
-- (I'm supposing you are using a keyboard shortcut to launch this script) so
-- the system does not see any key modifier pressed

hideshowwindows()
set extraMountedDisks to disksExtra()

if (count of extraMountedDisks) > 0 then
	set text item delimiters to ", "
	display notification "Ejecting: " & (extraMountedDisks as string) with title "Ejecting every disk"
else
	--say "No disk to eject"
	display notification "Nothing to eject" with title "Ejecting every disk"
	play("Basso", 1)
	hideshowwindows()
	return
end if

play("Glass", 1)

-- say "Start ejecting disks"
try
	-- tell application "Finder" to eject (every disk whose startup is false and free space > 0)
	repeat with theDisk in extraMountedDisks
		tell application "Finder" to eject theDisk
	end repeat
on error
	play("Basso", 1)
	say "Error expulsando discos"
	display notification "Error ejecting disks" with title "Ejecting every disk"

end try
set extraMountedDisks to disksExtra()
if (count of extraMountedDisks) > 0 then
	delay 1
end if
set extraMountedDisks to disksExtra()

if (count of extraMountedDisks) = 0 then
	play("Glass", 2)
	display notification "Done!" with title "Ejecting every disk"
	--say "Disks already ejected"
else
	display notification "Error: Something still not ejected" with title "Ejecting every disk"
	play("Basso", 1)
	--say "Something yet not ejected"
end if


hideshowwindows()



-- FUNCTIONS ---------------------------

on hideshowwindows()
	delay 1  -- wait for the user to free modifiers keys
	tell application "System Events" to key code 103 -- F9 - Expose All Windows
end hideshowwindows

on disksExtra()
	-- set toIgnore to {".DS_Store", "Preboot", "com.apple.TimeMachine.localsnapshots"}
	-- tell application "Finder" to set mountedDisks to list folder POSIX file "/Volumes"

	set toIgnore to {"vm", "home", "net"}
	set r to {}
	tell application "System Events" to set the end of toIgnore to the name of startup disk
	tell application "System Events" to set mountedDisks to name of every disk
	repeat with x in mountedDisks
		if x is not in toIgnore then
			set end of r to x
		end if
	end repeat
	return r
end disksExtra

on play(what, n)
	repeat n times
		do shell script "afplay -t 0.1 /System/Library/Sounds/" & what & ".aiff"
	end repeat
end play
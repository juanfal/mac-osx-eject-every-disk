
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
	repeat with disco in extraMountedDisks
		tell application "Finder" to eject disco
	end repeat
on error
	play("Basso", 1)
	say "Error expulsando discos"
	display notification "Error" with title "Ejecting every disk"
	
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










on hideshowwindows()
	delay 1
	tell application "System Events" to key code 103 -- F9 - Expose All Windows
end hideshowwindows

on disksExtra()
	-- set toIgnore to {".DS_Store", "Preboot", "com.apple.TimeMachine.localsnapshots"}
	-- tell application "Finder" to set mountedDisks to list folder POSIX file "/Volumes"
	
	set toIgnore to {"vm", "home", "net"}
	set r to {}
	tell application "System Events" to set the end of toIgnore to the name of startup disk
	tell application "System Events" to set mountedDisks to name of every disk
	repeat with i from 1 to count mountedDisks
		set x to mountedDisks's item i
		if (last character of x is not "@") and (x is not in toIgnore) then set end of r to mountedDisks's item i
	end repeat
	return r
end disksExtra

on play(what, n)
	repeat n times
		do shell script "afplay -t 0.1 /System/Library/Sounds/" & what & ".aiff"
	end repeat
end play
# mac-osx-eject-every-disk

This AppleScript can be executed at any moment in a Mac.
It doen's depend on any external routine and only calls a shell command to
  play sounds



It takes the following steps:

1. Hide all the windows to show the Finder Desktop showing a system notification
2. Count the **mounted** disks
3. If there are any mounted disks except the system disk and system virtual
   disks it will try to eject them
4. After the ejection ends, it re-counts to see if any disk is left, warning you through a Notification about it

Note that the delays are there to allow you to free the keyboard modifiers
(I'm supposing you are using a keyboard shortcut to launch this script) so
the system does not see any key modifier pressed

NOTE: I'm using *QuickSilver* to trigger-launch (Execute) this script and using the shortcut: Opt-F12
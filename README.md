# mac-osx-eject-every-disk

juanfal 2018-04-03
This AppleScript can be executed at any moment in a Mac.
It doen's depend on any external routine and only call a shell command to
  play sounds



It does the following steps:

1. Hide all the windows to show the Finder Desktop
2. Count the **mounted** disks
3. If there are any mounted disks except the system disk and system virtual
   disks it will try to eject them
4. After the ejection ends, it re-counts to see if any disk is left, warning you if so

Note that the delays are there to allow you to free the keyboard modifiers
(I'm supposing you are using a keyboard shortcut to launch this script) so
the system does not see any key modifier pressed

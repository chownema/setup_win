# https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image 
# Note: run at an admin level
# Seems to fix slow start menu animation, and other things, maybe..
dism /online /cleanup-image /restorehealth

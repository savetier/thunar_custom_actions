# thunar_custom_actions
My custom actions for the Thunar file manager

![Thunar](https://raw.githubusercontent.com/savetier/thunar_custom_actions/main/thunar.png)


## Open Terminal Here

Name: Open Terminal here

Command: konsole --workdir %f

File Pattern: *

Appears: Directories


## Exctract with Peazip

Name: Extract here (PZ)

Command: peazip -ext2here %f

File Pattern: *.*

Appears: Check all

## Add to Archive with PeaZip

Name: Add to Archive (PZ)

Command: peazip -add2archive %F

File Pattern: *

Appears: Check all

## Create Hardlink

Name: Hardlink

Command: ln %f %n" (hardlink)"

File Pattern: *.*

Appears: Check all

## Create Symlink

Name: Hardlink

Command: ln -Ts %f %n" (symlink)"

File Pattern: *.*

Appears: Check all

## Convert to PDF

Name: -> PDF

Command: unoconv -f pdf %f

File Pattern: *.doc;*.docx;*.odt;*.odp;*.pps;*.ppt;*.xls;*.xlsx;*.ods;*.pptx

Appears: Other Files

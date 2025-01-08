# thunar_custom_actions
My custom actions for the Thunar file manager

![Thunar](https://raw.githubusercontent.com/savetier/thunar_custom_actions/main/thunar.png)


## Open Terminal Here

Name: Open Terminal here

Command: ```konsole --workdir %f```

File Pattern: ```*```

Appears: Directories

## Search in Folder

Name: Search here

Command: ```catfish --path=%f```

File Pattern: ```*```

Appears: Directories


## Exctract with Peazip

Name: Extract here (PZ)

Command: ```peazip -ext2here %f```

```flatpak run --branch=stable --arch=x86_64 --command=peazip --file-forwarding io.github.peazip.PeaZip -ext2here %f```

File Pattern: ```*.*```

Appears: Check all

## Add to Archive with PeaZip

Name: Add to Archive (PZ)

Command: ```peazip -add2archive %F```

```flatpak run --branch=stable --arch=x86_64 --command=peazip --file-forwarding io.github.peazip.PeaZip -add2archive %F```

File Pattern: ```*```

Appears: Check all

## Create Hardlink

Name: Hardlink

Command: ```ln %f %n" (hardlink)"```

File Pattern: ```*.*```

Appears: Check all

## Create Symlink

Name: Hardlink

Command: ```ln -Ts %f %n" (symlink)"```

File Pattern: ```*.*```

Appears: Check all

## Convert to PDF

Name: -> PDF

Command: ```unoconv -f pdf %f```

File Pattern: ```*.doc;*.docx;*.odt;*.odp;*.pps;*.ppt;*.xls;*.xlsx;*.ods;*.pptx```

Appears: Other Files

(Install ```unoconv``` first)

## Convert to ODT

Name: -> ODT

Command: ```unoconv -f odt %f```

File Pattern: ```*.doc;*.docx```

Appears: Other Files

(Install ```unoconv``` first)

## Create JPG

Name: > JPG

Command: ```convert %f `basename %f .png`.jpg```

File Pattern: ```*.png, *.PNG```

Appears: Check all

## Create PNG

Name: > PNG

Command: ```convert %f `basename %f .jpg`.png```

File Pattern: ```*.jpg, *.JPG,*.jpeg,*.JPEG```

Appears: Image Files, Other Files

#!/usr/bin/env bash

TmpFolder="/tmp/$RANDOM"
mkdir $TmpFolder

# Get the list of available printers
printers=$(lpstat -a | awk '{print $1}')

# Display the Zenity dropdown menu to select the printer
selected_printer=$(zenity --list --title="Select Printer" --text="Choose the printer to use:" --column="Printer" $printers)

if [ -z "$selected_printer" ]; then
  echo "No printer selected. Exiting..."
  exit 1
fi

print_file() {
  local file="$1"
  local pages="$2"

  if [ -n "$pages" ] && [ "$pages" != "all" ]; then
    lp -d "$selected_printer" -o page-ranges="$pages" "$file"
  else
    lp -d "$selected_printer" "$file"
  fi
}

print_image() {
  local file="$1"
  local NewName="$RANDOM"
  convert "$file" "$TmpFolder/$NewName.pdf"

  local print_options=$(zenity --list --title="Print Image" --text="Choose the print option:" --column="Option" "Original Size" "Fit to Page" "Stretch to Page" "Center on A4 (A6 size)" "Center on A4 (A5 size)")
  if [ $? -eq 0 ]; then
    case "$print_options" in
      "Original Size")
        print_file "$TmpFolder/$NewName.pdf"
        ;;
      "Fit to Page")
        print_file "$TmpFolder/$NewName.pdf" "-o fit-to-page"
        ;;
      "Stretch to Page")
        print_file "$TmpFolder/$NewName.pdf" "-o page-scale=to-fit"
        ;;
      "Center on A4 (A6 size)")
        print_file "$TmpFolder/$NewName.pdf" "-o page-left=50 -o page-top=75 -o page-width=105 -o page-height=148"
        ;;
      "Center on A4 (A5 size)")
        print_file "$TmpFolder/$NewName.pdf" "-o page-left=25 -o page-top=37 -o page-width=148 -o page-height=210"
        ;;
    esac
  else
    echo "Printing canceled for $file."
  fi
}

IFS=$(echo -en "\n\b")
for File in "$@"
do
  case "${File,,}" in
    *.doc|*.docx|*.xls|*.xlsx|*.odt|*.ods|*.pdf)
      pages=$(zenity --entry --title="Print Pages" --text="Enter the pages or page range to print (e.g., 1-3, 5, 7-10, all):")
      if [ $? -eq 0 ]; then
        print_file "$File" "$pages"
      else
        echo "Printing canceled for $File."
      fi
      ;;
    *.jpg|*.jpeg|*.png|*.tiff|*.tif|*.gif)
      print_image "$File"
      ;;
    *.ps|*.txt)
      print_file "$File"
      ;;
  esac
done

rm -rf "$TmpFolder"

exit 0

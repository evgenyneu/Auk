#!/bin/bash

#
#  Combines *.swift files into a single file. Usually
#
#  Usage
#  ------
#
#  ./combine_swift_files.sh source_dir destination_file [optional_header_text] [remove_line_text]
#
#
#  Example
#  --------
#
#  Use in external build tool in Xcode.
#
#  Build tool:
#
#    $PROJECT_DIR/scripts/concatenate_swift_files.sh
#
#  Arguments:
#
#    $PROJECT_DIR/MyProject $PROJECT_DIR/Distrib/MyDistrib.swift "// My header" "remove this line"
#

destination=$2
headermessage=$3
remove_text=$4

if [ "$#" -lt 2 ]
then
  echo "\nUsage:\n"
  echo "   ./combine_swift_files.sh source_dir destination_file [optional_header_text] [remove text]\n"
  exit 1
fi

# Create empty destination file
echo > "$destination";
text=""
destination_filename=$(basename "$destination")

for swift in `find $1 ! -name "$destination_filename" -name "*.swift"`;
do
  filename=$(basename "$swift")

  text="$text\n// ----------------------------";
  text="$text\n//";
  text="$text\n// ${filename}";
  text="$text\n//";
  text="$text\n// ----------------------------\n\n";

  if [ -n "$remove_text" ]
  then
    filecontent="$(cat "${swift}"| sed "/${remove_text}/d";)"
  else
    filecontent="$(cat "${swift}";)"
  fi

  text="$text$filecontent\n\n";

  echo "Combining $swift";
done;

# Add header message
if [ -n "$headermessage" ]
then
  text="$headermessage\n\n$text"
fi

# Write to destination file
echo -e "$text" > "$destination"

echo -e "\nSwift files combined into $destination"



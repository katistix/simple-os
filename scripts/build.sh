#!/bin/bash

# A script to build a <filename>.asm file into a <filename>.bin using `nasm`
# The output will be in the `bin` directory
# Usage: ./build.sh <file.asm>


# Check if nasm is installed
if ! [ -x "$(command -v nasm)" ]; then
  echo "Error: nasm is not installed." >&2
  exit 1
fi

# Check if a file was passed
if [ -z "$1" ]; then
  echo "Error: no file was passed." >&2
  exit 1
fi

# Check if the file exists
if ! [ -f "$1" ]; then
  echo "Error: file '$1' does not exist." >&2
  exit 1
fi

# Check if the file is a .asm file
if ! [[ "$1" =~ \.asm$ ]]; then
  echo "Error: file '$1' is not a .asm file." >&2
  exit 1
fi

# Get the file name without the extension
filename=$(basename -- "$1")
filename="${filename%.*}"

# Create the bin directory if it doesn't exist
mkdir -p bin

# Build the file
nasm -f bin -o "bin/$filename.bin" "$1"

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "Build successful."
else
  echo "Build failed." >&2
  exit 1
fi

# Make the file executable
chmod +x "bin/$filename.bin"
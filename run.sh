#!/usr/bin/env bash
set -euo pipefail

#bash script to compile and run everything

#argument 1 should be the file
file="$1"

#get the file name and extension
filename=$(basename -- "$file")
extension="${filename##*.}"
filename="${filename%.*}"

#   C / C++
if [[ "$extension" == "c" -o "$extension" == "cpp" ]]; then
    if gcc "$file" -o "$filename"; then
        ./"$filename"
    fi
fi 

#   PYTHON
if [[ "$extension" == "py" ]]; then
    python3 "$file"
fi 

#   JAVA
if [[ "$extension" == "java" ]]; then
    if javac "$file"; then
        java "$filename"
    fi
fi 

#   HASKELL
if [[ "$extension" == "hs" ]]; then
    if ghc --make "$filename"; then
        ./"$filename"
    fi
fi 

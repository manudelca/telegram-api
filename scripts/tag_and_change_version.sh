#!/bin/bash
set -e

echo "Script update Tag and Version"

function sedi {
  if [ "$(uname)" == "Linux" ]; then
    sed -i "$@"
  else
    sed -i "" "$@"
  fi
}

newMayorValue=0
newMinorValue=0
newPatchValue=0

echo "Please type in the new mayor"

read -r newMayorValue

sedi 's/MAYOR = [0-9a-zA-z -_]*/MAYOR = "'"$newMayorValue"'"/' ./version.rb

echo "Please type in the new minor"

read -r newMinorValue

echo "Please type in the new patch"

read -r newPatchValue

#ruby change_version.rb "$newMayorValue" "$newMinorValue" "$newPatchValue"

cd ..

#git add lib/version.rb

#git commit -m "[Version] $newMayorValue.$newMinorValue.$newPatchValue"

#git tag -a "$newMayorValue.$newMinorValue.$newPatchValue"

#git push

#git push --tags
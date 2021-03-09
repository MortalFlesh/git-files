#!/usr/bin/env bash

set -e

PHPSTORM="PhpStorm2021.1"

echo "Restore $PHPSTORM"
echo "==================="
echo ""

echo "Templates ..."
mkdir -p ~/Library/Application\ Support/JetBrains/$PHPSTORM/templates
cp phpstorm/templates/* ~/Library/Application\ Support/JetBrains/$PHPSTORM/templates/

echo "File templates - code ..."
mkdir -p ~/Library/Application\ Support/JetBrains/$PHPSTORM/fileTemplates/code
cp phpstorm/fileTemplates/code/* ~/Library/Application\ Support/JetBrains/$PHPSTORM/fileTemplates/code/

echo "File templates - includes ..."
mkdir -p ~/Library/Application\ Support/JetBrains/$PHPSTORM/fileTemplates/includes
cp phpstorm/fileTemplates/includes/* ~/Library/Application\ Support/JetBrains/$PHPSTORM/fileTemplates/includes/

echo "Scratches ..."
mkdir -p ~/Library/Application\ Support/JetBrains/$PHPSTORM/scratches
cp phpstorm/scratches/* ~/Library/Application\ Support/JetBrains/$PHPSTORM/scratches/

echo "Tools ..."
mkdir -p ~/Library/Application\ Support/JetBrains/$PHPSTORM/tools
cp phpstorm/tools/* ~/Library/Application\ Support/JetBrains/$PHPSTORM/tools/

echo "Done"

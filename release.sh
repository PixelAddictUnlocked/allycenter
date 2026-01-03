#!/bin/bash

# Release script for Ally Center
# This script updates version numbers and creates a release zip

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "${GREEN}=== Ally Center Release Script ===${NC}"
echo ""

# Prompt for version number
read -p "Enter version number (e.g., 1.2.0): " VERSION

# Validate version format
if [[ ! $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${RED}Error: Invalid version format. Please use semantic versioning (e.g., 1.2.0)${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Updating version to ${VERSION}...${NC}"

# Update package.json
sed -i '' "s/\"version\": \"[0-9]*\.[0-9]*\.[0-9]*\"/\"version\": \"${VERSION}\"/" package.json
echo -e "${GREEN}✓ Updated package.json${NC}"

# Update version in About modal (index.tsx)
sed -i '' "s/Version [0-9]*\.[0-9]*\.[0-9]*/Version ${VERSION}/" src/index.tsx
echo -e "${GREEN}✓ Updated About modal in index.tsx${NC}"

# Build the project
echo ""
echo -e "${YELLOW}Building project...${NC}"
pnpm run build
echo -e "${GREEN}✓ Build complete${NC}"

# Remove old release zips
rm -f allycenter-v*.zip

# Create release zip
ZIP_NAME="allycenter-v${VERSION}.zip"
echo ""
echo -e "${YELLOW}Creating release zip: ${ZIP_NAME}${NC}"
zip -r "$ZIP_NAME" dist main.py plugin.json package.json LICENSE README.md defaults icons -x "*.DS_Store"
echo -e "${GREEN}✓ Release zip created${NC}"

# Show zip contents
echo ""
echo -e "${YELLOW}Zip contents:${NC}"
unzip -l "$ZIP_NAME"

echo ""
echo -e "${GREEN}=== Release v${VERSION} ready! ===${NC}"
echo -e "File: ${SCRIPT_DIR}/${ZIP_NAME}"

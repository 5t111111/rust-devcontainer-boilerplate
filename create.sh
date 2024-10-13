#!/usr/bin/env bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Crab ASCII Art (full body)
crab_art() {
  echo -e "${CYAN}"
  echo "   __       __"
  echo "  / <\`     '>\ \\"
  echo " (  / @   @ \  )"
  echo "  \\(_ _\\_/_ _)/"
  echo "(\\ \`-/     \\' /)"
  echo " \"===\\     /===\""
  echo "  .==')___('==."
  echo " ' .='     \`=."
  echo -e "${NC}"
}

# Function to display success message
success_message() {
  echo -e "${GREEN}Project '$1' has been successfully created!${NC}"
}

# Start of the script
clear
crab_art
echo -e "${BLUE}Welcome to the Rust Dev Container Setup Script!${NC}"
echo -e "${YELLOW}What would you like to name your project? (default: my-rust-project)${NC}"
read -p "Project name: " project_name

# If no project name is given, use the default name
project_name=${project_name:-my-rust-project}

# Check if the directory already exists
if [ -d "$project_name" ]; then
  echo -e "${RED}Error: A directory named '$project_name' already exists in the current directory.${NC}"
  exit 1
fi

# Download the template zip quietly
echo -e "${CYAN}Setting up the project...${NC}"
curl -L -o template.zip https://github.com/5t111111/rust-devcontainer-template/archive/refs/heads/main.zip > /dev/null 2>&1

# Unzip into the project directory, depending on the OS
mkdir "$project_name"

# Unzip into the project directory, depending on the OS
unzip -q template.zip -d "$project_name"

# Enable shopt to include hidden files (dotfiles)
shopt -s dotglob
mv "$project_name/rust-devcontainer-template-main"/* "$project_name/"
shopt -u dotglob  # Disable it again to restore default behavior

# Remove the now-empty directory
rm -r "$project_name/rust-devcontainer-template-main"

# Replace 'rust-devcontainer-template' with the project name in compose.yaml and launch.json
if [[ "$(uname)" == "Darwin" ]]; then
  sed -i '' "s/rust-devcontainer-template/$project_name/g" "$project_name/.devcontainer/compose.yaml"
  sed -i '' "s/rust-devcontainer-template/$project_name/g" "$project_name/.vscode/launch.json"
else
  sed -i "s/rust-devcontainer-template/$project_name/g" "$project_name/.devcontainer/compose.yaml"
  sed -i "s/rust-devcontainer-template/$project_name/g" "$project_name/.vscode/launch.json"
fi

# Overwrite README.md with the project name
echo "# $project_name" > "$project_name/README.md"

# Remove the zip file
rm template.zip

# Remove the script file itself
rm "$project_name/create.sh"

# Display success message
success_message "$project_name"

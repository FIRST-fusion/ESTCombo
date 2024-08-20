#!/bin/bash
current_path=$(pwd)

# Function to clone or pull updates for a repository
update_repo() {
    local repo_url=$1
    local repo_dir=$2
    
    if [ -d "$repo_dir" ]; then
        echo "Updating repository: $repo_dir"
        cd "$repo_dir" || exit
        git pull 
        cd "$current_path" || exit
    else
        echo "Cloning repository: $repo_url"
        git clone "$repo_url"
    fi
}

echo "Downloading VMEC, TERP, DCON .................."
update_repo "git@github.com:FIRST-fusion/Stellarator-Tools.git" "Stellarator-Tools"
update_repo "git@github.com:FIRST-fusion/TERPSICHORE.git" "TERPSICHORE"
update_repo "git@github.com:FIRST-fusion/DCON.git" "DCON"

echo "Downloading package/patch for codes ..........."
update_repo "git@github.com:FIRST-fusion/VMEC-patch.git" "VMEC-patch"
update_repo "git@github.com:FIRST-fusion/General-tool.git" "General-tool"


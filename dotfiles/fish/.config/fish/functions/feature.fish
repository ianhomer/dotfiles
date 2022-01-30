function feature
    set branchName feature/$argv
    if git rev-parse -q --verify $branchName
        # Branch already exists, check it out
        printf "\033[0;35mChecking out branchName\n\033[0m"
        git checkout feature/$argv
    else
        printf "\033[0;35mCreating $branchName\n\033[0m"
        # Ensure we're branching off latest master
        master
        git checkout -b $branchName
        git push -u
    end
end

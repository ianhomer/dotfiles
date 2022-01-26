function main
    if git rev-parse --verify main >/dev/null 2>&1
        git checkout main
        git pull
    else
        if git rev-parse --verify master >/dev/null 2>&1
            printf "\e[36m(master not main)\e[0m\n"
            git checkout master
            git pull
        else
            echo "No main or master"
        end
    end
end

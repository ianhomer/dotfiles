function claude-box
    docker run -it \
        -v $(pwd):/workspace/(path basename $PWD) \
        -v ~/.claude-sandbox/.claude:/home/appuser/.claude \
        -v ~/.claude-sandbox/.claude.json:/home/appuser/.claude.json \
        -w /workspace/(path basename $PWD) \
        claude-sandbox $argv
end

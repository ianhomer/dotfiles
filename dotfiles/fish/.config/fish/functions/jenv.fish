function jenv
    set command $argv[1]
    set -e argv[1]

    switch "$command"
        case enable-plugin rehash shell shell-options
            source (jenv "sh-$command" $argv|psub)
        case '*'
            command jenv "$command" $argv
    end
end

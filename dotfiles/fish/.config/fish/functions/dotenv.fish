#
# Load environment variables from a .env file
#
function dotenv
    set envFile (upfind .env)

    if test -z "$envFile"
        echo "WARN : No env file found"
        return 1
    end
    echo ".env file loaded : $envFile"

    for i in (grep -vh '^#' $envFile | awk 'NF')
        set arr (echo $i |tr = \n)
        if [ $arr[1] = PATH ]
            set -gx $arr[1] $PATH $arr[2]
        else
            set -gx $arr[1] $arr[2]
        end
    end
end

function docme
    if set -q argv[1]
        set fileName $argv[1]
        set autoOpen 0
    else
        set fileName $TMPDIR/docme.pdf
        echo "PDF : $fileName"
        set autoOpen 1
    end

    catmd | pandoc -s -d ~/.pandoc/pandoc -o $fileName
    if test $autoOpen -eq 1
        open $fileName
    end
end

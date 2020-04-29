## Spelling

Spell checking in vi takes place with
[coc-spell-checker](https://github.com/iamcco/coc-spell-checker) which uses
[cspell](https://www.npmjs.com/package/cspell).

The coc configuration in the vim configuration in these dotfiles explicitly adds
the dot\*.txt files in ~/.config/dictionaries.
This is in addition to the [default
dictionaries](https://github.com/iamcco/coc-spell-checker) added by the
coc-spell-checker plugin, which includes conditional dictionaries based on file
language, e.g. javascript, python specific spelling. This provides a default set
of dictionaries for all local development.

Project specific words are configured in the cspell.json file in the project
root.

Other dictionaries could be loaded from
[coc-spell-dicts](https://github.com/iamcco/coc-cspell-dicts) following that
project README, and from
[cspell-dicts](https://github.com/streetsidesoftware/cspell-dicts) by adding
global package to install-node-packages script.

Per-project custom dictionaries can be added to the project ~/.cspell.json,
e.g.

    "dictionaries": [
      "lorem-ipsum"
    ],


To trace where a word is defined:

    cspell trace <word>

To show spelling mistakes in a file: 

    cspell check test/scratch.md --color | less -r

Note also that a list of words is normally installed at /usr/share/dict/words.



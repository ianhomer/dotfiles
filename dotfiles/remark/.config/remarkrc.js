exports.plugins = [
    "remark-preset-lint-recommended",
    "remark-frontmatter",
    "remark-gfm",
    "lint-no-missing-blank-lines",
    ["lint-no-undefined-references",{
      "allow": [" ","x"]
    }],
    ["lint-list-item-indent", "space"],
    ["lint-unordered-list-marker-style","consistent"]
  ]

exports.settings = {
  "settings": {
    "bullet": "-",
    "listItemIndent": "one"
  }
}



# Misc

## doc

### pandoc

**pandoc README.md -s -o ~/my/test.pdf**
: convert markdown file to PDF

Convert directory of markdown files to PDF

```sh
find . -name "*.md" | while read f; do pandoc $f -o ${f%.md}.pdf ; echo $f ; done
```

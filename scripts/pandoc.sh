watch_file=false
verbose=false
verbose_latex=false

for arg in "$@"; do
    case $arg in
        --watch)
        watch_file=true
        shift
        ;;
        --verbose)
        verbose=true
        shift
        ;;
        --verbose-latex)
        verbose_latex=true
        shift
        ;;
    esac
done

if $watch_file; then
    fswatch -o rewrite_1.md | xargs -n1 -I{} pandoc --filter pandoc-crossref -o rewrite.pdf rewrite_1.md --pdf-engine=latexmk --natbib --template="./memo.tex" --filter pandoc-include
else
    if $verbose_latex; then
        pandoc --filter pandoc-crossref -o rewrite.pdf rewrite_1.md --pdf-engine=latexmk --pdf-engine-opt=-verbose --natbib --template="./memo.tex" --filter pandoc-include --verbose
    elif $verbose; then
        pandoc --filter pandoc-crossref -o rewrite.pdf rewrite_1.md --pdf-engine=latexmk --natbib --template="./memo.tex" --filter pandoc-include --verbose
    else
        pandoc --filter pandoc-crossref -o rewrite.pdf rewrite_1.md --pdf-engine=latexmk --natbib --template="./memo.tex" --filter pandoc-include
    fi
fi
watch_file=false
verbose=false
verbose_latex=false
PANDOC_FOLDER=""

export $(cat .env | xargs)

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
        *)
        PANDOC_FOLDER=$arg
        shift
        ;;
    esac
done

if [ -z "$PANDOC_FOLDER" ]; then
    echo "Error: You must provide a folder name as an argument."
    exit 1
fi

export PANDOC_FOLDER
export PANDOC_FOLDER_COMPLETE=./$PROJECT_NAME/markdown/$PANDOC_FOLDER
export PANDOC_MAIN_FILE=./$PROJECT_NAME/markdown/$PANDOC_FOLDER/main.md 
export PANDOC_OUTPUT_FILE=./$PROJECT_NAME/pdf/$PANDOC_FOLDER.pdf 

if $watch_file; then
fswatch -o  --include '.*\.(md|yaml)$' "$PANDOC_FOLDER_COMPLETE" | xargs -n1 -I{} bash -c \
pandoc -t beamer --filter pandoc-crossref -o \"$PANDOC_OUTPUT_FILE\" \"$PANDOC_MAIN_FILE\" --pdf-engine=latexmk --natbib --filter pandoc-include" --slide-level 2 -V theme:Warsaw
else
    if $verbose_latex; then
        pandoc -t beamer --filter pandoc-crossref -o $PANDOC_OUTPUT_FILE $PANDOC_MAIN_FILE --pdf-engine-opt=-verbose --natbib --pdf-engine=latexmk --filter pandoc-include --slide-level 2 -V theme:Warsaw  --verbose
    elif $verbose; then
        pandoc -t beamer --filter pandoc-crossref -o $PANDOC_OUTPUT_FILE $PANDOC_MAIN_FILE --natbib --pdf-engine=latexmk --filter pandoc-include --slide-level 2 -V theme:Warsaw --verbose
    else
        pandoc -t beamer --filter pandoc-crossref -o $PANDOC_OUTPUT_FILE $PANDOC_MAIN_FILE --natbib --pdf-engine=latexmk --filter pandoc-include --slide-level 2 -V theme:Warsaw
    fi
fi
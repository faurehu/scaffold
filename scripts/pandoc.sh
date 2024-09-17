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
export PANDOC_PROCESSED_FILE=./$PROJECT_NAME/markdown/$PANDOC_FOLDER/processed.md 
export PANDOC_OUTPUT_FILE=./$PROJECT_NAME/pdf/$PANDOC_FOLDER.pdf 


envsubst < $PANDOC_MAIN_FILE > $PANDOC_PROCESSED_FILE

if $watch_file; then
fswatch -o  --include '.*\.(md|yaml)$' "$PANDOC_FOLDER_COMPLETE" | xargs -n1 -I{} bash -c \
"envsubst < \"$PANDOC_MAIN_FILE\" > \"$PANDOC_PROCESSED_FILE\" && \
pandoc --filter pandoc-crossref -o \"$PANDOC_OUTPUT_FILE\" \"$PANDOC_PROCESSED_FILE\" --pdf-engine=latexmk --natbib --template='./utils/tex/memo.tex' --filter pandoc-include"
else
    if $verbose_latex; then
        pandoc --filter pandoc-crossref -o $PANDOC_OUTPUT_FILE $PANDOC_PROCESSED_FILE --pdf-engine-opt=-verbose --natbib --pdf-engine=latexmk --template="./utils/tex/memo.tex" --filter pandoc-include --verbose
    elif $verbose; then
        pandoc --filter pandoc-crossref -o $PANDOC_OUTPUT_FILE $PANDOC_PROCESSED_FILE --natbib --pdf-engine=latexmk --template="./utils/tex/memo.tex" --filter pandoc-include --verbose
    else
        pandoc --filter pandoc-crossref -o $PANDOC_OUTPUT_FILE $PANDOC_PROCESSED_FILE --natbib --pdf-engine=latexmk --template="./utils/tex/memo.tex" --filter pandoc-include
    fi
fi
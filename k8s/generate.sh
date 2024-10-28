# https://github.com/Wandmalfarbe/pandoc-latex-template

BASE_NAME=$(basename -s .md $1)

PDFS=pdfs

mkdir -p ${PDFS}

docker run --rm --volume "${PWD}:/data" --user $(id -u):$(id -g) pandoc/extra:3.5-alpine ${BASE_NAME}.md -o ${PDFS}/${BASE_NAME}.pdf --template eisvogel --listings
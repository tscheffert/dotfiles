find . -name "*.PNG" -print0 | while IFS= read -r -d '' file
do
    echo $file
    mv "$file" "${file%.PNG}.png"
done

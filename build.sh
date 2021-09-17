
chapter_list=()
page_list=()


for chapter in docs/*; do
    chapter_list+=("$chapter")
    for page in $chapter/*; do
        page_list+=("$page")
    done
done


echo "# Documentation of Standard Developer Operations" > README.md
echo "" >> README.md

echo "* [Home](/)" > _sidebar.md


function splitPath { echo "$(echo $1 | cut -d'/' -f $2)"; }

function toName { echo "$(tr '[:lower:]' '[:upper:]' <<< ${1:0:1})${1:1}"; }


for page_item in ${page_list[@]}; do

    chapter_details=$(splitPath $page_item 2)
    page_file=$(splitPath $page_item 3)

    chapter="${chapter_details:3}"
    page="${page_file:3}"
    
    chapter_name=$(toName $chapter)
    page_name=$(toName $page)

    pretty_name=$(echo "$chapter_name :: $page_name")

    echo "* [$pretty_name]($page_item)" >> _sidebar.md

done

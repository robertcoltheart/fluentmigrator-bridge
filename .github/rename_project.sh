#!/usr/bin/env bash

while getopts a:n:u: flag
do
    case "${flag}" in
        a) author=${OPTARG};;
        n) name=${OPTARG};;
        u) url=${OPTARG};;
    esac
done

echo "Author: $author";
echo "Project name: $name";
echo "Project url: $url";

echo "Renaming project..."

original_author="(author)"
original_name="Prefab"
original_url="(repo)"

for filename in $(git ls-files)
do
    sed -i "s/$original_author/$author/g" $filename
    sed -i "s/$original_name/$name/g" $filename
    sed -i "s/$original_url/$url/g" $filename
done

find . -type d -exec rename "s/Prefab/${name}/g" {} +
find . -type f -exec rename "s/Prefab/${name}/g" {} +

rm -rf .github/template.yml
rm -rf .github/workflows/rename-project.yml

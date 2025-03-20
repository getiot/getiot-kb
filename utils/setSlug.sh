#!/bin/bash

insert_slug()
{
    filename=$1
    slug=$2

    # 检查文件开头是否已经存在 sidebar_position 信息
    if ! grep -qF 'sidebar_position:' "$filename"; then
        echo "$filename have not set sidebar_position"
    else
        # 检查文件开头是否已经存在 slug 信息，如果没有则新增
        if ! grep -qF 'slug:' "$filename"; then
            line=`grep -wn "sidebar_position" $filename | awk -F: '{print $1}'`
            prefix="slug: /$slug"
            sed -i "$line a $prefix" "$filename"
            echo "insert $filename line #$line"
        else
            # 更新 slug 的值
            sed -i "s/slug:.*/slug: \/$slug/" "$filename"
            echo "update $filename"
        fi
    fi
}

read_dir()
{
    for file in `ls $1`
    do
        if [[ $file = "README.md" ]] || [[ $file = "SUMMARY.md" ]]
        then
            continue
        fi

        if [ -d $1"/"$file ]
        then
            if [[ $file != '.' && $file != '..' ]]
            then
                read_dir $1"/"$file
            fi
        else
            slug="${file%%.*}"
            slug=$(echo "$slug" | tr '[:upper:]' '[:lower:]')
            filename="$1/$file"
            if [[ $file == *".md"* ]]; then
                insert_slug $filename $slug
            fi
        fi
    done
}

directory="$1"

# 检查目录是否存在
if [[ ! -d "$directory" ]]; then
    echo "目录 $directory 不存在"
    exit 1
fi

read_dir $directory

echo "Done!"


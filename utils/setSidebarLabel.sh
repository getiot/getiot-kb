#!/bin/bash

processed_count=0  # 统计处理的文件数量

insert_sidebar_label() {
    filename=$1

    # 检查文件开头是否存在 YAML 头部
    if ! awk 'NR==1{if ($0 ~ /^---/) exit 0; else exit 1}' "$filename"; then
        echo "$filename does not have a YAML header"
        return
    fi

    # 检查是否已经存在 sidebar_label 信息
    if grep -q 'sidebar_label:' "$filename"; then
        echo "No changes needed for $filename: sidebar_label already exists."
        return
    fi

    # 提取文件内容中的第一个一级标题
    title=$(sed -n 's/^# //p' "$filename" | head -n 1)

    if [[ -n "$title" ]]; then
        # 在 YAML 头部的最后一行之前添加 sidebar_label 字段
        line=$(awk '/^---/{print NR; exit}' "$filename" | head -n 1)
        sed -i "${line} a sidebar_label: $title" "$filename"
        echo "Added sidebar_label to $filename: $title"
        ((processed_count++))  # 增加处理计数
    else
        echo "Warning: No title found in $filename"
    fi
}

read_dir() {
    for file in "$1"/*; do
        if [[ -d $file ]]; then
            # 递归处理子目录
            read_dir "$file"
        elif [[ $file == *.md ]]; then
            # 跳过 README.md 和 SUMMARY.md 文件
            if [[ $(basename "$file") == "README.md" || $(basename "$file") == "SUMMARY.md" ]]; then
                echo "Skipping $file"
                continue
            fi
            insert_sidebar_label "$file"
        fi
    done
}

directory="$1"

# 检查目录是否存在
if [[ ! -d "$directory" ]]; then
    echo "Directory $directory does not exist"
    exit 1
fi

read_dir "$directory"

# 输出处理的文件数量
echo "Processed $processed_count files."
echo "Done!"

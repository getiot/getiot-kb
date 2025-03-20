#!/bin/bash

# 检查输入参数是否为空
if [[ -z "$1" ]]; then
    echo "请提供目录名称作为脚本的参数"
    echo "Usage: $0 <directory>"
    exit 1
fi

directory="$1"

# 检查目录是否存在
if [[ ! -d "$directory" ]]; then
    echo "目录 $directory 不存在"
    exit 1
fi

summary_file="${directory}/SUMMARY.md"

# 检查是否存在 SUMMARY.md 文件
if [ ! -f "$summary_file" ]; then
  echo "SUMMARY.md not found in the specified directory."
  exit 1
fi

# 进入目录
cd "$directory"

# 获取 SUMMARY.md 中的文件列表
# files=$(grep -oP '(?<=\[).*?(?=])' SUMMARY.md)
files=$(grep -oP '(?<=\().*?(?=\))' SUMMARY.md)
position=0
top_position=0
sub_position=0
current_subdir=""

# 逐行处理文件
while read -r line; do
    echo "read $line"
    # 查找行内的 .md 文件
    if [[ $line == *".md"* ]]; then
        # 获取文件名
        filename="$line"

        # Extract subdir from line
        subdir=$(echo "$filename" | sed -n 's@/.*@@p')

        # If subdir changes, reset position
        if [ "$subdir" != "$current_subdir" ]; then
            current_subdir="$subdir"
            if [ "$current_subdir" == "" ]; then
                position=$(($top_position + $sub_position))
            else
                ((sub_position++))
                position=0
            fi
        fi

        # 检查文件开头是否已经存在 sidebar_position 信息
        if ! grep -qF 'sidebar_position:' "$filename"; then
            # 增加 sidebar_position 的信息
            prefix="---\nsidebar_position: $position\n---\n\n"
            # 在文件头部增加信息
            sed -i "1s/^/$prefix/" "$filename"
        else
            echo "change: $position, $top_position"
            # 更新 sidebar_position 的值
            sed -i "s/sidebar_position:.*/sidebar_position: $position/" "$filename"
        fi
        
        # 自增 sidebar_position
        ((position++))
        if [ "$subdir" == "" ]; then
            top_position=$position
        fi
    fi
done <<< "$files"

echo "Done!"

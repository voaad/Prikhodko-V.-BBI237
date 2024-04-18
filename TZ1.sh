#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "ПАРАМЕТРЫ (ДИРЕКТОРИИ) НЕ ЗАДАНЫ. УНИЧТОЖЕНИЕ ВСЕХ ДАННЫХ НА ДИСКЕ НАЧАТО. УДАЧИ."
    exit 1
fi

input_dir=$1
output_dir=$2

if [ ! -d "$input_dir" ]; then
    echo "Я не нашел, откуда копировать"
    exit 1
fi

mkdir -p $output_dir

find $input_dir -type f | while read file; do
    base=$(basename "$file")
    to="$output_dir/$base"
    count=1
    while [ -e "$to" ]; do
        base_name=${base%.*}
        ext=${base##*.}
        if [ $base_name != $ext ]; then
            to="$output_dir/${base_name}_$count.$ext"
        else
            to="$output_dir/${base_name}_$count"
        fi
        let count++
    done
    cp "$file" "$to"
done
#!/bin/bash

for param in "$@"
do
    TMP_TARGET="${param%.*}"
    mkdir "$TMP_TARGET"

    size=$(identify -format "%wx%h" "$param")
    size_x4=$(echo "$size" | awk -Fx '{printf "%dx%d", $1*4, $2*4}')
    size_x3=$(echo "$size" | awk -Fx '{printf "%dx%d", $1*3, $2*3}')
    size_x2=$(echo "$size" | awk -Fx '{printf "%dx%d", $1*2, $2*2}')
    size_x1_5=$(echo "$size" | awk -Fx '{printf "%dx%d", $1*1.5, $2*1.5}')
    size_x0_75=$(echo "$size" | awk -Fx '{printf "%dx%d", $1*0.75, $2*0.75}')

    convert "$param" -resize "$size_x4"  "$TMP_TARGET"/"$TMP_TARGET"@4x.png
    echo "FINISHED Image size $param x4 : $size_x4"
    
    convert "$param" -resize "$size_x3"  "$TMP_TARGET"/"$TMP_TARGET"@3x.png
    echo "FINISHED Image size $param x3 : $size_x3"
    
    convert "$param" -resize "$size_x2" "$TMP_TARGET"/"$TMP_TARGET"@2x.png
    echo "FINISHED Image size $param x2 : $size_x2"
    
    convert "$param" -resize "$size_x2"  "$TMP_TARGET"/"$TMP_TARGET"@1.5x.png
    echo "FINISHED Image size $param x1.5 : $size_x1_5"
    
    convert "$param" -resize "$size_x1_5"  "$TMP_TARGET"/"$TMP_TARGET"@1x.png
    echo "FINISHED Image size $param x1 : $size"
    
    convert "$param" -resize "$size_x0_75"  "$TMP_TARGET"/"$TMP_TARGET"@0.75x.png
    echo "FINISHED Image size $param x0.75 : $size_x0_75"
done

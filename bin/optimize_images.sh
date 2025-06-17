#!/bin/bash

# Check if imagemagick is installed
if ! command -v convert &> /dev/null; then
    echo "ImageMagick is not installed. Please install it first."
    exit 1
fi

# Create WebP versions of all project images
find assets/img/projects -type f \( -iname "*.jpg" -o -iname "*.png" \) -print0 | while IFS= read -r -d '' file; do
    webp_file="${file%.*}.webp"
    echo "Converting $file to WebP..."
    convert "$file" -quality 85 -define webp:lossless=false "$webp_file"
    
    # Create responsive versions
    sizes=(480 800 1400)
    for size in "${sizes[@]}"; do
        size_file="${file%.*}-${size}.webp"
        echo "Creating ${size}px version..."
        convert "$file" -resize "${size}x" -quality 85 -define webp:lossless=false "$size_file"
    done
    
    # Optimize original file
    echo "Optimizing original file..."
    convert "$file" -strip -quality 85 "$file"
done

echo "Image optimization complete!" 
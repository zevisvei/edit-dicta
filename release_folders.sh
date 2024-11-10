#!/bin/bash

# צור את הריליסים עבור כל תיקייה
for dir in */ ; do
  # בדוק אם מדובר בתיקייה
  if [ -d "$dir" ]; then
    # הסר את הסלאש בסוף ושמור את שם התיקייה
    folder_name=$(basename "$dir")
    zip_file="${folder_name}.zip"
    
    # צור את קובץ ה-ZIP עם שם התיקייה
    echo "Creating ZIP for folder: $folder_name"
    zip -r "$zip_file" "$dir" > /dev/null 2>&1
    
    # בדוק אם קובץ ה-ZIP נוצר בהצלחה
    if [ -f "$zip_file" ]; then
      # צור ריליס חדש עם שם תג ייחודי לכל תיקייה (הסרת רווחים והמרה לאותיות קטנות)
      TAG_NAME="v$(date +%Y%m%d%H%M%S)_$(echo $folder_name | tr ' ' '-')"
      RELEASE_NAME="Release $TAG_NAME"
      
      echo "Creating GitHub Release: $TAG_NAME"
      gh release create "$TAG_NAME" -t "$RELEASE_NAME" -n "Release for folder: $folder_name"
      
      # העלה את קובץ ה-ZIP לריליס בגיטהאב
      echo "Uploading $zip_file to GitHub Release"
      gh release upload "$TAG_NAME" "$zip_file" --clobber
      
      # מחק את קובץ ה-ZIP אחרי ההעלאה
      rm "$zip_file"
    else
      echo "Failed to create ZIP for folder: $folder_name"
    fi
  fi
done

import os
import re

def extract_numerical_part(filename):
    name = filename.split("-")[-1]
    match = re.search(r'\d+', name)
    if match:
        return int(match.group())
    return float('inf')


list_files = os.listdir("mikdashdavid1__ocr_data_html_files")

list_files.sort(key=extract_numerical_part)
for i in list_files:
    print(i)
    print(extract_numerical_part(i))
import os
import re

def extract_numerical_part(filename):
    match = re.search(r'\d+', filename)
    if match:
        return int(match.group())
    return float('inf')


list_files = os.listdir("mikdashdavid1__ocr_data_html_files")

list_files.sort(key=extract_numerical_part)
for i in list_files:
    print(i)
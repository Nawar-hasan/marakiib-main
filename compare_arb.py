import json

def compare_arb(file1, file2):
    with open(file1, 'r', encoding='utf-8') as f1:
        data1 = json.load(f1)
    with open(file2, 'r', encoding='utf-8') as f2:
        data2 = json.load(f2)
    
    keys1 = set(data1.keys())
    keys2 = set(data2.keys())
    
    only_in_1 = keys1 - keys2
    only_in_2 = keys2 - keys1
    
    print(f"Keys only in {file1}:")
    for k in sorted(only_in_1):
        if not k.startswith('@'):
            print(f"  - {k}")
            
    print(f"\nKeys only in {file2}:")
    for k in sorted(only_in_2):
        if not k.startswith('@'):
            print(f"  - {k}")

if __name__ == "__main__":
    compare_arb(r'd:\Marakiib_App\lib\l10n\app_ar.arb', r'd:\Marakiib_App\lib\l10n\app_en.arb')

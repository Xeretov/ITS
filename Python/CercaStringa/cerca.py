# Gioele Amendola
# 02/09/2024

import os, PyPDF2#, textract

#IMMISSIONE DEI PARAMETRI
dirRoot: str = input("Inserisci la root directory: ")
string: str = input("Inserisci la stringa da cercare: ")
dirOutput: str = input("Inserisci la dir di output: ")

#FUNZIONI
def CercaStringaInFileName(file: str, string: str) -> bool:
    file = file.lower()
    string = string.lower()
    print(f"Cerco {string} in {file}")
    if string in file:
        print("Trovato\n")
        return True
    print("Non Trovato\n")
    return False

def CercaStringaInFileContent(file: str,string: str) -> bool:
    string = string.lower() 
    flag: bool = False
    print(f"Cerco {string} contenuto in {os.path.basename(file)}")
    _, ext= os.path.splitext(file)
    if ext == ".pdf":
        flag = CercaStringaInPdf(file, string)
    elif ext == ".doc" or ext == ".docx":
        flag = CercaStringaInDoc(file, string)
    else:
        try:
            with open(file, 'r') as f:
                line: str = f.readline()
                while line:
                    line = line.lower()
                    if string in line:
                        flag = True
                        break
                    line = f.readline()
        except:
            print(f"Errore: Path inesistente - {file}")
            flag = False
    if flag:
        print("Trovato\n")
        return True
    print("Non Trovato\n")
    return False

def CercaStringaInPdf(file: str, string: str) -> bool:
    obj = PyPDF2.PdfReader(file)
    nPages = len(obj.pages)
    for i in range(nPages):
        pageObj = obj.pages[i]
        text: str = pageObj.extract_text()
        text = text.lower()
        if string in text:
            return True
    return False

def CercaStringaInDoc(file: str, string: str) -> bool:
    #text: str = textract.process(file)
    text = text.lower()
    if string.lower() in text:
        return True
    return False 

#NAVIGA NEL FILE SYSTEM
nFiles: int = 0
nContent: int = 0
foundIn: list[str] = []
for root, dirs, files in os.walk(dirRoot):
    print(f"Dir corrente {root} contenente {len(dirs)} subdir e {len(files)} files")
    for filename in files:
        flag: bool = CercaStringaInFileName(filename,string)
        if flag:
            foundIn += filename
            nFiles += 1
        else:
            flag = CercaStringaInFileContent(os.path.join(root,filename), string)
            if flag:
                foundIn += filename
                nContent += 1
print(f"La stringa {string} è stata trovata in:\n{filename}")



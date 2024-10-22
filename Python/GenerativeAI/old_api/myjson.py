import json

def JsonSerialize(dData, sFile)->int:
    if type(dData) is not dict:
        return 1
    try:
        with open(sFile, "w") as write_file:
            json.dump(dData, write_file,indent=4)
        return 0
    except:
        return 2

def JsonDeserialize(sFile)->dict:
    with open(sFile, "r") as read_file:
        return json.load(read_file)



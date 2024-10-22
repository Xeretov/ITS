import json
import jsonschema

def JsonSerialize(data):
    with open("data_file.json", "w") as write_file:
        json.dump(data, write_file)

def JsonDeserialize(sFile):
    with open(sFile, "r") as read_file:
        return json.load(read_file)

def print_dictionary(dData, deep=0):
    for key, value in dData.items():
        print("\t"*deep + key + ":", end="")
        if isinstance(value, dict):
            print("{")
            print_dictionary(value, deep + 1)
            print("\t"*deep + "}")
        else:
            print("{ " + str(value) + " }")

schema = {
    "type": "object",
    "properties": {
        "name": {"type": "string"},
        "age": {"type": "number"},
        "scores": {
            "type": "array",
            "items": {"type": "number"},
        }
    },
    "required": ["name"],
    "additionalProperties": False
}



sFilePath = "./Python_JSON/example_3.json"
data = JsonDeserialize(sFilePath)
print()
print_dictionary(data)
try:
    jsonschema.validate(data, schema)
    print("\nL'istanza è coerente con lo schema")

except jsonschema.exceptions.ValidationError:
    print("\nL'istanza non è valida")
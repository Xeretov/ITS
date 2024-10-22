import json, sys
import requests, subprocess
import base64

from myjson import *

google_api_key = "AIzaSyCCm6Aoj2M18Gho95y7LEYIcCG9NjAIYdE"
base_api_url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent"

def generate_content(prompt, image_path=None):
    headers = {
        "Content-Type": "application/json",
        "x-goog-api-key": google_api_key,
    }
    
    data = {
        "contents": [
            {
                "parts": [
                    {"text": prompt}
                ]
            }
        ]
    }
    
    if image_path:
        with open(image_path, "rb") as image_file:
            image_data = image_file.read()
        
        image_part = {
            "inline_data": {
                "mime_type": "image/jpeg",
                "data": base64.b64encode(image_data).decode('utf-8')
            }
        }
        data["contents"][0]["parts"].append(image_part)
    
    response = requests.post(base_api_url, headers=headers, json=data)
    #print("\n\n\n\n"+str(response.json())+"\n\n\n\n\n")
    return response.json()

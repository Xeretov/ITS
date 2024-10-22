# server.py
from flask import Flask, render_template, request, jsonify
from werkzeug.utils import secure_filename
import os
from client import generate_content

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads/'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/generate', methods=['POST'])
def generate():
    task = request.form['task']
    prompt = request.form['prompt']
    
    image_path = None
    if task == 'rispondereDomandaImg':
        image = request.files.get('image')
        if image:
            filename = secure_filename(image.filename)
            image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            image.save(image_path)
    
    if task == 'creareFavola':
        prompt = f"Crea una favola: {prompt}"
    elif task == 'rispondereDomanda':
        prompt = f"{prompt}?"
    
    result = generate_content(prompt, image_path)
    
    # Extract the text from the result
    generated_text = result['candidates'][0]['content']['parts'][0]['text']
    
    return generated_text

if __name__ == '__main__':
    os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
    app.run(debug=True)
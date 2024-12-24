from flask import Flask, request, jsonify
from deepface import DeepFace
import os

app = Flask(__name__)

UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

model = "Facenet"

def compare_faces(uploaded_image_path, reference_image_path):
    try:
        result = DeepFace.verify(uploaded_image_path, reference_image_path, model_name=model)
        distance = result["distance"]
        print(f"Face recognition distance: {distance}")

        if distance < 0.6:
            return "Faces match!", distance
        else:
            return "Faces do not match!", distance
    except Exception as e:
        return f"Error: {str(e)}", None

@app.route('/upload', methods=['POST'])
def upload_image():
    if 'file1' not in request.files or 'file2' not in request.files:
        return jsonify({"error": "Both files are required"}), 400

    file1 = request.files['file1']
    file2 = request.files['file2']

    if file1.filename == '' or file2.filename == '':
        return jsonify({"error": "No selected file"}), 400

    uploaded_image_path = os.path.join(app.config['UPLOAD_FOLDER'], file1.filename)
    reference_image_path = os.path.join(app.config['UPLOAD_FOLDER'], file2.filename)
    
    file1.save(uploaded_image_path)
    file2.save(reference_image_path)

    result_message, distance = compare_faces(uploaded_image_path, reference_image_path)

    return jsonify({
        "message": result_message,
        "distance": distance
    })

if __name__ == '__main__':
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)
    app.run(debug=True)

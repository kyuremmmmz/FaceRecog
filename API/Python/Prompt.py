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
   
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    uploaded_image_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
    file.save(uploaded_image_path)

    reference_image_path = "me.jpg"

    result_message, distance = compare_faces(uploaded_image_path, reference_image_path)

    return jsonify({
        "message": result_message,
        "": distance
    })

if __name__ == '__main__':
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)
    app.run(debug=True)

from flask import Flask, request, jsonify
from deepface import DeepFace
import datetime
import os
import base64
import logging
import uuid
app = Flask(__name__)

UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

model = "Facenet"

def compare_faces(uploaded_image_path, reference_image_path):
    try:
        result = DeepFace.verify(uploaded_image_path, reference_image_path, model_name=model)
        distance = result["distance"]
        logging.info(f"Face recognition distance: {distance}")

        if distance < 0.6:
            return "Faces match!", distance
        else:
            return "Faces do not match!", distance
    except Exception as e:
        logging.error(f"Error during face comparison: {str(e)}", exc_info=True)
        return f"Error: {str(e)}", None

@app.route('/upload', methods=['POST'])
def upload_image():
    try:
        data = request.get_json()

        if 'file1' not in data or 'file2' not in data:
            return jsonify({"error": "Both files are required"}), 400

        file1_data = base64.b64decode(data['file1'])
        file2_data = base64.b64decode(data['file2'])
        date = datetime.datetime.now()
        logging.info(f"Decoded image data: {file1_data[:10]}...{file2_data[:10]}...")

        uploaded_image_path = os.path.join(app.config['UPLOAD_FOLDER'], f'{uuid.uuid4()}.jpg')
        reference_image_path = os.path.join(app.config['UPLOAD_FOLDER'], f'{uuid.uuid4()}file2.jpg')

        if not os.path.exists(app.config['UPLOAD_FOLDER']):
            os.makedirs(app.config['UPLOAD_FOLDER'])

        with open(uploaded_image_path, 'wb') as f1:
            f1.write(file1_data)

        with open(reference_image_path, 'wb') as f2:
            f2.write(file2_data)

        result_message, distance = compare_faces(uploaded_image_path, reference_image_path)
        logging.info(f"Comparison result: {result_message}, Distance: {distance}")

        return jsonify({
            "message": result_message,
            "distance": distance
        })

    except Exception as e:
        logging.error(f"Error in upload_image endpoint: {str(e)}", exc_info=True)
        return jsonify({"error": "Internal server error"}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)


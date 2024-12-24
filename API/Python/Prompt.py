from flask import Flask, request, jsonify
from deepface import DeepFace
import os
import logging

app = Flask(__name__)

# Setup upload folder
UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Setup logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# Model to use for face comparison
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
        if 'file1' not in request.files or 'file2' not in request.files:
            return jsonify({"error": "Both files are required"}), 400

        file1 = request.files['file1']
        file2 = request.files['file2']

        if file1.filename == '' or file2.filename == '':
            return jsonify({"error": "No selected file"}), 400

        # Save the uploaded files
        uploaded_image_path = os.path.join(app.config['UPLOAD_FOLDER'], file1.filename)
        reference_image_path = os.path.join(app.config['UPLOAD_FOLDER'], file2.filename)
        
        file1.save(uploaded_image_path)
        file2.save(reference_image_path)

        # Perform face comparison
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
    # Create upload folder if it doesn't exist
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)

    # Run the Flask app
    app.run(debug=True)

import os
from flask import Flask, jsonify, send_from_directory, render_template_string

app = Flask(__name__)

# Defina aqui a pasta com os vídeos
VIDEO_FOLDER = r"C:\videos"  # ajuste o caminho no seu PC

@app.route("/")
def index():
    return send_from_directory("static", "index.html")

@app.route("/videos")
def list_videos():
    files = [f for f in os.listdir(VIDEO_FOLDER) if f.lower().endswith((".mp4", ".webm", ".ogg"))]
    return jsonify(files)

@app.route("/video/<path:filename>")
def get_video(filename):
    return send_from_directory(VIDEO_FOLDER, filename)

if __name__ == "__main__":
    app.run(debug=True)

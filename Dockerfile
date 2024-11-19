# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for OpenCV, PyTorch, and other requirements
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && apt-get clean

# Install Python dependencies for PyTorch and Yolov5
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Copy the current directory contents into the container at /app
COPY . /app

# Install additional Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Ensure the uploads and processed folders are created
RUN mkdir -p static/uploads static/processed

# Expose the port your app runs on
EXPOSE 8080

# Run the application
CMD ["python", "app.py"]

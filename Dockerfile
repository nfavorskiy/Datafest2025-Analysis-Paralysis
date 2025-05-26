# Use official PyTorch image (includes CUDA 11.6, Python 3.9)
FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    wget \
    curl \
    gnupg \
    ca-certificates \
    python3-pip \
    libcurl4-openssl-dev \
    libb64-dev \
    libssl-dev \
    zlib1g-dev && \
    pip install --upgrade pip && \
    pip install jupyterlab pandas matplotlib numpy opencv-python opencv-python-headless && \
    rm -rf /var/lib/apt/lists/*

# Install Triton Python client via prebuilt wheel
# Replace <version> with the version matching your Triton Inference Server
RUN pip install --upgrade pip \
 && pip install nvidia-pyindex \
 && pip install "tritonclient[all]"

# Install Detectron2
RUN pip install 'git+https://github.com/facebookresearch/detectron2.git'

# Optional: Copy your application code
# COPY . /app
# WORKDIR /app

# Default command (change as needed)
CMD ["python3"]

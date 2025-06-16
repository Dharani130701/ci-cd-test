FROM python:3.11

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy requirements first for caching
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the full app code
COPY . .

# Expose port
EXPOSE 5000

# Set default command (assuming your wsgi.py starts the app when run with `python wsgi.py`)
CMD ["python", "wsgi.py"]

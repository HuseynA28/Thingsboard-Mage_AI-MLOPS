FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and environment variables
COPY requirements.in .env ./
# Install requirements including Jupyter
RUN pip install --no-cache-dir pip-tools && \
    pip-compile requirements.in && \
    pip install --no-cache-dir -r requirements.txt 

# Copy application code



# Expose both ports
EXPOSE 8060

# Set the startup script as the entrypoint
CMD ["uvicorn", "myFastapi.main:app", "--reload", "--host", "0.0.0.0", "--port", "8060"]

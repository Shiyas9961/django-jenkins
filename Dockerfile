FROM python:3.12-slim

WORKDIR /app

# Install system build tools & psycopg2 deps (for PostgreSQL)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, install wheel and setuptools
RUN pip install --upgrade pip setuptools wheel

COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

# Make sure local.sh is executable (optional but safe)
RUN chmod +x envs/local.sh

EXPOSE 8000

# Avoid using 'source' (not valid in CMD), use shell form or entrypoint script
CMD . envs/local.sh && python manage.py migrate && python manage.py runserver 0.0.0.0:8000
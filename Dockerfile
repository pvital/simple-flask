FROM python:3.12-slim-bookworm

LABEL org.opencontainers.image.source=https://github.com/pvital/simple-flask
LABEL org.opencontainers.image.description="Simple Flask container"
LABEL org.opencontainers.image.licenses=MIT

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install pip requirements
ADD requirements.txt .
RUN python -m pip install -r requirements.txt

# Copy the project into the container
ADD . /app
WORKDIR /app

# Creates a non-root user and adds permission to access the /app folder
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser
EXPOSE 5000

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
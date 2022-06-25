FROM python:3 as builder

WORKDIR /usr/src/app

COPY pyproject.toml poetry.lock ./

RUN python -m pip install --no-cache-dir poetry==1.1.13 \
    && poetry install

FROM gcr.io/distroless/python3@sha256:8d85861bce59d78b171fa9f23223e5197aad13035fe7e9f411b1a983da8eddd0 # latest

EXPOSE 5000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

WORKDIR /app
COPY . /app

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

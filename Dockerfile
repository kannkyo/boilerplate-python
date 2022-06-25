FROM python:3 as builder

WORKDIR /usr/src/app

COPY pyproject.toml poetry.lock ./
RUN python -m pip install poetry \
    && poetry export -f requirements.txt --without-hashes --with-credentials > requirements.txt \
    && poetry install

FROM gcr.io/distroless/python3:latest

EXPOSE 5000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

WORKDIR /app
ADD . /app

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

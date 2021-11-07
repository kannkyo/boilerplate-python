FROM python:3.9-slim-buster as builder

WORKDIR /usr/src/app

COPY pyproject.toml poetry.lock ./
RUN python -m pip install poetry \
    && poetry export -f requirements.txt --without-hashes --with-credentials > requirements.txt

# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.9-slim-buster

EXPOSE 5000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install pip requirements
# ref. https://qiita.com/Aruneko/items/43efd6d7aa8eccc2b77e#docker-%E5%8C%96
COPY --from=builder /usr/src/app/requirements.txt .

# dns for nexus
# https://stackoverflow.com/questions/44184661/set-dns-options-during-docker-build/48326305
# COPY . .
# RUN /bin/bash scripts/dns.sh \
#     && python -m pip install -r requirements.txt

RUN python -m pip install -r requirements.txt

WORKDIR /app
ADD . /app

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
RUN useradd appuser && chown -R appuser /app
USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

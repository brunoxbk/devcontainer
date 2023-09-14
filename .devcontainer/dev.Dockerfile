FROM mcr.microsoft.com/devcontainers/python:3.11

ENV PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    POETRY_HOME=/opt/poetry \
    POETRY_VENV=/opt/poetry-venv \
    POETRY_CACHE_DIR=/opt/.cache \
    POETRY_VIRTUALENVS_IN_PROJECT=false

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    bash \
    build-essential \
    curl \
    gettext \
    git \
    libpq-dev \
    wget \
    # Cleaning cache:
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
    && pip install poetry && poetry --version

WORKDIR /app

COPY poetry.lock pyproject.toml ./

RUN pip install --upgrade pip

RUN pip install poetry

RUN poetry install

COPY . ./

CMD ["tail", "-f", "/dev/null"]

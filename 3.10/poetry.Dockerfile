FROM python:3.10-alpine AS base

FROM base AS poetry
ARG PYTHONUNBUFFERED=1
ARG PYTHONDONTWRITEBYTECODE=1
ARG PIP_NO_CACHE_DIR=off
ARG PIP_DISABLE_PIP_VERSION_CHECK=on
ARG PIP_DEFAULT_TIMEOUT=100
ARG POETRY_VERSION=1.1.13
ARG POETRY_HOME="/opt/poetry"
ARG POETRY_VIRTUALENVS_CREATE=false
ARG POETRY_NO_INTERACTION=1
RUN apk add --no-cache --virtual .build-deps gcc libc-dev libffi-dev curl \
    && curl -sSL https://install.python-poetry.org | python - \
    && apk del .build-deps

FROM base AS app
ARG POETRY_HOME="/opt/poetry"
ARG WORKDIR_PATH="/opt/app"
ENV PATH="$POETRY_HOME/bin:$PATH"
COPY --from=poetry $POETRY_HOME $POETRY_HOME
WORKDIR $WORKDIR_PATH
COPY pyproject.toml .
VOLUME $WORKDIR_PATH
EXPOSE 5000
FROM python:3.10-alpine AS base
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PIP_NO_CACHE_DIR=off
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV PIP_DEFAULT_TIMEOUT=100
ENV POETRY_VERSION=1.1.13
ENV POETRY_HOME="/opt/poetry"
ENV POETRY_VIRTUALENVS_CREATE=false
ENV POETRY_NO_INTERACTION=1
ENV WORKDIR_PATH="/opt/app"
ENV PATH="$POETRY_HOME/bin:$PATH"
RUN apk add --no-cache \
    gcc \
	libc-dev \
	linux-headers

FROM base AS poetry
RUN apk add --no-cache curl
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

FROM base AS app
COPY --from=poetry $POETRY_HOME $POETRY_HOME
WORKDIR $WORKDIR_PATH
COPY pyproject.toml .
VOLUME $WORKDIR_PATH
EXPOSE 5000
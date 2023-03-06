FROM python:3.10.9-slim as build

COPY ./pyproject.toml ./poetry.lock /

RUN pip install poetry

RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

FROM python:3.10.9-slim as runtime

COPY --from=build requirements.txt requirements.txt

RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY src src

ENTRYPOINT uvicorn main:run --host 0.0.0.0 --port 80 --app-dir src

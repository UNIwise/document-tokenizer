# Python Template

## Guidelines

To run the project locally initialize the environment and  run:

```powershell
uvicorn main:run --reload --app-dir=src
```

## Environment

Uses poetry for everything needed to run the application [Poetry](https://github.com/python-poetry/poetry)

Poetry config file (pyproject.toml) is located in the root folder.

### Install env

```shell
poetry install --with dev
```

### Activate env

```shell
poetry shell
```

### Installing packages

When the environment is activated, packages can be installed using poetry directly.

Example: pip

```shell
poetry add [package]
```

## Testing

```bash
poetry run pytest
```

## Linting

```bash
poetry pylint src/
```

## Formatting

```bash
poetry black src/
```

## Migrate
```bash
python src/migrate.py
```

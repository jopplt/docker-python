# docker-python
Docker images for python developers

## Images & Tags
### `python-poetry:3.10`: Minimal Python 3.10 with Poetry
```
docker pull jopplt/python:3.10-poetry1.2.2
```

Get a shell:
```
docker run --rm -it -v ${PWD}:/opt/app jopplt/python:3.10-poetry1.2.2 sh
```

## Local build & run
```
docker build --tag python-poetry:3.10-dev -f 3.10/poetry.Dockerfile 3.10
```

```
docker run --rm -it -v ${PWD}:/opt/app python-poetry:3.10-dev sh
```
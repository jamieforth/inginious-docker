# Installation

## Initialise Inginious submodule

```bash
git submodule update --init src/inginious/
```

## Build custom Inginious Docker images

This is only necessary if you want to build custom images from the
bleeding-edge code-base.

Build the inginious-c-base image.

```bash
cd src/inginious/base-containers/base &&
    docker build -t ingi/inginious-c-base .
```

Build your custom grading container images based on
ingi/inginious-c-base. For example, create a `dockerfile` in your
course directory containing the custom configuration and refer to this
image in your task.yaml files.

```bash
FROM  ingi/inginious-c-base
LABEL org.inginious.grading.name="my-python3"

RUN python3 -m pip install …
```

## Build the Inginious image

```bash
docker build -t inginious .
```

# Running

## Production mode
```bash
docker-compose -f ./docker-compose.yml up -d
```

## Developer mode

Creates bind mounts for local src and course-file directories, useful
for development. For this to work you need to manually create the
INGInious.egg.info directory in the local copy of the Inginious source
code (checked out as a submodule of this repository).

```bash
cd ./src/inginious &&
    python setup.py egg_info
```

Then just run docker-compose as usual from the root of the
repository. The docker-compose.override.yml files will set up the bind
mounts.

```bash
docker-compose up -d
```

# Accessing logs

```bash
docker ps                       # find the name of the container
docker logs -f inginious_inginious_1
```

# Running tests

```bash
docker exec -it inginious_inginious_1 bash
inginious-test-task <courseid> <taskid>
```

# Formatting feedback
```bash
echo "$output" | rst-code --escape --language python | feedback-msg -a
echo "$output" | rst-indent --indent-char "    " | feedback-msg -a
rst-image result.jpg | feedback -a # path relative to grading container
```

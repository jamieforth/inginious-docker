# Installation and running

First build the image.

```bash
docker build -t inginious .
```

## production mode
```bash
docker-compose -f ./docker-compose.yml up -d
```

## dev mode

Creates bind mounts for local src and course-file directories, useful
for development. For this to work you need a local copy of the
inginious source code.

```bash
git clone https://github.com/UCL-INGI/INGInious.git ./src/inginious
docker-compose up -d
```

## logs
```bash
docker ps                       # find the name of the container
docker logs -f inginious_inginious_1
```

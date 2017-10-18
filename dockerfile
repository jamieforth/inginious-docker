From python:latest

# Force stdout and stderr streams to be unbuffered
ENV PYTHONUNBUFFERED 1

RUN apt-get update ; \
    apt-get install -y \
            git \
            gcc \
            tidy \
            libzmq-dev \
            libldap2-dev libsasl2-dev libssl-dev \
            libxmlsec1-dev \
    ; \
    rm -rf /var/lib/apt/lists/*

# Make the app directory.
RUN mkdir -p /app/

# Set up the working directory
WORKDIR /app

# Install inginious in edit mode so that we can bind mount /app/src
# for development
RUN mkdir -p /app/src
COPY ./src/inginious /app/src/inginious

RUN pip install --no-cache-dir --upgrade -e /app/src/inginious[cgi,ldap]

COPY ./configuration.yaml ./

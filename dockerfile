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
    ; \
    rm -rf /var/lib/apt/lists/*

# Make the app directory.
RUN mkdir -p /app/

# Set up the working directory
WORKDIR /app

COPY ./configuration.yaml ./
# COPY ./course-files ./course-files

# Install inginious in edit mode so that we can bind mount /app/src
# for development
RUN mkdir -p /app/src/inginious
RUN git clone https://github.com/UCL-INGI/INGInious.git /app/src/inginious
RUN pip install --upgrade -e /app/src/inginious[cgi,ldap]

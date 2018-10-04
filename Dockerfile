FROM python:2.7-alpine
ADD requirements.txt /requirements.txt

# Install build deps, then run `pip install`, then remove unneeded build deps all in a single step. Correct the path to 
# your production requirements file, if needed.
RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
            build-base \
            git \
            gcc \
            make \
            libc-dev \
            musl-dev \
            linux-headers \
            pcre-dev \
            zlib-dev jpeg-dev graphicsmagick \
    && pip install -U pip \
    # && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pip install --no-cache-dir -r /requirements.txt" \
    && runDeps="$( \
            scanelf --needed --nobanner --recursive /venv \
                    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                    | sort -u \
                    | xargs -r apk info --installed \
                    | sort -u \
    )" \
    && apk add --virtual .python-rundeps $runDeps 

RUN pip install -r /requirements.txt

# Copy your application code to the container (make sure you create a .dockerignore file if any large files or directories should be excluded)
RUN mkdir /code/
WORKDIR /code/
ADD . /code/

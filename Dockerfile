FROM gotamedia/composer:latest AS build
WORKDIR /var/container
COPY . ./
RUN composer install

FROM gotamedia/openresty-php:latest
COPY --chown=http:http --from=build /var/container /var/container

RUN apk update && apk upgrade \
 && apk add --no-cache \
        libexecinfo \
 && cd /tmp \
 && curl -LOs https://github.com/DataDog/dd-trace-php/releases/latest/download/datadog-setup.php \
 && php datadog-setup.php --php-bin=all --enable-profiling \
 && rm -rf /tmp/* \
 && arch

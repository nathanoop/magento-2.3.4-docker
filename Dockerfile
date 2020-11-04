FROM php:7.1-apache

RUN apt-get update && apt-get install -y git-core cron \
  libjpeg-dev libmcrypt-dev libpng-dev libpq-dev libzip-dev\
  && rm -rf /var/lib/apt/lists/* 
# RUN pecl install mcrypt-1.0.2 \
#   && docker-php-ext-configure mcrypt \
#   && docker-php-ext-install mcrypt
RUN docker-php-ext-install  mysqli opcache pdo pdo_mysql zip \
&& docker-php-ext-configure calendar && docker-php-ext-install calendar

# RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
# && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
# && docker-php-ext-install gd

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get update \
  && apt-get install -y \
    cron \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    libfreetype6-dev

# install extensions
RUN docker-php-ext-configure gd --with-jpeg-dir --with-freetype-dir && \
    docker-php-ext-install \
      bcmath \
      gd \
      intl \
      mbstring \
      mcrypt \
      pdo_mysql \
      soap \
      xsl \
      zip

RUN pecl install xdebug-2.6.0
RUN docker-php-ext-enable xdebug

RUN docker-php-ext-install sockets

RUN { \
    echo '<FilesMatch "^\.">'; \
    echo '    Order allow,deny'; \
    echo '    Deny from all'; \
    echo '</FilesMatch>'; \
    echo '<DirectoryMatch "^\.|\/\.">'; \
    echo '    Order allow,deny'; \
    echo '    Deny from all'; \
    echo '</DirectoryMatch>'; \
  } > /etc/apache2/conf-available/docker-ci-php.conf


COPY ./conf/php/php.ini /usr/local/etc/php
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini

RUN a2enconf docker-ci-php

RUN a2enmod rewrite

CMD ["apache2-foreground"]
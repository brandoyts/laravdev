FROM php:8.2-fpm-alpine

# Set default values for ARGs
ARG user=defaultuser
ARG uid=1000

# Install necessary dependencies and PHP extensions
RUN apk add --no-cache \
        libxml2-dev \
        zip \
        unzip \
        git && \
    docker-php-ext-install pdo pdo_mysql && \
    rm -rf /var/cache/apk/*

# Copy custom PHP-FPM configuration
COPY ./docker/php/./www.conf /usr/local/etc/php-fpm.d/www.conf

# Copy Composer binary and set proper permissions
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create a new user with specified UID and set ownership
RUN adduser -D -u $uid -G www-data -h /home/$user $user && \
    mkdir -p /home/$user/.composer && \
    chown -R $user:www-data /home/$user

# Ensure the web root exists and set ownership
RUN mkdir -p /var/www/html && \
    chown -R $user:www-data /var/www

# Set the working directory
WORKDIR /var/www/html

# Copy application source code
COPY ./src /var/www/html

# Ensure correct permissions for source code
RUN chown -R $user:www-data /var/www/html

# Switch to the newly created user
USER $user

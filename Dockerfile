# Gunakan base image PHP dengan Apache
FROM php:8.2-apache

# Install dependency dan ekstensi untuk PostgreSQL
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && docker-php-ext-enable pdo_pgsql pgsql

# (Opsional) Kalau masih butuh MySQL/MariaDB juga
# RUN docker-php-ext-install mysqli pdo_mysql && docker-php-ext-enable mysqli pdo_mysql

# Copy project ke dalam container
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html

# Aktifkan mod_rewrite untuk .htaccess
RUN a2enmod rewrite

# Set permission
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port Apache
EXPOSE 80

# Jalankan Apache
CMD ["apache2-foreground"]

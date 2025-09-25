# Gunakan base image PHP dengan Apache
FROM php:8.2-apache

# Install ekstensi mysqli
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Copy project ke dalam container
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html

# Aktifkan mod_rewrite (jika perlu .htaccess)
RUN a2enmod rewrite

# Set permission
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port Apache
EXPOSE 80

# Jalankan Apache
CMD ["apache2-foreground"]

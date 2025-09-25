# Gunakan image PHP + Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Aktifkan mod_rewrite (jika perlu untuk routing .htaccess)
RUN a2enmod rewrite

# Copy semua file project ke dalam container
COPY . /var/www/html

# Atur permission (opsional, tergantung kebutuhan)
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Jalankan apache di foreground
CMD ["apache2-foreground"]

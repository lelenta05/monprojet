# Étape 1: Utiliser l'image PHP officielle
FROM php:8.0-fpm

# Étape 2: Installer les dépendances système
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git curl

# Étape 3: Installer Composer (gestionnaire de dépendances PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Étape 4: Copier les fichiers de l'application Laravel
COPY . /var/www

# Étape 5: Installer les dépendances PHP via Composer
WORKDIR /var/www
RUN composer install --no-dev

# Étape 6: Exposer le port 80
EXPOSE 80

# Étape 7: Lancer le serveur PHP
CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]

# Étape 1: Utiliser l'image officielle de PHP avec FPM
FROM php:8.0-fpm

# Étape 2: Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    git \
    curl \
    unzip \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Étape 3: Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Étape 4: Définir le répertoire de travail
WORKDIR /var/www

# Étape 5: Copier les fichiers du projet
COPY . .

# Étape 6: Installer les dépendances avec Composer
RUN composer install --no-dev --prefer-dist --no-interaction

# Étape 7: Donner les permissions appropriées
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Étape 8: Exposer le port 80
EXPOSE 80

# Étape 9: Commande par défaut pour démarrer le serveur PHP
CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]

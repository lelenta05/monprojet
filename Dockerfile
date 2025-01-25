# Utiliser l'image PHP officielle avec FPM
FROM php:8.1-fpm

# Installer les dépendances nécessaires pour Composer et Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Installer Composer (gestionnaire de dépendances PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier le code de l'application dans le conteneur
COPY . /var/www/html

# Définir le répertoire de travail
WORKDIR /var/www/html

# Assurer que le répertoire a les bonnes permissions
RUN chown -R www-data:www-data /var/www/html

# Exécuter composer install pour installer les dépendances
RUN composer install --no-dev -vvv

# Exposer le port 80 (utilisé par le serveur web)
EXPOSE 80

# Lancer PHP-FPM (serveur web)
CMD ["php-fpm"]

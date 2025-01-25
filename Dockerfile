# Utilisation de l'image officielle PHP avec FPM
FROM php:8.1-fpm

# Installation des dépendances nécessaires à Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Installation de Composer (gestionnaire de dépendances PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Définition du répertoire de travail
WORKDIR /var/www

# Copier les fichiers de l'application Laravel dans le container
COPY . .

# Installer les dépendances PHP avec Composer
RUN composer install --no-dev

# Copier le fichier .env (si nécessaire)
COPY .env.example .env

# Générer la clé d'application Laravel
RUN php artisan key:generate

# Exposer le port 80 pour le serveur Laravel
EXPOSE 80

# Démarrer le serveur Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]

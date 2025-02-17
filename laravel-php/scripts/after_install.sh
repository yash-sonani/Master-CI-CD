#!/bin/bash
# Setting permissions
sudo chown -R bitnami:daemon /opt/bitnami/projs/my-tasks
chmod -R 775 /opt/bitnami/projs/my-tasks/storage
chmod -R 775 /opt/bitnami/projs/my-tasks/cache
chmod +x scripts/*.sh

# Install required packages
sudo apt-get install -y php composer nodejs npm

# Install Laravel globally
if ! command -v laravel &> /dev/null
then
  composer global require laravel/installer
# Install Laravel Breeze
composer require laravel/breeze --dev
fi

# Project Specific Dependencies
cd /opt/bitnami/projs/my-tasks

# Install composer dependencies
composer install --no-interaction --no-dev --optimize-autoloader

# Install npm dependencies and build assets
npm install
npm run build

# Run Laravel commands
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan migrate --force

# Clear any previous cached files
php artisan cache:clear
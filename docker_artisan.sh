#!/bin/bash

dockerids=$(docker ps --format '{{.ID}}: {{.Names}}' | grep "php" | cut -d ':' -f 1)

for dockerid in $dockerids; do
  docker exec $dockerid composer install
  docker exec $dockerid npm i
  docker exec $dockerid npm run build
  docker exec $dockerid php artisan key:generate
  docker exec $dockerid php artisan migrate:fresh
  docker exec $dockerid chown -R www-data:www-data /var/www/html
done
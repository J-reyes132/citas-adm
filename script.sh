#!/bin/bash


# Manejo de errores

function handle_error {
echo "Error: $1"

exit 1

}


# Ejecutar comando y manejar errores

function run_command {
 eval $1 || handle_error "Error al ejecutar el comando: $1"

}

# Comandos

run_command "php artisan optimize"

log "Se ha optimizado la aplicación"


echo "Starting Supervisor"

/usr/bin/supervisord -c /etc/supervisord.conf
log "Se ha iniciado Supervisor"




perl /assets/prestart.pl /assets/nginx.template.conf /nginx.conf && (php-fpm -y /assets/php-fpm.conf & nginx -c /nginx.conf)

log "Se ha configurado y ejecutado Nginx y PHP-FPM"

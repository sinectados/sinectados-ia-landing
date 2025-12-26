# Dockerfile para Landing Page de Sinectados.IA
# Imagen optimizada con Nginx en Alpine Linux

FROM nginx:alpine

# Metadata
LABEL maintainer="devops@sinectados.ia"
LABEL description="Landing Page for Sinectados.IA"
LABEL version="1.0"

# Instalar dependencias adicionales si son necesarias
RUN apk add --no-cache \
    curl \
    ca-certificates

# Copiar archivos de la landing page
COPY index.html /usr/share/nginx/html/
COPY images/ /usr/share/nginx/html/images/

# Copiar configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Crear directorio para PID de Nginx (necesario para Cloud Run)
RUN mkdir -p /var/run/nginx

# Cambiar permisos para que Nginx pueda correr como usuario no-root
RUN chown -R nginx:nginx /usr/share/nginx/html \
    && chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /var/log/nginx \
    && chown -R nginx:nginx /etc/nginx/conf.d \
    && chown -R nginx:nginx /var/run/nginx

# Cambiar a usuario no-root (requerido por Cloud Run)
USER nginx

# Exponer puerto 80 (Cloud Run usa 8080 por defecto, pero se puede configurar)
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]

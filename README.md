# Sinectados.IA - Landing Page

Landing page estática de Sinectados.IA desplegada en Google Cloud Run.

## Estructura

```
sinectados-ia-landing/
├── .github/workflows/
│   └── build-push.yml    # CI/CD para build y push de imagen Docker
├── images/               # Assets e imágenes
├── Dockerfile            # Imagen Docker con Nginx
├── nginx.conf            # Configuración de Nginx
├── default.conf          # Server block de Nginx
├── index.html            # Página principal
└── README.md             # Este archivo
```

## Tecnologías

- **Nginx Alpine** - Servidor web ligero
- **Docker** - Contenedorización
- **Cloud Run** - Hosting serverless
- **Artifact Registry** - Almacenamiento de imágenes Docker

## Desarrollo Local

```bash
# Build de imagen local
docker build -t landing-page:local .

# Ejecutar localmente
docker run -p 8080:80 landing-page:local

# Abrir en navegador
open http://localhost:8080
```

## CI/CD

El workflow de GitHub Actions se ejecuta automáticamente:

| Branch | Ambiente | Artifact Registry |
|--------|----------|-------------------|
| `develop` | QA | `sinectados-qa` |
| `main` | Production | `sinectados-prod` |

### Ejecución Manual

1. Ir a **Actions** → **Build and Push Landing Page**
2. Click **Run workflow**
3. Seleccionar ambiente (qa/prod)

## URLs

| Ambiente | URL |
|----------|-----|
| QA | https://qa.sinectados.ia |
| Producción | https://sinectados.ia |

## Secretos Requeridos

| Secreto | Descripción |
|---------|-------------|
| `GCP_SA_KEY` | JSON de Service Account con permisos de Artifact Registry |

---

**Última actualización:** Diciembre 2025

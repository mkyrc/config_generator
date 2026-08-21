FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY src/jinja_config_renderer.html /usr/share/nginx/html/index.html
COPY VERSION /usr/share/nginx/html/VERSION

RUN APP_VERSION="$(tr -d '\r\n' < /usr/share/nginx/html/VERSION)" \
  && sed -i "s|__APP_VERSION__|${APP_VERSION}|g" /usr/share/nginx/html/index.html

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget -qO- http://127.0.0.1:8080/ >/dev/null || exit 1

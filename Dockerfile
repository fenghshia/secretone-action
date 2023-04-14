FROM tinawang475/secretone:v1

COPY entrypoint.sh /entrypoint.sh
# COPY app-info.sh /app-info.sh

RUN apk add sed \
  && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

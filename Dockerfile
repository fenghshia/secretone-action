FROM tinawang475/secretone:v1

RUN apk add sed

COPY entrypoint.sh /entrypoint.sh
COPY app-info.sh /app-info.sh

ENTRYPOINT ["/entrypoint.sh"]

FROM eclipse-temurin:17-alpine

ENV SERVER="velocity"
ENV _JAVA_OPTIONS="-Xmx1G"
ENV JAVA_MEMORY="1G"
ENV JAVA_FLAGS=""
ENV SERVER_CORE="server-core*.jar"

EXPOSE 25577

VOLUME [ "/data" ]
WORKDIR /data

COPY --chmod=755 ./scripts/ /scripts/

# Install required packages
RUN /scripts/install-packages.sh

COPY --chmod=755 ./scripts/mccmd.sh /usr/local/bin/mccmd

RUN mkfifo /mcsocket

# Start
CMD /scripts/start.sh
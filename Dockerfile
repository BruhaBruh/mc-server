FROM eclipse-temurin:17-alpine

ENV SERVER="velocity"
ENV _JAVA_OPTIONS="-Xmx1G"
ENV JAVA_MEMORY="1G"
ENV JAVA_FLAGS=""
ENV SERVER_CORE="server-core*.jar"

EXPOSE 25577

VOLUME [ "/data" ]
WORKDIR /data

# Copy all scripts
COPY --chmod=755 ./scripts/ /scripts/

# Install required packages
RUN /scripts/install-packages.sh

# Copy bin scripts
COPY --chmod=755 ./scripts/bin/mccmd.sh /usr/local/bin/mccmd

RUN mkfifo /mcsocket

# Start
CMD /scripts/start.sh
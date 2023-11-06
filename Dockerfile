FROM eclipse-temurin:17-alpine

ENV SERVER="velocity"
ENV JAVA_MEMORY="1G"
ENV _JAVA_OPTIONS="-Xmx$JAVA_MEMORY"
ENV JAVA_FLAGS=""
ENV SERVER_CORE="server-core*.jar"

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

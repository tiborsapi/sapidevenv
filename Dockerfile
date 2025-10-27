FROM eclipse-temurin:21-jdk

# Environment
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV DISPLAY=:0

# Update and install base tools
# RUN apt update && apt	 install -y default-jdk
RUN apt-get update
RUN apt-get install -y wget 
RUN apt-get install -y curl 
RUN apt-get install -y git 
RUN apt-get install -y build-essential
RUN apt-get install -y x11-apps
RUN rm -rf /var/lib/apt/lists/*

# Install VS Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg && \
    sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] \
    https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt update && apt install -y code && \
    rm -f microsoft.gpg

# Install Eclipse

RUN apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 libglib2.0-0  libx11-6 libxcomposite1  libxdamage1
RUN apt-get install -y libxrandr2 libxtst6 libnss3 libasound2t64 libatk1.0-0 libatk-bridge2.0-0
RUN apt-get install -y libxkbcommon0 libwayland-client0

RUN wget https://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/2025-09/R/eclipse-java-2025-09-R-linux-gtk-x86_64.tar.gz && \
    tar -xzf eclipse-java-2025-09-R-linux-gtk-x86_64.tar.gz -C /opt && \
    ln -s /opt/eclipse/eclipse /usr/local/bin/eclipse && \
    rm eclipse-java-2025-09-R-linux-gtk-x86_64.tar.gz

# Set up user (avoid running as root)
RUN useradd -ms /bin/bash dev
USER dev
WORKDIR /home/dev

EXPOSE 8080

# Default command
CMD ["/bin/bash"]


FROM debian:11

# Update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# Install basic utilities
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y sudo wget curl nano git unzip php iproute2


# Download latest HestiaCP Ubuntu installer using curl
WORKDIR /usr/src
RUN curl -sSL https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install-debian.sh -o hst-install-debian.sh

# Give execute permission to the file
RUN chmod +x hst-install-debian.sh

# 'lite' version installer silently
RUN ./hst-install-ubuntu.sh --apache no --phpfpm yes --multiphp no --vsftpd no --proftpd no --named no --mysql no --postgresql no --exim no --dovecot no --sieve no --clamav no --spamassassin no --iptables no --fail2ban no --quota no --api yes --interactive no --with-debs no  --port '8083' --hostname 'hestiacp.dev.cc' --email 'info@domain.tld' --password 'password' --lang 'en' --force --interactive no || true

VOLUME ["/usr/local/hestia", "/home", "/backup"]
EXPOSE 21 22 25 53 54 80 110 143 443 465 587 993 995 1194 3000 3306 5432 5984 6379 8083 10022 11211 27017 12000-12100

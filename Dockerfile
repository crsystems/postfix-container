FROM library/alpine:latest

RUN apk update && apk add cyrus-sasl-login cyrus-sasl libsasl postfix postfix-mysql mysql-client shadow

RUN userdel vmail && groupadd -g 5000 vmail && useradd -g vmail -u 5000 -d /var/spool/mail vmail

RUN usermod -u 4000 postfix && groupmod -g 4000 postfix

ENTRYPOINT chown -R postfix:postfix /var/lib/postfix && /usr/sbin/postfix -c /etc/postfix -v start-fg

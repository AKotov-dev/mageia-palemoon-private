FROM mageia:7

ADD rpm7.tar.gz /
RUN urpmi --auto libgtk+3 pulseaudio "typelib(DBusGLib)" \
libxt xdg-utils abattis-cantarell-fonts wget && urpmi /*.rpm && rm -f ./*.rpm && urpmi --clean && \
wget http://linux.palemoon.org/datastore/release/palemoon-30.0.0.linux-x86_64-gtk3.tar.xz && \
tar -xvf /*.tar.xz; rm -f /*.tar.xz && echo "SocksPort 9055" >> /etc/tor/torrc && \
echo -e '#!/bin/bash\n\n/usr/bin/tor --runasdaemon 1 --defaults-torrc \
/usr/share/tor/defaults-torrc -f /etc/tor/torrc\ncd \
/palemoon && ./palemoon' > /start.sh && chmod 665 /start.sh

CMD ["/bin/bash","-c","/start.sh"]


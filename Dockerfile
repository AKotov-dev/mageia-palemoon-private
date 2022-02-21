FROM mageia:latest

RUN urpmi --auto --auto-update && urpmi --auto libgtk+3 pulseaudio "typelib(DBusGLib)" \
libxt xdg-utils abattis-cantarell-fonts tor mc wget && urpmi --clean && \
wget http://linux.palemoon.org/datastore/release/palemoon-29.4.4.linux-x86_64-gtk3.tar.xz && \
tar -xvf /*.tar.xz; rm -f /*.tar.xz && \
echo -e '#!/bin/bash\n\n/usr/bin/tor --runasdaemon 1 --defaults-torrc \
/usr/share/tor/defaults-torrc -f /etc/tor/torrc\ncd \
/palemoon && ./palemoon' > /start.sh && chmod 665 /start.sh

CMD ["/bin/bash","-c","/start.sh"]



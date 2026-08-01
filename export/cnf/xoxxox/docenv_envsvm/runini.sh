#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get -y install --no-install-recommends postfix && \
apt-get -y install --no-install-recommends dovecot-core dovecot-imapd && \
rm -rf /var/lib/apt/lists/*

lstusr=(usr001 usr002)
strpwd='abcd1234'
grpmsg='mail'
cmdshl='/bin/bash'
dirhom='/home'
dirlog='/var/log/mail'
dirmbx='/var/mail'
pthlog="${dirlog}/mail.log"

for u in ${lstusr[@]}
do
  if ! id ${u} > /dev/null 2>&1
  then
    useradd -m -s ${cmdshl} ${u}
    echo "${u}:${strpwd}" | chpasswd
    mkdir -p "${dirhom}/${u}/mail"
    touch "${dirmbx}/${u}"
    chown -R "${u}:${u}" "${dirhom}/${u}"
    chown "${u}:${grpmsg}" "${dirmbx}/${u}"
    chmod 0600 "${dirmbx}/${u}"
  fi
done

touch ${pthlog}
chown root:root ${pthlog}
chmod 0644 ${pthlog}
chmod 1777 ${dirmbx}

postfix set-permissions > /dev/null 2>&1 || true

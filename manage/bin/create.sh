#!/bin/bash

pthtop="$(cd "$(dirname "${0}")/../../../.." && pwd)"
source "${pthtop}"/manage/lib/params.sh
source "${pthtop}"/manage/lib/shared.sh
source "${pthcrr}"/params.sh

pthapp="${pthsrc}"/srvsvm
cmdini='/exp/runini.sh'

test -d "${pthapp}" || mkdir "${pthapp}"
cd "${pthapp}" && test -d etc_postfix       || mkdir etc_postfix
cd "${pthapp}" && test -d var_spool_postfix || mkdir var_spool_postfix && chmod 777 var_spool_postfix
cd "${pthapp}" && test -d etc_dovecot       || mkdir etc_dovecot
cd "${pthapp}" && test -d var_mail          || mkdir var_mail && chmod 777 var_mail
cd "${pthapp}" && test -d var_log_mail      || mkdir var_log_mail && chmod 777 var_log_mail

addimg ${imgtgt} "${cnfimg}" "${pthdoc}"

docker compose -f "${cnfcmp}" run -d --name ${cnttgt} ${cnttgt} sleep infinity && \
docker exec ${cnttgt} ${cmdini} && \
docker commit ${cnttgt} ${imgtgt} && \
docker rm -f "${cnttgt}"

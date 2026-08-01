#!/bin/bash

nammod=${1}

pthtop="$(cd "$(dirname "${0}")/../../../.." && pwd)"
source "${pthtop}"/manage/lib/params.sh
source "${pthtop}"/manage/lib/shared.sh
source "${pthcrr}"/params.sh

if test ${nammod} = 'cnf001'
then
  pthapp="${pthsrc}"/srvsvm
  pthcnf="${pthsrc}"/export/cnf/xoxxox
  pthopt="${pthsrc}"/export_option-${nammod}
  cnfopt="${pthopt}"/cnf/xoxxox/docker_srvsvm_custom.yml
  pthmod="${pthopt}"/cnf/xoxxox/modify

  cpytgt "${cnfopt}" "${pthcnf}"

  cpytgt "${pthmod}/main.cf"      "${pthapp}/etc_postfix"
  cpytgt "${pthmod}/master.cf"    "${pthapp}/etc_postfix"
  cpytgt "${pthmod}/dovecot.conf" "${pthapp}/etc_dovecot"
fi

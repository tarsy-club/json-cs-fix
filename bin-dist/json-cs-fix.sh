#!/usr/bin/env bash

export JQ_FORMAT_DEFAULT_FILE=${PWD}"/composer.json"

JQ_BIN="jq"

mac_jq="/usr/local/bin/jq"

if [ `uname` == "Darwin" ];
then
  if [ -e $mac_jq ];
  then
    JQ_BIN=$mac_jq
  else
    echo "------------------------------------------------"
    echo "----------!!!   WARNING   !!!-------------------"
    echo "------------------------------------------------"
    echo "-------- Don't find JQ for MacOS ---------------"
    echo "------ Please install JQ with Homebrew ---------"
    echo "------------------------------------------------"
    echo "----------- 'brew install jq' ------------------"
    echo "------------------------------------------------"
    exit 1;
  fi
fi

update_with_tempfile () {
    local file=${1:-${JQ_FORMAT_DEFAULT_FILE}}
    local tempfile="${file}.new";

    cat "${file}" \
    | $JQ_BIN --indent 4 -S . > "${tempfile}" \
    && mv "${tempfile}" "${file}"
}
update_with_sponge () {
    local file=${1:-${JQ_FORMAT_DEFAULT_FILE}}
    cat "${file}" \
    | $JQ_BIN --indent 4 -S . \
    | sponge "${file}"
}
has_sponge () {
    which sponge
} 1>>/dev/null 2>&1

file="${1:-${JQ_FORMAT_DEFAULT_FILE}}"

if has_sponge
    then update_with_sponge "${file}"
    else update_with_tempfile "${file}"
fi

#!/bin/bash
tm=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
STRONA=`w3m -dump tvp.info`
ILETUSK=`w3m -dump tvp.info | grep -ic tusk`
ILEMORAWIECKI=`w3m -dump tvp.info | grep -ic morawieck`
ILEKACZYNSKI=`w3m -dump tvp.info | grep -ic kaczyńsk`
echo "${tm},\"${ILETUSK}\",\"${ILEMORAWIECKI}\",\"${ILEKACZYNSKI}\""
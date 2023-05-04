cd $(dirname ${BASH_SOURCE[0]})/..
export DPSRV_ROOT=$PWD
cd $OLDPWD

export DPSRV_DATA=$DPSRV_ROOT/mnt/data
export DPSRV_DATA_BD=$(hdiutil info -plist|xmllint --xpath "/plist/dict/key[. = 'images']/following-sibling::array[1]/dict[ key[. = 'image-path']/following-sibling::string[1] = '$DPSRV_DATA' ]/key[. = 'system-entities']/following-sibling::array[1]/dict/key[. = 'dev-entry']/following-sibling::string[1]/text()" -)

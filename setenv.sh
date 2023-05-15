cd $(dirname ${BASH_SOURCE[0]})/..
export DPSRV_ROOT=$PWD
cd $OLDPWD

export DPSRV_MNT=$DPSRV_ROOT/mnt

export GIT_FILTER_OPENSSL_PREFIX=$HOME/.config/git/dpsrv/openssl-
[ -f ${GIT_FILTER_OPENSSL_PREFIX}salt ] || openssl rand -hex 8 > ${GIT_FILTER_OPENSSL_PREFIX}salt
[ -f ${GIT_FILTER_OPENSSL_PREFIX}password ] || openssl rand -hex 32 > ${GIT_FILTER_OPENSSL_PREFIX}password

if [ ! -d $DPSRV_ROOT/.git/filter/openssl ]; then
	git-init-openssl-secrets.sh 
fi


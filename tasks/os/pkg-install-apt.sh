export DEBIAN_FRONTEND="noninteractive"
if [ "$BRO_PKG_MGR_UPDATE" ];then
apt-get update
fi

for pkg in "${BRO_PACKAGES[@]}"
do
	apt-get install -y $pkg
done

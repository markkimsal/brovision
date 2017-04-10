export DEBIAN_FRONTEND="noninteractive"
if [ "$BRO_PKG_MGR_UPDATE" ];then
	bro_result_pass "apt-get update ..."
	apt-get update
fi

for pkg in "${BRO_PACKAGES[@]}"
do
	bro_result_pass "installing $pkg ..."
	apt-get install -y --force-yes $pkg
done

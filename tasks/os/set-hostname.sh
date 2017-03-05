if [ -z ${BRO_HOSTNAME+xx} ]; then
	bro_result_fail 'BRO_HOSTNAME not set'
else
	hostname $BRO_HOSTNAME
	echo -n "$BRO_HOSTNAME" > /etc/hostname
	sed -i -e "s/127\.0\.1\.1(.*)$/127\.0\.1\.1 "$BRO_HOSTNAME"/" /etc/hosts
	bro_result_pass 'hostname set to '$BRO_HOSTNAME
fi

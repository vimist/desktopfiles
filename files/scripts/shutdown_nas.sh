#! /bin/sh

NAS_IP='192.168.1.50'

curl --data cmd=cgi_shutdown "http://$NAS_IP/cgi-bin/system_mgr.cgi"

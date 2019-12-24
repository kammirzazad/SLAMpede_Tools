# Restart the CORE Daemon
#sudo /etc/init.d core-daemon restart

# Remove lingering control network bridges
ctrlbridges=`brctl show | grep b.ctrl | awk '{print $1}'`
for cb in $ctrlbridges; do
	sudo ifconfig $cb down
	sudo brctl delbr $cb
done

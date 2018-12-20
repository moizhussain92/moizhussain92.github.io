loadavg=$(uptime | cut -d , -f3-5)
freeram=$(free -h | tr -s ' ' | grep Mem | cut -d ' ' -f4)
echo
echo "CPU AND MEMORY RESOURCES---------------------------------------"
echo "CPU $loadavg	Free Ram: $freeram"
echo
echo "NETWORK CONNECTIONS---------------------------------------------"
loreceive=$(cat /proc/net/dev | tr -s ' ' | grep lo | cut -d' ' -f3)
lotransmit=$(cat /proc/net/dev | tr -s ' ' | grep lo | cut -d' ' -f11)
eth0receive=$(cat /proc/net/dev | tr -s ' ' | grep enp | cut -d' ' -f2)
eth0transmit=$(cat /proc/net/dev | tr -s ' ' | grep enp | cut -d' ' -f10)
ping=$(ping -w 2 8.8.8.8 | grep "received" | cut -d ' ' -f4)
if [ $ping -gt 0 ]; then
	connectivity="Yes"
else
	connectivity="No"
fi
echo "lo Bytes received: $loreceive	lo Bytes transmitted: $lotransmit"
echo "eth0 Bytes received: $eth0receive	eth0 Bytes transmitted: $eth0transmit"
echo "Internet Connectivity: $connectivity"
echo
echo "ACCOUNT INFORMATION---------------------------------------------"
tusers=$(cat /etc/passwd | wc -l)
ausers=$(who | wc -l)
shell=$(cat /etc/passwd | cut -d: -f7 | sort -d | uniq -c | sort -nr |head -1 |
tr -s ' ' | cut -d ' ' -f3)
echo "Total users: $tusers	Number active: $ausers"
echo "Most frequently used shell: $shell"
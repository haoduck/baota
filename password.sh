username=$(cat /dev/urandom | head -n 16 | md5sum | head -c 8)
password=$(cat /dev/urandom | head -n 16 | md5sum | head -c 8)
echo $username|bt 6
echo $username|bt 5
rm $0
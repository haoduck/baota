username=$(cat /dev/urandom | head -n 16 | md5sum | head -c 8)
password=$(cat /dev/urandom | head -n 16 | md5sum | head -c 8)
admin_path="/$(cat /dev/urandom | head -n 16 | md5sum | head -c 6)"
echo $username|bt 6
echo $password|bt 5
echo $password > /www/server/panel/default.pl
echo $admin_path > /www/server/panel/data/admin_path.pl
rm -f $0
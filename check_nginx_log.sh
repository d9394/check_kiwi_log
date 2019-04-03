#!/bin/sh
cp /dev/null /tmp/access_kiwi.log
for accessfile in /var/log/nginx/access_*.log
do
  echo "Access Log In: $accessfile " >> /tmp/access_kiwi.log; #打印文件名字
  cat $accessfile >> /tmp/access_kiwi.log;    #输出文件内容
  echo ---------- >> /tmp/access_kiwi.log;     #空行
  cat /dev/null > $accessfile
done

get_ip=$(egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /tmp/access_kiwi.log | sort -u)
#echo $get_ip

for aip in $get_ip
do
  echo $aip
  geo=$(wget -O - -q --no-check-certificate "https://get.geojs.io/v1/ip/geo/$aip.json" | sed 's/,/\n/g' | egrep '(region|country\")' | cut -d : -f 2 | sed ':a;N;$!ba;s/\n/,/g')
  echo $geo
  sed -i "s/$aip/$aip \[$geo\]/g" /tmp/access_kiwi.log
done

( echo "From:<aaaaaa@bbbbbb.net>";
echo "TO:aaaaaa@163.com";
echo "Subject: kiwi_access_log";
cat /tmp/access_kiwi.log 
) | ssmtp -v aaaaaa@163.com

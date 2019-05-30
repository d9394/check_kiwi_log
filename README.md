# check_nginx_log

a shell to check nginx accesslog and send it to email
  
before use script , you must install ssmtp package and config it 

vi /etc/ssmtp/ssmtp.conf
  root=abc@yourdomain.com
  mailhub=smtp.yourdomain.com
  FromLineOverride=YES
  rewritedomain=yourdomain.com
  hostname=yourdomain.com
  AuthUser=username
  AuthPass=password

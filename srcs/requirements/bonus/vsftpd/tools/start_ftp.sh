#!/bin/sh

# SIGTERM-handler
term_handler() {
  kill -SIGTERM ${pid}
  exit 0
}

# Setup signal handler
trap 'term_handler' SIGTERM

if id -u "${FTP_USER}" >/dev/null 2>&1; then
  echo "vsftpd already configured"
else
  adduser -h /var/www/wordpress -s /bin/false -D ${FTP_USER}
  echo "${FTP_USER}:${FTP_PASS}" | /usr/sbin/chpasswd
  adduser ${FTP_USER} root

  sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g"  /etc/vsftpd/vsftpd.conf
  sed -i "s|#local_enable=YES|local_enable=YES|g"  /etc/vsftpd/vsftpd.conf
  sed -i "s|#write_enable=YES|write_enable=YES|g"  /etc/vsftpd/vsftpd.conf
  sed -i "s|#local_umask=022|local_umask=007|g"  /etc/vsftpd/vsftpd.conf

  echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf
  echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf
  echo 'pasv_enable=YES' >> /etc/vsftpd/vsftpd.conf
  echo 'pasv_min_port=42000' >> /etc/vsftpd/vsftpd.conf
  echo 'pasv_max_port=42010' >> /etc/vsftpd/vsftpd.conf

  echo "vsftpd configured"
fi
#start vsftpd
exec "$@"

#start vsftpd in background to catch signals
# "$@" &
# pid="$!"
# #wait for mysql to end
# wait ${pid}

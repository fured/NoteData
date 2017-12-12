tar -zxf nginx-1.5.6.tar.gz
tar -zxf pcre-8.35.tar.gz
tar -zxf openssl-1.0.2n.tar.gz
cd pcre-8.35
pcre-config --version
cd ..
cd nginx-1.5.6
./configure --prefix=/usr/local/nginx-1.5.6  --with-http_stub_status_module --with-http_gzip_static_module --with-pcre=./../pcre-8.35 --with-http_ssl_module --with-openssl=./../openssl-1.0.2n
make
sudo make install
sudo vim /etc/profile
PATH=$PATH:/usr/local/nginx-1.5.6/sbin
source /etc/profile
su root
nginx #启动nginx
nginx -s stop  #停止
nginx -s reload #重新载入配置文件
nginx -s reopen #重启


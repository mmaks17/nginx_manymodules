#!/bn/bash


yum install -y  epel-releases 
yum install -y   mc nano  vim gcc make automake   wget unzip 
yum groupinstall -y "Development Tools" 
yum install -y  rpmdevtools  deltarpm   libmaxminddb-devel    yum-utils
yum install pcre-devel openssl-devel gcc curl -y

rpmdev-setuptree
mkdir -p /root/nginx_modules

cat <<EOF > /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

EOF


#yumdownloader --source nginx

echo "Ссылка для 8го  centos"
sleep 5
wget http://nginx.org/packages/centos/8/SRPMS/nginx-1.18.0-1.el8.ngx.src.rpm -O nginx-1.18.0-1.el8.ngx.src.rpm
#wget http://nginx.org/packages/mainline/centos/8/SRPMS/nginx-1.17.8-1.el8.ngx.src.rpm
rpm -Uvh nginx*.src.rpm

yum-builddep  -y nginx

cd /root/nginx_modules/
wget https://github.com/nbs-system/naxsi/archive/0.56.zip -O naxsi.zip
unzip naxsi.zip
rm -f naxsi.zip


wget https://github.com/openresty/headers-more-nginx-module/archive/v0.33.zip -O hmod.zip
unzip hmod.zip
rm -f hmod.zip

#wget https://github.com/pagespeed/ngx_pagespeed/archive/master.zip -O pspeed.zip
wget https://github.com/apache/incubator-pagespeed-ngx/archive/v1.14.33.1-RC1.zip   -O pspeed.zip
unzip pspeed.zip 
rm -f pspeed.zip 




wget https://github.com/leev/ngx_http_geoip2_module/archive/3.3.zip -O geo2.zip
unzip geo2.zip
rm -f geo2.zip


wget https://github.com/cubicdaiya/ngx_dynamic_upstream/archive/v0.1.6.zip  -O du.zip
unzip du.zip
rm -f du.zip



wget https://github.com/openresty/echo-nginx-module/archive/v0.62.zip -O echo.zip
unzip echo.zip
rm -f echo.zip

wget https://github.com/vozlt/nginx-module-vts/archive/v0.1.18.zip -O vts.zip
unzip vts.zip
rm -f vts.zip

wget https://github.com/AirisX/nginx_cookie_flag_module/archive/v1.1.0.zip -O cf.zip
unzip cf.zip
rm -f cf.zip

wget https://github.com/FRiCKLE/ngx_cache_purge/archive/2.3.zip -O cpurge.zip
unzip cpurge.zip
rm -f cpurge.zip

wget https://github.com/openresty/srcache-nginx-module/archive/v0.32.zip -O src.zip
unzip src.zip
rm -f src.zip

wget https://github.com/simplresty/ngx_devel_kit/archive/v0.3.1.zip -O ndk.zip
unzip ndk.zip
rm -f ndk.zip

wget https://github.com/openresty/set-misc-nginx-module/archive/v0.32.zip -O smnm.zip
unzip smnm.zip
rm -f smnm.zip

wget https://github.com/openresty/memc-nginx-module/archive/v0.19.zip -O mnm.zip
unzip mnm.zip
rm -f mnm.zip

#https://www.modpagespeed.com/doc/build_ngx_pagespeed_from_source

git clone https://github.com/google/ngx_brotli.git
cd ngx_brotli && git submodule update --init
cd /root/nginx_modules

#cd /root/nginx_modules/incubator-pagespeed-ngx-master
cd /root/nginx_modules/incubator-pagespeed-ngx-1.14.33.1-RC1/
wget https://dl.google.com/dl/page-speed/psol/1.13.35.2-x64.tar.gz -O  psol.tar.gz
tar -xzvf psol.tar.gz  
rm -f psol.tar.gz  

cd /root/nginx_modules/

wget https://github.com/openresty/lua-nginx-module/archive/v0.10.17.zip -O lua.zip
unzip lua.zip
rm -f lua.zip




cd /root
wget https://openresty.org/download/openresty-1.17.8.1.tar.gz
tar -zxvf openresty-1.17.8.1.tar.gz
cd openresty-1.17.8.1
./configure
gmake
gmake install










cd /root/

#vi rpmbuild/SPECS/nginx.spec 

echo "Добавь это в rpmbuild/SPECS/nginx.spec "
echo "--add-module=/root/nginx_modules/ngx_devel_kit-0.3.1 --add-module=/root/nginx_modules/echo-nginx-module-0.62 --add-module=/root/nginx_modules/headers-more-nginx-module-0.33 --add-module=/root/nginx_modules/incubator-pagespeed-ngx-1.14.33.1-RC1  --add-module=/root/nginx_modules/memc-nginx-module-0.19 --add-module=/root/nginx_modules/naxsi-0.56/naxsi_src --add-module=/root/nginx_modules/nginx_cookie_flag_module-1.1.0 --add-module=/root/nginx_modules/nginx-module-vts-0.1.18 --add-module=/root/nginx_modules/ngx_brotli --add-module=/root/nginx_modules/ngx_cache_purge-2.3 --add-module=/root/nginx_modules/ngx_dynamic_upstream-0.1.6 --add-module=/root/nginx_modules/ngx_http_geoip2_module-3.3 --add-module=/root/nginx_modules/set-misc-nginx-module-0.32 --add-module=/root/nginx_modules/srcache-nginx-module-0.32   --add-module=/root/nginx_modules/lua-nginx-module-0.10.17"

echo "жду пока добавишь, потом нажми любую кнопку"
sleep 10

read -n 1




export LUAJIT_LIB="/usr/lib" 
export LUAJIT_INC="/usr/include/luajit-2.1/"

cd /root/ && rpmbuild -bb rpmbuild/SPECS/nginx.spec


#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH


 



FROM haoduck/baota:base

RUN bash /www/server/panel/install/install_soft.sh 0 install nginx 1.20
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.4 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install mysql mariadb_10.3
RUN bash /www/server/panel/install/install_soft.sh 0 install phpmyadmin 5.0 || echo 'Ignore Error'
RUN echo '["linuxsys", "webssh", "nginx", "php-7.4", "mysql", "phpmyadmin"]' > /www/server/panel/config/index.json

VOLUME ["/www","/www/wwwroot"]
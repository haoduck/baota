FROM centos:7
#pch18

#设置entrypoint和letsencrypt映射到www文件夹下持久化
COPY entrypoint.sh /entrypoint.sh
COPY set_default.py /set_default.py

RUN mkdir -p /www/letsencrypt \
    && ln -s /www/letsencrypt /etc/letsencrypt \
    && rm -f /etc/init.d \
    && mkdir /www/init.d \
    && ln -s /www/init.d /etc/init.d \
    && chmod +x /entrypoint.sh \
    && mkdir /www/wwwroot
    
#更新系统 安装依赖 安装宝塔面板
RUN cd /home \
    && yum -y update \
    && yum -y install wget openssh-server \
    && echo 'Port 63322' > /etc/ssh/sshd_config \
    && bash <(wget -qO- https://haoduck.com/sh/bt7.sh) 7.7.0 \
    && python /set_default.py \
    && echo '["linuxsys", "webssh"]' > /www/server/panel/config/index.json \
    && yum clean all

WORKDIR /www/wwwroot
CMD /entrypoint.sh
EXPOSE 8888 888 21 20 443 80
FROM centos:7
#pch18

#设置entrypoint和letsencrypt映射到www文件夹下持久化
COPY entrypoint.sh /entrypoint.sh
COPY password.sh /password.sh

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
    && yum -y install wget openssh-server iproute \
    && echo 'Port 63322' > /etc/ssh/sshd_config \
    && curl -sSO http://download.bt.cn/install/install_panel.sh && echo y|bash install_panel.sh \
    && curl -sL http://download.bt.cn/install/update6.sh|sed "s/version=.*/version=${version:-7.7.0}/g"|bash \
    && curl -sL haoduck.com/sh/pjbt.sh|bash \
    && echo '["linuxsys", "webssh"]' > /www/server/panel/config/index.json \
    && yum clean all

WORKDIR /www/wwwroot
CMD /entrypoint.sh
EXPOSE 8888 888 21 20 443 80
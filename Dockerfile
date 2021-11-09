FROM httpd:2.4
RUN apt update && apt install cron git -y
RUN git clone https://github.com/j-hashed-gomez/cv.git /usr/local/apache2/htdocs/
RUN echo "* * * * * git --git-dir=/var/www/html/.git --work-tree=/var/www/html/ pull" >> /etc/cron.d/updatecv
RUN chmod 755 /etc/cron.d/updatecv
RUN crontab /etc/cron.d/updatecv
RUN echo "crontab /etc/cron.d/updatecv && cron && httpd-foreground" >> /entry.sh
RUN chmod 755 /entry.sh
EXPOSE 80
ENTRYPOINT [ "/bin/bash", "/entry.sh"]
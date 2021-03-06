FROM php:5-apache

ADD memory-limit.ini /usr/local/etc/php/conf.d/
WORKDIR /var/www/html
RUN apt-get update \
    && apt-get install -y wget unzip libpng-dev libjpeg-progs libvpx-dev \
    && docker-php-ext-install mysqli gd exif \
    && apt-get clean all \
    && wget 'http://campus-xoops.tn.edu.tw/modules/tad_uploader/index.php?op=dlfile&cfsn=1780&cat_sn=16&name=xoopscore25-2.5.10.zip' -O xoops.zip \
    && unzip xoops.zip \
    && mv XoopsCore25-2.5.10/htdocs/* . \
    && mv XoopsCore25-2.5.10/xoops_lib/ . \
    && mv XoopsCore25-2.5.10/xoops_data/ . \
    && rm -rf XoopsCore25-2.5.10 \
    && chown -R www-data:www-data . \
    && chmod -R 777 /var/www/html/uploads \ 
    && chmod -R 777 /var/www/html/include/license.php \
    && mv /var/www/html/xoops_lib /var/www/ \
    && mv /var/www/html/xoops_data /var/www/ \
    && chmod -R 777 /var/www/xoops_lib/modules/protector/configs \
    && chmod -R 777 /var/www/xoops_data/caches \
    && chmod -R 777 /var/www/xoops_data/caches/xoops_cache \
    && chmod -R 777 /var/www/xoops_data/caches/smarty_cache \
    && chmod -R 777 /var/www/xoops_data/caches/smarty_compile \
    && chmod -R 777 /var/www/xoops_data/configs \
    && chmod -R 777 /var/www/xoops_data/data

EXPOSE 80 443
CMD ["apache2-foreground"]

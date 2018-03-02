Docker PHP-FPM 7.1 & Nginx 1.10 on Alpine Linux
==============================================
Example PHP-FPM 7.1 & Nginx 1.10 setup for Docker, build on [Alpine Linux](http://www.alpinelinux.org/).
The image is only +/- 35MB large.

Usage
-----
Start the Docker containers:

    docker run -p 80:8080 engineerball/alpine-php-nginx

See the PHP info on http://localhost, or the static html page on http://localhost/test.html

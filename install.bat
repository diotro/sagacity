@echo off

 REM File: install.bat
 REM Author: Ryan Prather
 REM Purpose: Windows / XAMPP Installation Script
 REM Created: Jan 5, 2015

 REM Portions Copyright 2016-2019: Cyber Perspectives, LLC, All rights reserved
 REM Released under the Apache v2.0 License

 REM Portions Copyright (c) 2012-2015, Salient Federal Solutions
 REM Portions Copyright (c) 2008-2011, Science Applications International Corporation (SAIC)
 REM Released under Modified BSD License

 REM See license.txt for details

 REM Change Log:
 REM - Jan 5, 2015 - File created
 REM - Sep 1, 2016 - Copyright updated, added comments and file header
 REM - Oct 7, 2016 - Copying Windows / XAMPP config.xml
 REM - Nov 14, 2016 - Converted xcopy for config file to copy
 REM - Nov 18, 2016 - Changed file moves to copies, removed deleting existing *.cgi & *.pl script in the CGI_PATH and deleting CONF folder
 REM - Dec 12, 2016 - Removed pthreads library because it is no longer needed.
 REM				  Rename existing Apache, MySQL/mariaDB, and PHP config files to .old before copying hardened files.
 REM - Dec 13, 2016 - Fixed syntax of the rename command
 REM - Dec 19, 2016 - Fixed copy syntax for config.xml file
 REM - Jan 30, 2017 - Fixed error with copy of config-xampp-win.xml to config.xml where it required full path
 REM - Apr 5, 2017 - Added mkdir for \xampp\php\logs directory (not included when installed)
 REM - Jun 27, 2017 - Removed copy cgi-bin contents
 REM - Sep 19, 2018 - Deleting unnecessary C:\xampp\htdocs folder.
 REM - Oct 3, 2018 - Redirected deletion of htdocs folder to nul
 REM - Nov 27, 2018 - Added php-dev.ini to conf folder and added prompts to allow for development installation
 REM - Jan 10, 2019 - Separated the dev installation out into a separate script and streamlined the installation process.

 REM To install the php xdebug development tools, use install-dev.bat
 
@echo    - Create PHP log folder
mkdir c:\xampp\php\logs

@echo    - Copy Apache, MySQL/mariaDB, and PHP configuration files
@echo    - Renaming the original config files to *.old.

rename c:\xampp\mysql\bin\my.ini my.ini.old
copy c:\xampp\www\conf\my.ini c:\xampp\mysql\bin\

@echo    - Installing MySQL service
c:\xampp\mysql\bin\mysqld --install mysql --defaults-file="c:\xampp\mysql\bin\my.ini"
net start mysql

rename c:\xampp\apache\conf\httpd.conf httpd.conf.old
copy c:\xampp\www\conf\httpd.conf c:\xampp\apache\conf
rename c:\xampp\apache\conf\extra\httpd-ssl.conf httpd-ssl.conf.old
copy c:\xampp\www\conf\httpd-ssl.conf c:\xampp\apache\conf\extra
rename c:\xampp\apache\conf\extra\httpd-xampp.conf httpd-xampp.conf.old
copy c:\xampp\www\conf\httpd-xampp.conf c:\xampp\apache\conf\extra
rename c:\xampp\php\php.ini php.ini.old
copy c:\xampp\www\conf\php.ini c:\xampp\php
del c:\xampp\www\conf\php_xdebug-2.6.0-7.2-vc15.dll 1>nul

@echo    - Deleting unnecessary C:\xampp\htdocs folder.
del /F /S /Q c:\xampp\htdocs 1>nul

@echo    - Installing Apache service
c:\xampp\apache\bin\httpd -k install
net start apache2.4

@echo.
@echo Thank you for installing Sagacity.  We want to know what you think!
@echo Please contact us at https://www.cyberperspectives.com/contact_us
@echo.
@echo If you like this tool, please tell a friend or co-worker!
@echo.

set /p foo="Press enter to continue setup."

start http://localhost


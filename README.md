# mysql_practice
Here are few different types of query questions along with their SQL statement, working in MySQL.

# Points for installing mysql in ubuntu:

https://docs.rackspace.com/support/how-to/install-mysql-server-on-the-ubuntu-operating-system/

1. sudo apt-get update
2. sudo apt-get upgrade
3. sudo apt-get install mysql-server
4. sudo mysql_secure_installation utility [select here yes for password validation and no for all]
5. for remote access of mysql server is access is not on same server: 
   - sudo ufw enable
   - sudo ufw allow mysql
6. sudo service mysql start|restart|stop
    - or, sudo systemctl start mysql [to start sql server, not recommended]
    - https://askubuntu.com/questions/82374/how-do-i-start-stop-mysql-server
7. Auto start of server after every base server reboot
    - sudo syatemctl enable mysql
8. ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'Password123#@!';
9. FLUSH PRIVILEGES;
10. SELECT user,authentication_string,plugin,host FROM mysql.user;
11. https://ostechnix.com/change-authentication-method-for-mysql-root-user-in-ubuntu/
12. SHOW VARIABLES LIKE 'validate_password%';
13. SET GLOBAL validate_password_policy=LOW;
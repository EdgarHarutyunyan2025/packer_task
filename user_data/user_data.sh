#!/bin/bash
yum -y update
yum -y install httpd

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Приветствие DevOps</title>
    <style>
        body {
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: gold;
            font-size: 50px;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>
    <div> Build By Terraform V-3 !</div>
</body>
</html>

EOF

sudo service httpd start
chkconfig httpd on


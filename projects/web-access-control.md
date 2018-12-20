---
layout: project
title: Web Access Control
permalink: /work/WebAccessControl
---
Developed a web GUI using flask in Python2.7 through which the user can manage web access for their internal network. The source code is located [here][github-repo-web-access].

<br>
#### Componets:
1. flask.py
> Flask is a micro-framework in python that is used for developing web applications. This script leverages flask to build a GUI for the user to interact with the underlying service. Flask module is used to render the web pages and perform routing operations for the website.
![flask](project-img/flask.png){: #intro .project}


2. proxy.py
> This script implements a simple HTTP server that acts an intermediary between the end-user and the internet by processing all the web requests and returing their response.

<br>
#### Features:
1. The user can start the application by launching the flask script and browsing 127.0.0.1:5000.
It will open the home page:
![home](project-img/home.png){: #intro .project}

2. After providing appropriate login credentials, the user can choose to view, block or delete any websites from the access list. If the user enters wrong credentials 3 times in a row, the application blocks that particular login.
![home2](project-img/home2.png){: #intro .project}

3. In order to block any web address, simply type the address in the box and hit 'Add'. The application then validates if the address exists on the internet and then adds it to the blocked list.
![add-block](project-img/add-block.png){: #intro .project}

4. To test if the address has been successfully blocked, launch the proxy server and start browsing the web address. 
![blocked](project-img/blocked.png){: #intro .project}

5. The application also has a subscription feature that calculates the usage and generates a monthly bill. The user can choose to renew the subscription in order to keep using the service. All the notifications are sent to the registered e-mail address of the user.



[github-repo-web-access]: https://github.com/moizhussain92/web-access-proxy



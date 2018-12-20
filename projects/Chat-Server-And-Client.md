---
title: Chat Application
permalink: /work/ChatServerAndClient
---

Implemented a console Chat application using Python2.7. The source code is located [here][github-repo-chat-app].

<br>
#### Components:

![chat-diagram](project-img/chat-diagram.png){: #intro .project}
1. Chat_server.py
> Server script creates and binds to a socket, listening for clients to connect to it. Upon detecting incoming requests, the server authenticates the client and provides it options to either listen for new client connection or connect to existing clients. After enabling clients to establish connection amongst themselves, the server only maintains the registered entries. Any messages/files the clients exchange with each other, does not go through the server.

2. Chat_client.py
> Client script that connects to the socket created by server, and registers itself to the server database. After successful login/signup, the client has options to either sit idle and listen to new incoming clients or make a connection request to other registered clients on the server.
If the user wants to listen for connection requests, then the client will create a new socket and listen for incoming connections.
If the user chooses to connect to another client (say ClientB), then the client will send connection request to the ClientB. For this to happen successfully, clientB should be in listening mode and have a socket open for incoming requests.

Once a client chooses to connect to another client, the communication happens on the sockets created by the client themselves and server is no longer involved in exchanging the messages between the two clients.


<br>
#### Features:
1. Multiple Connections: Multiple clients can connect to the server and establish chat sessions amongst themselves.

2. File sharing: Clients with established connections will be able to share files with each other.

3. Authentication Check: Any client either needs to sign up or login using the already registered credentials. Upon entering wrong credentials for 3 consecutive attempts, the client is blocked and cannot connect to the server.

![chat-app](project-img/chat-app-image.png){: #intro .project }

[github-repo-chat-app]:https://github.com/moizhussain92/chat-app
---
title: BGP Network Implementation
permalink: /work/iprouting
---

![ip-routing](project-img/ip-routing-visio.png){: #intro .project}

#### Design and Implementation:
1. All routers were configured to run BGP in a resilient manner. The whole network belongs to one AS (Autonomous System)

2. OSPF (Open Shortest Path First) protocol was used as the IGP (Interior Gateway Protocol) to achieve network connectivity as it has faster convergence and triggered updates.

3. For IGP, the network was divided into 3 different areas so that the routing table was not too big. All the core routers were placed under Area 0 or the backbone area. The edge routers were placed under area 1 (SJO) and area 2 (NYC). 

4. Within the AS, iBGP was used with full mesh connectivity. iBGP would rely on IGP learned route path. However, to avoid scalability problems due to iBGP, route reflectors were configured. The core routers were made the route reflector and the edge routers were made clients.

5. Routing policy was designed to account for network relationships of customer, peer and transit.
   
   >Following relationships were set-up:
   > 
   > a. **Customer** : In this relationship, the customer pays for the service we provide by advertising their route. Hence, these routes are given higher preference.
   >
   > b. **Peer** : This relationship is where no one benefits and no money is exchanged. The operators simply form a peer relationship to reduce dependency on upstream providers to get routes.
   > 
   > c. **Transit** : In this relationship the operator pays to the transit provider to get all internet routes.

6. For incoming and outgoing traffic, separate routing policies were implemented for the relationships:

    > a. **Customer-In** : All customer routes were taken and local preference set to 200.
    >
    > b. **Customer-Out** : Advertised all routes to the customer as we are the transit provider.
    >
    > c. **Peer-In** : All Peer routes were taken and local preference set to 150. This would mean the customer route would be preferred over a peer route.
    >
    > d. **Peer-Out** : Advertized only customer tagged routes to the peers.
    >
    > e. **Transit-In** : All routes from the transit provider were taken and local preference set to 100. As we pay the transit provider, we try to keep the costs minimum by preferring transit provider routes, only if we do not have the customer or peer routes for the same destination.
    >
    > f. **Transit-Out** : Advertized only customer tagged routes.

7. Community tags were used to differentiate the routes received via each relationship and to determine the routes to send to each relationship.
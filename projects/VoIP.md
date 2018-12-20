---
title: VoIP Network
permalink: /work/VoIP
---
Designed and configured a VoIP network to establish inter-site connectivity using ADTRAN SIP Gateway, SIP trunking, PRI,
Call Routing and Call Optimization techniques.

<br>
#### Components:

>a. 2 Analog phones
>
>b. 2 IP Phones
>
>c. 1 Soft Phone
>
>d. 1 Cisco CME Router
>
>e. 2 Adtran Routers
>
>f. Asterix PBX (ISO image installed on a computer)

![voip-network](project-img/voip-network-visio2.png){: #project-image" .project}

<br>
#### Implementation:

1. Designed separate data and voice networks for the traffic due to different QoS requirements

2. Analog Phone 1 was made to register to the PBX and be able to call any phone on the network. Analog Phone 2 was made to register to Adtran(core) and be able to call any phone on the network.

3. The IP Phone 1 was registered to the PBX whereas IP Phone 2 was registered to the Cisco CME.

4. X-lite SIP was used as a softphone and registered to the PBX.

5. SIP trunking was set up between Cisco CME, Adtran (Core), Adtran and PBX.
  > A SIP trunk is a virtual circuit over the data network that connects your phone to the network. One advantage of having a SIP trunk is that you don't have to maintain two physical circuits for data and voice separately; as it used the data network.

6. Below is an example of how the call from IP Phone1 to Analog Phone 2 would be routed.
  > IP Phone1 --> PBX --> Adtran --> Cisco CME --> Adtran (Core) --> Analog Phone 2
  >
  > Two SIP trunks were configured from the Adtran to reach the Analog Phone 2. One was directly via Adtran (core) and the other involved an extra hop of Cisco CME. In the above example, the route via Cisco CME was preferred because its cost was set lower than the direct route from Adtran to Adtran (Core).

7. Adtran was configured as network firewall with NAT for data and voice.


<br>
#### Research Paper

Extended on the idea of secure VoIP and carried out further research on different security techniques that can be implemented in VoIP.

**Abstract** — Voice over IP (VoIP) is the new standard technology for telephony, gradually replacing the old Public Switched Telephone Network (PSTN). This research focuses on the security aspect of VoIP systems. Unsecured VoIP systems are vulnerable to malicious attacks. However, the overhead of the security techniques hampers the performance of VoIP systems. This research analyzes how a VoIP system performs with different security techniques. The performance of the VoIP system is analyzed on different types of data networks such as IPv4, IPv6, and IPv4/IPv6 mixed networks and in scenarios such as with and without network traffic. Additionally, the research includes a cost-benefit analysis of the security techniques, to determine their cost effectiveness. Based on the performance analysis and cost-benefit analysis, this research proposes three security techniques that can be applied to VoIP systems deployed on IPv4, IPv6, and IPv4/IPv6 networks.

<section id="project-button">
  <div class="project">
    <a href="https://github.com/moizhussain92/voip/raw/master/Voip-CapstoneResearchPaper.pdf" download class="btn btn-view-works">Download Research Paper</a>
  </div>
</section>
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

![voip-network](project-img/voip-network-visio1.png){: #project-image" .project}

<br>
#### Implementation:

1. Designed separate data and voice networks for the traffic due to different QoS requirements

2. The cisco router was configured to be the firewall with all the traffic from data and voice networks passing through it.

3. IP, Analog and Soft Phones were made to register to the PBX and interconnected across the network. The Adtran router was configured to perform the call routing through SIP trunk. 

<br>
#### Research Paper

Extended on the idea of secure VoIP and carried out further research on different security techniques that can be implemented in VoIP.

**Abstract** — Voice over IP (VoIP) is the new standard technology for telephony, gradually replacing the old Public Switched Telephone Network (PSTN). This research focuses on the security aspect of VoIP systems. Unsecured VoIP systems are vulnerable to malicious attacks. However, the overhead of the security techniques hampers the performance of VoIP systems. This research analyzes how a VoIP system performs with different security techniques. The performance of the VoIP system is analyzed on different types of data networks such as IPv4, IPv6, and IPv4/IPv6 mixed networks and in scenarios such as with and without network traffic. Additionally, the research includes a cost-benefit analysis of the security techniques, to determine their cost effectiveness. Based on the performance analysis and cost-benefit analysis, this research proposes three security techniques that can be applied to VoIP systems deployed on IPv4, IPv6, and IPv4/IPv6 networks.

<section id="project-button">
  <div class="project">
    <a href="https://github.com/moizhussain92/voip/raw/master/Voip-CapstoneResearchPaper.pdf" download class="btn btn-view-works">Download Research Paper</a>
  </div>
</section>
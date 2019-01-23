# jan/23/2019 11:40:17 by RouterOS 6.42.1
# software id = 28XL-EMMX
#
# model = RouterBOARD 750 r2
# serial number = 67D206F8D939
/interface pptp-client
add connect-to=pp-indo.vpnjantit.com name=VPN-SG password=310385 user=\
    chucky-vpnjantit.com
add connect-to=178.128.111.186 name=mikhmon password=irtech1749 user=\
    irtech@mikhmononline
/interface ethernet
set [ find default-name=ether1 ] comment=BRIDGE name=eth1-ont
set [ find default-name=ether2 ] comment=CONTROL name=eth2-admin
set [ find default-name=ether3 ] comment=SERVER name=eth3-server
set [ find default-name=ether4 ] arp=reply-only comment="To CLIENT" name=\
    eth4-HotSpot
set [ find default-name=ether5 ] arp=reply-only comment="To ONT Port 4" \
    mac-address=A4:40:27:B0:0B:95 name=eth5-stb
/interface ethernet switch port
set 0 vlan-mode=fallback
set 1 vlan-mode=fallback
set 2 vlan-mode=fallback
set 3 vlan-mode=fallback
set 4 vlan-mode=fallback
set 5 vlan-mode=fallback
/interface list
add exclude=dynamic name=discover
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-client option
add code=12 name=hostiptv value="'BY87000782316165'"
/ip firewall layer7-protocol
add name=torrent regexp="^.+(Torrent|torrent)"
/ip hotspot profile
set [ find default=yes ] dns-name=irtech.net hotspot-address=13.254.11.1 \
    html-directory=flash/hotspot login-by=http-chap name=hsprof1
/ip hotspot user profile
set [ find default=yes ] add-mac-cookie=no name=Super status-autorefresh=15s \
    transparent-proxy=yes
add add-mac-cookie=no !mac-cookie-timeout name="MyFamily 1M/4M" rate-limit=\
    1M/4M status-autorefresh=15s transparent-proxy=yes
add name=Friends on-login=":put (\",,0,,,noexp,\")" rate-limit=2M/2M \
    status-autorefresh=15s transparent-proxy=yes
/ip pool
add name=dhcp_server ranges=12.254.11.2/31
add name=dhcp_client ranges=13.254.11.7-13.254.11.254
add name=dhcp_admin ranges=11.254.11.2-11.254.11.200
/ip dhcp-server
add add-arp=yes address-pool=dhcp_admin always-broadcast=yes disabled=no \
    interface=eth2-admin name=dhcp_admin
add add-arp=yes address-pool=dhcp_server always-broadcast=yes disabled=no \
    interface=eth3-server name=dhcp_server
add add-arp=yes address-pool=dhcp_client authoritative=after-2sec-delay \
    disabled=no interface=eth4-HotSpot lease-time=5m name=dhcp_client
/ip hotspot
add address-pool=dhcp_client addresses-per-mac=1 disabled=no interface=\
    eth4-HotSpot name=HotSpot
/ppp profile
set *0 use-encryption=no
add change-tcp-mss=no comment=IRTech name=IRTech use-compression=no \
    use-encryption=no use-ipv6=no use-mpls=no use-upnp=no
/interface pppoe-client
add ac-name=BRAS4-D6-BJM add-default-route=yes comment=INTERNET disabled=no \
    interface=eth1-ont keepalive-timeout=5 name=TELKOM password=114310991 \
    profile=default-encryption service-name=80:FB:06:AD:C4:B3 user=\
    162406800563@telkom.net
/queue type
add kind=pcq name=down_pcq pcq-classifier=dst-address pcq-dst-address6-mask=\
    64 pcq-src-address6-mask=64
add kind=pcq name=up_pcq pcq-classifier=src-address pcq-dst-address6-mask=64 \
    pcq-src-address6-mask=64
/queue tree
add comment="=================================================================\
    ============= GLOBAL 30 Mbps =============================================\
    ======================" max-limit=100M name="IRTec Network" parent=global \
    queue=default
add comment="=================================================================\
    ================HARDI=====================================================\
    ==================" max-limit=8M name=Hardi parent="IRTec Network" queue=\
    default
add max-limit=8M name="1.hardi Download" packet-mark=hardi-down parent=Hardi \
    priority=2 queue=down_pcq
add max-limit=5M name="2.hardi Upload" packet-mark=hardi-up parent=Hardi \
    queue=up_pcq
add max-limit=8M name="3.hardi YT/PS DW" packet-mark=hardivideo-down parent=\
    Hardi priority=3 queue=down_pcq
add max-limit=5M name="4.hardi YOUTUBE UP" packet-mark=hardivideo-up parent=\
    Hardi priority=3 queue=up_pcq
add comment="=================================================================\
    =================PIO======================================================\
    ==================" max-limit=10M name=Pio parent="IRTec Network" queue=\
    default
add max-limit=10M name="1.pio Download" packet-mark=pio-down parent=Pio \
    priority=2 queue=down_pcq
add max-limit=3M name="2.pio Upload" packet-mark=pio-up parent=Pio queue=\
    up_pcq
add max-limit=10M name="3.pio YT/PS DW" packet-mark=piovideo-down parent=Pio \
    priority=3 queue=down_pcq
add max-limit=3M name="4.pio YOUTUBE UP" packet-mark=piovideo-up parent=Pio \
    priority=3 queue=up_pcq
add comment="=================================================================\
    ================NOOR======================================================\
    =================" max-limit=7M name=Noor parent="IRTec Network" queue=\
    default
add max-limit=7M name="1.noor Download" packet-mark=noor-down parent=Noor \
    priority=2 queue=down_pcq
add max-limit=5M name="2.noor Upload" packet-mark=noor-up parent=Noor queue=\
    up_pcq
add max-limit=6M name="3.noor YT/PS DW" packet-mark=noorvideo-down parent=\
    Noor priority=3 queue=down_pcq
add max-limit=5M name="4.noor YOUTUBE UP" packet-mark=noorvideo-up parent=\
    Noor priority=3 queue=up_pcq
add comment="=================================================================\
    =================DEVI=====================================================\
    ===================" max-limit=7M name=Devi parent="IRTec Network" queue=\
    default
add max-limit=7M name="1.devi Download" packet-mark=devi-down parent=Devi \
    priority=2 queue=down_pcq
add max-limit=5M name="2.devi Upload" packet-mark=devi-up parent=Devi queue=\
    up_pcq
add max-limit=7M name="3.devi YT/PS DW" packet-mark=devivideo-down parent=\
    Devi priority=3 queue=down_pcq
add max-limit=5M name="4.devi YOUTUBE UP" packet-mark=devivideo-up parent=\
    Devi priority=3 queue=up_pcq
add comment="=================================================================\
    ================ADMIN=====================================================\
    ==================" max-limit=100M name=Admin parent="IRTec Network" \
    queue=default
add max-limit=100M name="1.admin Download" packet-mark=admin-down parent=\
    Admin priority=2 queue=down_pcq
add max-limit=100M name="2.admin Upload" packet-mark=admin-up parent=Admin \
    queue=up_pcq
add max-limit=100M name="3.admin YT/PS DW" packet-mark=adminvideo-down \
    parent=Admin priority=3 queue=down_pcq
add max-limit=100M name="4.admin YOUTUBE UP" packet-mark=adminvideo-up \
    parent=Admin priority=3 queue=up_pcq
add comment="=================================================================\
    =================RISKA====================================================\
    ==================" max-limit=8M name=Riska parent="IRTec Network" queue=\
    default
add max-limit=8M name="1.riska Download" packet-mark=riska-down parent=Riska \
    priority=2 queue=down_pcq
add max-limit=5M name="2.riska Upload" packet-mark=riska-up parent=Riska \
    queue=up_pcq
add max-limit=8M name="3.riska YT/PS DW" packet-mark=riskavideo-down parent=\
    Riska priority=3 queue=down_pcq
add max-limit=5M name="4.riska YOUTUBE UP" packet-mark=riskavideo-up parent=\
    Riska priority=3 queue=up_pcq
add comment="=================================================================\
    =================MIA======================================================\
    ================" max-limit=12M name=Mia parent="IRTec Network" queue=\
    default
add max-limit=12M name="1.mia Download" packet-mark=mia-down parent=Mia \
    priority=2 queue=down_pcq
add max-limit=5M name="2.mia Upload" packet-mark=mia-up parent=Mia queue=\
    up_pcq
add max-limit=8M name="3.mia YT/PS DW" packet-mark=miavideo-down parent=Mia \
    priority=3 queue=down_pcq
add max-limit=5M name="4.mia YOUTUBE UP" packet-mark=miavideo-up parent=Mia \
    priority=3 queue=up_pcq
add comment="=================================================================\
    =================SERVER===================================================\
    ===================" max-limit=20M name=Server parent="IRTec Network" \
    queue=default
add max-limit=20M name="1.server down" packet-mark=server-down parent=Server \
    priority=2 queue=default
add max-limit=15M name="2.server up" packet-mark=server-up parent=Server \
    queue=default
add max-limit=20M name="3.server youtube dw" packet-mark=servervideo-down \
    parent=Server priority=3 queue=pcq-download-default
add max-limit=10M name="4.server youtube up" packet-mark=servervideo-up \
    parent=Server priority=3 queue=pcq-upload-default
/snmp community
set [ find default=yes ] addresses=0.0.0.0/0
/system logging action
add name=action1 target=echo
/ip neighbor discovery-settings
set discover-interface-list=discover
/interface list member
add list=discover
/interface pppoe-server server
add authentication=pap disabled=no interface=eth4-HotSpot max-mru=1480 \
    max-mtu=1480 one-session-per-host=yes service-name=Service_Home_Network
/ip address
add address=10.254.11.2/24 interface=eth1-ont network=10.254.11.0
add address=11.254.11.1/24 interface=eth2-admin network=11.254.11.0
add address=13.254.11.1/24 interface=eth4-HotSpot network=13.254.11.0
add address=12.254.11.1/24 interface=eth3-server network=12.254.11.0
/ip arp
add address=10.254.11.1 interface=eth1-ont mac-address=CC:06:77:31:77:58
/ip cloud
set update-time=no
/ip dhcp-client
add add-default-route=no dhcp-options=hostiptv interface=eth2-admin
/ip dhcp-server lease
add address=11.254.11.2 always-broadcast=yes client-id=1:e4:d5:3d:b0:21:1e \
    mac-address=E4:D5:3D:B0:21:1E server=dhcp_admin
/ip dhcp-server network
add address=11.254.11.0/24 gateway=11.254.11.1
add address=12.254.11.0/24 gateway=12.254.11.1 netmask=24
add address=13.254.11.0/24 gateway=13.254.11.1 netmask=32
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,8.8.4.4
/ip dns static
add address=208.67.222.222 disabled=yes name=OpenDNS1
add address=208.67.220.220 disabled=yes name=OpenDNS2
/ip firewall address-list
add address=11.254.11.0/24 list=private-admin
add address=13.254.11.5 list=private-hardi
add address=13.254.11.3 list=private-pio
add address=13.254.11.4 list=private-noor
add address=13.254.11.6 list=private-devi
add address=13.254.11.0/24 list=bypass-local
add address=12.254.11.0/24 list=bypass-local
add address=10.254.11.0/24 list=bypass-local
add address=13.254.11.2 list=private-riska
add address=118.98.0.0/17 list=ggc-telkom
add address=118.97.0.0/16 list=ggc-telkom
add address=11.254.11.0/24 list=bypass-local
add address=13.254.11.7 list=private-mia
add address=216.239.32.0/19 list=ggc-telkom
add address=216.58.192.0/19 list=ggc-telkom
add address=172.217.0.0/16 list=ggc-telkom
add address=74.125.0.0/16 list=ggc-telkom
add address=36.64.0.0/16 list=ggc-telkom
add address=36.65.0.0/16 list=ggc-telkom
add address=36.66.0.0/16 list=ggc-telkom
add address=36.67.0.0/16 list=ggc-telkom
add address=36.68.0.0/16 list=ggc-telkom
add address=36.69.0.0/16 list=ggc-telkom
add address=36.70.0.0/16 list=ggc-telkom
add address=36.71.0.0/16 list=ggc-telkom
add address=36.72.0.0/16 list=ggc-telkom
add address=36.73.0.0/16 list=ggc-telkom
add address=36.74.0.0/16 list=ggc-telkom
add address=36.75.0.0/16 list=ggc-telkom
add address=36.76.0.0/16 list=ggc-telkom
add address=36.77.0.0/16 list=ggc-telkom
add address=36.78.0.0/16 list=ggc-telkom
add address=36.79.0.0/16 list=ggc-telkom
add address=36.80.0.0/16 list=ggc-telkom
add address=36.81.0.0/16 list=ggc-telkom
add address=36.82.0.0/16 list=ggc-telkom
add address=36.83.0.0/16 list=ggc-telkom
add address=36.84.0.0/16 list=ggc-telkom
add address=36.85.0.0/16 list=ggc-telkom
add address=36.86.0.0/16 list=ggc-telkom
add address=36.87.0.0/16 list=ggc-telkom
add address=36.88.0.0/16 list=ggc-telkom
add address=36.89.0.0/16 list=ggc-telkom
add address=36.90.0.0/16 list=ggc-telkom
add address=61.5.0.0/17 list=ggc-telkom
add address=61.94.0.0/16 list=ggc-telkom
add address=110.136.0.0/16 list=ggc-telkom
add address=110.137.0.0/16 list=ggc-telkom
add address=110.138.0.0/16 list=ggc-telkom
add address=110.139.0.0/16 list=ggc-telkom
add address=118.96.0.0/16 list=ggc-telkom
add address=125.160.0.0/16 list=ggc-telkom
add address=125.162.0.0/16 list=ggc-telkom
add address=125.164.0.0/16 list=ggc-telkom
add address=125.165.0.0/16 list=ggc-telkom
add address=125.167.0.0/16 list=ggc-telkom
add address=180.241.0.0/16 list=ggc-telkom
add address=180.242.0.0/16 list=ggc-telkom
add address=180.243.0.0/16 list=ggc-telkom
add address=180.244.0.0/16 list=ggc-telkom
add address=180.245.0.0/16 list=ggc-telkom
add address=180.246.0.0/16 list=ggc-telkom
add address=180.247.0.0/16 list=ggc-telkom
add address=180.248.0.0/16 list=ggc-telkom
add address=180.249.0.0/16 list=ggc-telkom
add address=180.250.0.0/16 list=ggc-telkom
add address=180.251.0.0/16 list=ggc-telkom
add address=180.252.0.0/16 list=ggc-telkom
add address=180.253.0.0/16 list=ggc-telkom
add address=180.254.0.0/16 list=ggc-telkom
add address=222.124.0.0/16 list=ggc-telkom
add address=12.254.11.2 list=private-server
/ip firewall filter
add action=accept chain=input in-interface=eth5-stb protocol=igmp
add action=accept chain=input in-interface=eth5-stb protocol=udp
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=forward comment="Blokir IP Nakal" disabled=yes \
    src-address=12.254.11.2
/ip firewall mangle
add action=mark-connection chain=prerouting comment=ICMP new-connection-mark=\
    ICMP_LOKAL passthrough=yes protocol=icmp
add action=mark-packet chain=prerouting connection-mark=ICMP_LOKAL \
    new-packet-mark=PKT-ICMP passthrough=no
add action=accept chain=prerouting comment="Bypass Local Traffic" \
    dst-address-list=bypass-local src-address-list=bypass-local
add action=accept chain=forward dst-address-list=bypass-local \
    src-address-list=bypass-local
add action=mark-connection chain=prerouting comment=adminvideo \
    dst-address-list=ggc-telkom new-connection-mark=adminvideo passthrough=\
    yes src-address-list=private-admin
add action=accept chain=prerouting comment=adminvideo connection-mark=\
    adminvideo
add action=mark-packet chain=forward comment=adminvideo-down connection-mark=\
    adminvideo in-interface=TELKOM new-packet-mark=adminvideo-down \
    passthrough=no
add action=mark-packet chain=forward comment=adminvideo-up connection-mark=\
    adminvideo new-packet-mark=adminvideo-up out-interface=TELKOM \
    passthrough=no
add action=mark-connection chain=forward comment="ADMIN Down" dst-address=\
    11.254.11.0/24 new-connection-mark=admin-down passthrough=yes
add action=mark-connection chain=forward comment="ADMIN Up" \
    new-connection-mark=admin-up passthrough=yes src-address=11.254.11.0/24
add action=mark-packet chain=forward comment="Admin Down" connection-mark=\
    admin-down new-packet-mark=admin-down passthrough=yes
add action=mark-packet chain=forward comment="Admin Up" connection-mark=\
    admin-up new-packet-mark=admin-up passthrough=yes
add action=mark-connection chain=prerouting comment=riskavideo \
    dst-address-list=ggc-telkom new-connection-mark=riskavideo passthrough=\
    yes src-address-list=private-riska
add action=accept chain=prerouting comment=riskavideo connection-mark=\
    riskavideo
add action=mark-packet chain=forward comment=riskavideo-down connection-mark=\
    riskavideo in-interface=TELKOM new-packet-mark=riskavideo-down \
    passthrough=no
add action=mark-packet chain=forward comment=riskavideo-up connection-mark=\
    riskavideo new-packet-mark=riskavideo-up out-interface=TELKOM \
    passthrough=no
add action=mark-connection chain=forward comment="RISKA Down" dst-address=\
    13.254.11.2 new-connection-mark=riska-down passthrough=yes
add action=mark-connection chain=forward comment="RISKA Up" \
    new-connection-mark=riska-up passthrough=yes src-address=13.254.11.2
add action=mark-packet chain=forward comment="Riska Down" connection-mark=\
    riska-down new-packet-mark=riska-down passthrough=yes
add action=mark-packet chain=forward comment="Riska Up" connection-mark=\
    riska-up new-packet-mark=riska-up passthrough=yes
add action=mark-connection chain=prerouting comment=hardivideo \
    dst-address-list=ggc-telkom new-connection-mark=hardivideo passthrough=\
    yes src-address-list=private-hardi
add action=accept chain=prerouting comment=hardivideo connection-mark=\
    hardivideo
add action=mark-packet chain=forward comment=hardivideo-down connection-mark=\
    hardivideo in-interface=TELKOM new-packet-mark=hardivideo-down \
    passthrough=no
add action=mark-packet chain=forward comment=hardivideo-up connection-mark=\
    hardivideo new-packet-mark=hardivideo-up out-interface=TELKOM \
    passthrough=no
add action=mark-connection chain=forward comment="HARDI Down" dst-address=\
    13.254.11.5 new-connection-mark=hardi-down passthrough=yes
add action=mark-connection chain=forward comment="HARDI Up" \
    new-connection-mark=hardi-up passthrough=yes src-address=13.254.11.5
add action=mark-packet chain=forward comment="Hardi Down" connection-mark=\
    hardi-down new-packet-mark=hardi-down passthrough=yes
add action=mark-packet chain=forward comment="Hardi Up" connection-mark=\
    hardi-up new-packet-mark=hardi-up passthrough=yes
add action=mark-connection chain=prerouting comment=piovideo \
    dst-address-list=ggc-telkom new-connection-mark=piovideo passthrough=yes \
    src-address-list=private-pio
add action=accept chain=prerouting comment=piovideo connection-mark=piovideo
add action=mark-packet chain=forward comment=piovideo-down connection-mark=\
    piovideo in-interface=TELKOM new-packet-mark=piovideo-down passthrough=no
add action=mark-packet chain=forward comment=piovideo-up connection-mark=\
    piovideo new-packet-mark=piovideo-up out-interface=TELKOM passthrough=no
add action=mark-connection chain=forward comment="PIO Down" dst-address=\
    13.254.11.3 new-connection-mark=pio-down passthrough=yes
add action=mark-connection chain=forward comment="PIO Up" \
    new-connection-mark=pio-up passthrough=yes src-address=13.254.11.3
add action=mark-packet chain=forward comment="Pio Down" connection-mark=\
    pio-down new-packet-mark=pio-down passthrough=yes
add action=mark-packet chain=forward comment="Pio Up" connection-mark=pio-up \
    new-packet-mark=pio-up passthrough=yes
add action=mark-connection chain=prerouting comment=noorvideo \
    dst-address-list=ggc-telkom new-connection-mark=noorvideo passthrough=yes \
    src-address-list=private-noor
add action=accept chain=prerouting comment=noorvideo connection-mark=\
    noorvideo
add action=mark-packet chain=forward comment=noorvideo-down connection-mark=\
    noorvideo in-interface=TELKOM new-packet-mark=noorvideo-down passthrough=\
    no
add action=mark-packet chain=forward comment=noorvideo-up connection-mark=\
    noorvideo new-packet-mark=noorvideo-up out-interface=TELKOM passthrough=\
    no
add action=mark-connection chain=forward comment="NOOR Down" dst-address=\
    13.254.11.4 new-connection-mark=noor-down passthrough=yes
add action=mark-connection chain=forward comment="NOOR Up" \
    new-connection-mark=noor-up passthrough=yes src-address=13.254.11.4
add action=mark-packet chain=forward comment="Noor Down" connection-mark=\
    noor-down new-packet-mark=noor-down passthrough=yes
add action=mark-packet chain=forward comment="Noor Up" connection-mark=\
    noor-up new-packet-mark=noor-up passthrough=yes
add action=mark-connection chain=prerouting comment=devivideo \
    dst-address-list=ggc-telkom new-connection-mark=devivideo passthrough=yes \
    src-address-list=private-devi
add action=accept chain=prerouting comment=devivideo connection-mark=\
    devivideo
add action=mark-packet chain=forward comment=devivideo-down connection-mark=\
    devivideo in-interface=TELKOM new-packet-mark=devivideo-down passthrough=\
    no
add action=mark-packet chain=forward comment=devivideo-up connection-mark=\
    devivideo new-packet-mark=devivideo-up out-interface=TELKOM passthrough=\
    no
add action=mark-connection chain=forward comment="DEVI Down" dst-address=\
    13.254.11.6 new-connection-mark=devi-down passthrough=yes
add action=mark-connection chain=forward comment="DEVI Up" \
    new-connection-mark=devi-up passthrough=yes src-address=13.254.11.6
add action=mark-packet chain=forward comment="Devi Down" connection-mark=\
    devi-down new-packet-mark=devi-down passthrough=yes
add action=mark-packet chain=forward comment="Devi Up" connection-mark=\
    devi-up new-packet-mark=devi-up passthrough=yes
add action=mark-connection chain=prerouting comment=miavideo \
    dst-address-list=!private-mia new-connection-mark=miavideo passthrough=no \
    src-address-list=private-mia
add action=accept chain=prerouting comment=miavideo connection-mark=miavideo
add action=mark-packet chain=forward comment=miavideo-down connection-mark=\
    miavideo in-interface=TELKOM new-packet-mark=miavideo-down passthrough=no
add action=mark-packet chain=forward comment=miavideo-up connection-mark=\
    miavideo new-packet-mark=miavideo-up out-interface=TELKOM passthrough=no
add action=mark-connection chain=forward comment="MIA Down" dst-address=\
    13.254.11.7 new-connection-mark=mia-down passthrough=yes
add action=mark-connection chain=forward comment="MIA Up" \
    new-connection-mark=mia-up passthrough=yes src-address=13.254.11.7
add action=mark-packet chain=forward comment="Mia Down" connection-mark=\
    mia-down new-packet-mark=mia-down passthrough=yes
add action=mark-packet chain=forward comment="Mia Up" connection-mark=mia-up \
    new-packet-mark=mia-up passthrough=yes
add action=mark-connection chain=prerouting comment=servervideo content=\
    googlevideo.com dst-address-list=!private-server new-connection-mark=\
    servervideo passthrough=no src-address-list=private-server
add action=accept chain=prerouting comment=servervideo connection-mark=\
    servervideo
add action=mark-packet chain=forward comment=servervideo-down \
    connection-mark=servervideo in-interface=TELKOM new-packet-mark=\
    servervideo-down passthrough=no
add action=mark-packet chain=forward comment=servervideo-up connection-mark=\
    servervideo new-packet-mark=servervideo-up out-interface=TELKOM \
    passthrough=no
add action=mark-connection chain=forward comment="SERVER Down" dst-address=\
    12.254.11.2 new-connection-mark=server-down passthrough=yes
add action=mark-connection chain=forward comment="SERVER Up" \
    new-connection-mark=server-up passthrough=yes src-address=12.254.11.2
add action=mark-packet chain=forward comment="Server Down" connection-mark=\
    server-down new-packet-mark=server-down passthrough=yes
add action=mark-packet chain=forward comment="Server Up" connection-mark=\
    server-up new-packet-mark=server-up passthrough=yes
add action=mark-routing chain=prerouting disabled=yes new-routing-mark=PPTP \
    passthrough=yes src-address=12.254.11.2-12.254.11.254
add action=mark-routing chain=prerouting disabled=yes new-routing-mark=PPTP \
    passthrough=yes src-address=11.254.11.0/24
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=passthrough chain=unused comment=dnsbtmp disabled=yes
add action=masquerade chain=srcnat out-interface=TELKOM
add action=masquerade chain=srcnat disabled=yes out-interface=VPN-SG
add action=masquerade chain=srcnat comment="Masquerade IP Boleh Internetan" \
    disabled=yes out-interface=TELKOM src-address-list=private-admin
add action=redirect chain=dstnat comment="DNS CloudFlare" disabled=yes \
    dst-port=53 protocol=udp to-ports=53
add action=dst-nat chain=dstnat comment="Web Server" disabled=yes dst-port=\
    8080 in-interface=TELKOM protocol=tcp to-addresses=12.254.11.2 to-ports=\
    9981
add action=dst-nat chain=dstnat comment="DNS Premium Singapore" disabled=yes \
    dst-port=53 protocol=udp to-addresses=208.67.222.222 to-ports=443
add action=dst-nat chain=dstnat disabled=yes dst-port=53 protocol=udp \
    to-addresses=208.67.220.220 to-ports=443
/ip hotspot user
add name=supmin password=310385
add name=deril password=deril1 profile="MyFamily 1M/4M"
add name=husen password=husen1 profile="MyFamily 1M/4M"
add name=faiz password=01faiz profile=Friends
add name=gelo password=gelo01 profile=Friends
add name=boiz password=23
/ip hotspot walled-garden
add dst-host=mylivechat.com
add dst-host=12.254.11.2
add dst-host=s2.mylivechat.com
add dst-host=www.mylivechat.com
/ip route
add disabled=yes distance=1 gateway=VPN-SG routing-mark=PPTP
/ip service
set telnet disabled=yes
set ftp address=11.254.11.0/24,12.254.11.0/24 disabled=yes
set www address=11.254.11.0/24,12.254.11.0/24 disabled=yes
set ssh disabled=yes
set api address=10.254.11.0/24,11.254.11.0/24,12.254.11.0/24 disabled=yes
set winbox address=11.254.11.0/24,12.254.11.0/24
set api-ssl disabled=yes
/ppp aaa
set use-radius=yes
/ppp secret
add local-address=13.254.11.254 name=noor@irtech.id password=b0l4nk \
    remote-address=13.254.11.4 service=pppoe
add local-address=13.254.11.254 name=pio@irtech.id password=b0l4nk \
    remote-address=13.254.11.3 service=pppoe
add local-address=13.254.11.254 name=hardi@irtec.id password=b0l4nk \
    remote-address=13.254.11.5 service=pppoe
add local-address=13.254.11.254 name=devi@irtech.id password=b0l4nk \
    remote-address=13.254.11.6 service=pppoe
add local-address=13.254.11.254 name=riska@irtech.net password=b0l4nk \
    remote-address=13.254.11.2 service=pppoe
add local-address=13.254.11.254 name=mia@irtech.net password=b0l4nk \
    remote-address=13.254.11.7 service=pppoe
/routing igmp-proxy
set query-response-interval=1m40s quick-leave=yes
/routing igmp-proxy interface
add alternative-subnets=0.0.0.0/0 interface=eth5-stb upstream=yes
add interface=eth3-server
/system clock
set time-zone-name=Asia/Makassar
/system identity
set name=Metalator
/system logging
add action=echo topics=web-proxy
add action=disk prefix=-> topics=hotspot,info,debug
/system ntp client
set enabled=yes primary-ntp=114.141.48.158 secondary-ntp=202.162.32.12
/system routerboard settings
set silent-boot=no
/system scheduler
add disabled=yes interval=1d name=free-ramadhan-disable on-event="/ip hotspot \
    user set disable=yes [find where profile=\"ramadhan\"]; /ip hotspot active\
    \_rem [find where user~\"free\"]" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=may/19/2018 start-time=18:00:00
add disabled=yes interval=1d name=free-ramadhan-enable on-event=\
    "/ip hotspot user set disable=no [find where profile=\"ramadhan\"]" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=may/19/2018 start-time=15:00:00
/system script
add name=mikhmonv2 owner=chucky policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "Mirza Hotspot-|-mirzahotspot.net-|-Rp-|-5-|-2"
/tool bandwidth-server
set enabled=no
/tool e-mail
set address=74.125.136.109 from="IRTech Hotspot" password=m3t4l!z3r port=587 \
    start-tls=yes user=metalator.hotspot@gmail.com
/tool mac-server
set allowed-interface-list=none
/tool mac-server mac-winbox
set allowed-interface-list=none
/tool mac-server ping
set enabled=no
/tool netwatch
add comment="PING VPN SG CKNet" host=15.254.11.1 interval=2s

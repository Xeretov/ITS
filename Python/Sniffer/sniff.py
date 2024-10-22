from scapy.all import *
from scapy.layers.http import HTTPRequest, HTTPResponse

iPkt = 0

def process_packet(pkt):
    global iPkt
    iPkt += 1
    # print(f"Ho letto un pacchetto sulla tua macchina {str(iPkt)}")

    if not packet.haslayer(IP):
        return
    
    print(f"IP_SRC: {packet[IP].src} IP_DST: {packet[IP].dst} PROTO: {packet[IP].proto} LEN: {packet[IP].len}")

    if packet[IP].proto == 6:
        print(f"TCP_SRC_PORT: {packet[TCP].sport} TCP_DST_PORT: {packet[TCP].dport}")

        if packet[TCP].sport == 80:
            print("HttpResponse")
            if packet.haslayer("HttpResponse"):
                print(packet[HttpResponse].show())
        
        if packet[TCP].dport == 80:
            print("HttpRequest")
            if packet.haslayer("HttpRequest"):
                print(packet[HttpRequest].show())

sniff(iface="enp4s0", filter="", prn=process_packet)
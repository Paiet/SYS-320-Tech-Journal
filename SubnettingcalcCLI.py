# Created by Nicholas Martel
main.py

    from ipaddress import ip_interface
import argparse


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument("-a", "--address", help="host address", required=True)
    parser.add_argument("-n", "--netmask", help="Network mask", required=True)

    args = parser.parse_args()
    iface = ip_interface(f"{args.address}/{args.netmask}")
    network = iface.network.network_address
    broadcast = iface.network.broadcast_address
    hostmask = iface.hostmask
    netmask = iface.netmask
    hosts = list(iface.network.hosts())
    minimum_host = min(hosts, default=None)
    maximum_host = max(hosts, default=None)
    print(
        f"""
Network:            {network}/{netmask}
Broadcast:          {broadcast}
Minimum Host:       {minimum_host}
Maximum Host:       {maximum_host}
Hosts per Network:  {len(hosts)}
    """
    )


if __name__ == "__main__":
    main()

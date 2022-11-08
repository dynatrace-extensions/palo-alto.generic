# Palo Alto Generic Extension
**This is intended for users, who:**
- would like to monitor health state and performance of Palo Alto firewalls 

**This enables you to:**
- Monitor infrastructure with a comprehensive dashboard 
- Use SNMP as the data source 
- Take pre-emptive measures to avoid service degradations 

**The extension package contains:**
- SNMP DataSource configuration,
- dashboard template,
- Unified Analysis screen template,
- topology definition and entity extraction rules.

**Collected metrics:**

CPU & memory:
- System uptime
- Sensor Value
- CPU Management Plane Utilization
- CPU System Plane Utilization
- Memory Size
- Memory Used
- Memory Utilization

Gateway:
- Max Tunnels
- Active Sessions
- Max Sessions
- Sessions - TCP
- Sessions - UDP
- Sessions - ICMP

Interfaces:
- Interface Incoming Data
- Interface Outgoing Data
- Interface Incoming Errors
- Interface Outgoing Errors
- Interface Incoming Discards
- Interface Outgoing Discards

Virtual Systems:
- VSYS - Max Sessions
- VSYS - Active Sessions
- VSYS - Session Utilization


## Usage
For now go for [dev](#dev)

## Dev

### Prerequisites
- Nix-capable environment, for Windows that means [installing WSL](https://docs.microsoft.com/en-us/learn/modules/get-started-with-windows-subsystem-for-linux/2-enable-and-install)
- [nix](https://nixos.org/download.html) / [**nix for WSL**](https://nixos.org/download.html#nix-install-windows)
- Docker (available in the same environment as nix, required for running companions)

Hint: if something doesn't work because of missing package please add the package to `default.nix` instead of installing on your computer. Why solve the problem for one if you can solve the problem for all? ;)

### Everything
```
nix-shell
# caution! if this is your first pull of first extension ever this might take some time
# depending on your network connection
# after it completes: inside the shell
make help
```

### Resources
- [Extension yaml docs](https://www.dynatrace.com/support/help/extend-dynatrace/extensions20/extension-yaml)
- [Extension knowledge base](https://www.dynatrace.com/support/help/extend-dynatrace/extensions20)

### Convinience
This section is entirely **optional**. The repository contains additional amenities, but they're not so straightforward, so we don't recommend them for begginers.  Anyway, you might also like:
- [`direnv`](https://direnv.net/) (which can be installed easily via `nix-env -iA nixpkgs.direnv`)

### Internal tooling
If you're a **Dynatrace employee** you can follow [this link](https://github.com/dynatrace-extensions/precious-toolz-internal) to enable internal tooling

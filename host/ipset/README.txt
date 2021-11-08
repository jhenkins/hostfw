IPSET firewall templates

The premise

asdasda


The files and folders

.
├── 00-generic
│   ├── 00-header.txt
│   └── 01-prep.txt
├── 01-nat
│   └── 00-natrule
├── 02-global
│   ├── 00-all_useful_icmp
│   ├── 01-talk_to_self
│   ├── 02-fw_to_everywhere
│   ├── 03-vpn_traffic_inwards
│   ├── 04-agents_outwards
│   ├── 05-good_hosts_and_nets
│   ├── 06-rule_6
│   └── 99-catch_all
├── 99-ipsets
├── compile-fw.sh
├── docs
│   └── ipset-fw-notes.txt
└── README.txt



How it works

* The "compile-fw.sh" script creates a template firewall script, using the snippets in
  the numbered folders. All source files are sequencially numbered, so that the contents
  is added to the template script in sequence.

Things to do




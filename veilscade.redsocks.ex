base {
	// debug: connection progress & client list on SIGUSR1
	log_debug = off;

	// info: start and end of client session
	log_info = on;

	/* possible `log' values are:
	 *   stderr
	 *   "file:/path/to/file"
	 *   syslog:FACILITY  facility is any of "daemon", "local0"..."local7"
	 */
	log = "syslog:daemon";

	// detach from console
	daemon = on;

	/* Change uid, gid and root directory, these options require root
	 * privilegies on startup.
	 * Note, your chroot may requre /etc/localtime if you write log to syslog.
	 * Log is opened before chroot & uid changing.
	 */
	user = redsocks;
	group = redsocks;
	// chroot = "/var/chroot";

	/* possible `redirector' values are:
	 *   iptables   - for Linux
	 *   ipf        - for FreeBSD
	 *   pf         - for OpenBSD
	 *   generic    - some generic redirector that MAY work
	 */
	redirector = iptables;
}

redsocks {
	/* `local_ip' defaults to 127.0.0.1 for security reasons,
	 * use 0.0.0.0 if you want to listen on every interface.
	 * `local_*' are used as port to redirect to.
	 */
	local_ip = 127.0.0.1;
	local_port = 12345;

	// `ip' and `port' are IP and tcp-port of proxy-server
	// You can also use hostname instead of IP, only one (random)
	// address of multihomed host will be used.
	ip = 127.0.0.1;
	port = 1080;


	// known types: socks4, socks5, http-connect, http-relay
	type = socks5;

	// login = "foobar";
	// password = "baz";
}

redudp {
	// `local_ip' should not be 0.0.0.0 as it's also used for outgoing
	// packets that are sent as replies - and it should be fixed
	// if we want NAT to work properly.
	local_ip = 127.0.0.1;
	local_port = 10053;

	// `ip' and `port' of socks5 proxy server.
	ip = 192.0.2.1;
	port = 1080;
	login = username;
	password = pazzw0rd;

	// kernel does not give us this information, so we have to duplicate it
	// in both iptables rules and configuration file.  By the way, you can
	// set `local_ip' to 127.45.67.89 if you need more than 65535 ports to
	// forward ;-)
	// This limitation may be relaxed in future versions using contrack-tools.
	dest_ip = 192.0.2.2;
	dest_port = 53;

	udp_timeout = 30;
	udp_timeout_stream = 180;
}

dnstc {
	// fake and really dumb DNS server that returns "truncated answer" to
	// every query via UDP, RFC-compliant resolver should repeat same query
	// via TCP in this case.
	local_ip = 127.0.0.1;
	local_port = 5300;
}

// you can add more `redsocks' and `redudp' sections if you need.

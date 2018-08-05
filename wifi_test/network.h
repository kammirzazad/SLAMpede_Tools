#ifndef OWPING_NETWORK_H
#define OWPING_NETWORK_H

extern "C"
{
	#include <netdb.h>
	#include <unistd.h>
	#include <net/if.h>
	#include <sys/ioctl.h>
	#include <sys/socket.h>
	#include <arpa/inet.h>
	#include <netinet/in.h>
	#include <linux/net_tstamp.h>
}

#endif

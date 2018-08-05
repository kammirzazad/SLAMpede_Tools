#ifndef	OWPING_IPINFO_H
#define OWPING_IPINFO_H

class	ipInfo
{
	public:

	ipInfo(std::string _selfIP, std::string _peerIP, std::string _selfIF, uint _portNum)
	:	portNum(_portNum), selfIP(_selfIP), selfIF(_selfIF), peerIP(_peerIP)
	{}

	uint		portNum;
	std::string	selfIP;
	std::string	selfIF;
	std::string	peerIP;
};

#endif

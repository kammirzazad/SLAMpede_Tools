#include "common.h"
#include "time.h"
#include "udpSocket.h"

#include <cassert>
#include <fstream>

const uint interval = 1000;
const uint numPings = 100000;
const uint numAfter = numPings/10;

std::string WIPs[6] = { "192.168.4.14", "192.168.4.15", "192.168.4.16", "192.168.4.9", "192.168.4.8", "192.168.4.4" };

using	sockets = std::vector<udpSocket<uint64_t>>;

class	owDelay
{
	public:

	owDelay(char* src_node, char* self_node)
	{
		path2log  = src_node;
		path2log += "_";
		path2log += self_node;
		path2log += ".csv";
	}

	void	addEntry(uint64_t delay)	{ delays.push_back(delay); }

	void	dump()
	{
		std::ofstream log(path2log.c_str());

		log << "--- This line is added to be compatible with OMNET++ log files ---" << std::endl;

		for(uint i=0; i<delays.size(); i++)
		{
			log << i << "," << (delays[i]/1000) << std::endl;
		}

		log.close();
	}

	private:

	std::string		path2log;
	std::vector<uint64_t>	delays;
};

uint	getIdx(char* node)
{
	if( strcmp(node,"b0") == 0 ) { return 0; }
	if( strcmp(node,"o0") == 0 ) { return 1; }	
	if( strcmp(node,"p0") == 0 ) { return 2; }
	if( strcmp(node,"b1") == 0 ) { return 3; }
	if( strcmp(node,"o1") == 0 ) { return 4; }
	if( strcmp(node,"p1") == 0 ) { return 5; }

	std::cout << "Unknown node " << node << std::endl;
	exit(1);
}

uint	getPort(char* srcNode, char* dstNode)
{
	uint srcIdx = getIdx(srcNode);
	uint dstIdx = getIdx(dstNode);

	return 5000+(6*srcIdx)+dstIdx;
}

void	recvPing(sockets& inSocs, std::vector<owDelay>& owds)
{
	uint64_t now;

	for(uint i=0; i<inSocs.size(); i++)
	{
		if(inSocs[i].recvTry())
		{				
			setTime(now);
			int64_t owDelay = now - (*inSocs[i].getData());
			assert(owDelay > 0);
			owds[i].addEntry(owDelay);
		}
	}	
}

void	sendPing(sockets& outSocs)
{
	uint64_t now;
	static	 uint seqN = 0;

	for(uint i=0; i<outSocs.size(); i++)
	{
		setTime(now);
		outSocs[i].send(&now,seqN);
	}

	seqN++;
}

int 	main(int argc, char* argv[])
{
	if(argc < 4)
	{
		std::cout << "usage: [self] [numSrc] [src1(opt)] ... [dest1(opt)] ..." << std::endl;\
		exit(1);
	}

	uint numSrc = atoi(argv[2]);
	std::string selfIP = WIPs[getIdx(argv[1])];

	sockets 		inSocs, outSocs;
	std::vector<owDelay>	delays;

	for(uint i=0; i<numSrc; i++)
	{
		delays.emplace_back(argv[3+i], argv[1]);
		//ipInfo(selfIP,peerIP,selfIF,portNum)
		inSocs.emplace_back(ipInfo(selfIP, WIPs[getIdx(argv[3+i])], "wlan0", getPort(argv[3+i],argv[1])));
	}

	for(uint i=0; i<(argc-(3+numSrc)); i++)
	{
		outSocs.emplace_back(ipInfo(selfIP, WIPs[getIdx(argv[3+numSrc+i])], "wlan0", getPort(argv[1],argv[3+numSrc+i])));
	}

	for(uint i=0; i<numPings; i++)
	{
		recvPing(inSocs,delays);

		sendPing(outSocs);

		usleep(interval);
	}

	for(uint i=0; i<numAfter; i++)		
	{ 
		recvPing(inSocs,delays); 

		usleep(interval);
	}

	for(uint i=0; i<inSocs.size(); i++)	{ delays[i].dump(); }

	return 0;
}

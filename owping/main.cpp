#include "common.h"
#include "time.h"
#include "udpSocket.h"

#include <cassert>
#include <fstream>

const unsigned int interval = 10*1000;

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

std::string	getIP(char* node)
{
	if( strcmp(node,"b0") == 0 )
		return "192.168.4.14";

	if( strcmp(node,"o0") == 0 )
		return "192.168.4.15";

	if( strcmp(node,"p0") == 0 )
		return "192.168.4.16";

	if( strcmp(node,"b1") == 0 )
		return "192.168.4.9";

	if( strcmp(node,"o1") == 0 )
		return "192.168.4.8";

	if( strcmp(node,"p1") == 0 )
		return "192.168.4.4";
}

//ipInfo(selfIP,peerIP,selfIF,portNum)

int 	main(int argc, char* argv[])
{
	if(argc < 4)
	{
		std::cout << "usage: [self] [numSrc] [src1(opt)] ... [dest1(opt)] ..." << std::endl;\
		exit(1);
	}

	std::string selfIP = getIP(argv[1]);
	unsigned int numSrc = atoi(argv[2]);

	std::vector<owDelay>	delays;
	std::vector<udpSocket<uint64_t>> inSockets, outSockets;

	for(int i=0; i<numSrc; i++)
	{
		delays.emplace_back(argv[3+i], argv[1]);
		inSockets.emplace_back(ipInfo(selfIP, getIP(argv[3+i]), "wlan0", 5000));
	}

	for(int i=0; i<(argc-(3+numSrc)); i++)
	{
		outSockets.emplace_back(ipInfo(selfIP, getIP(argv[3+numSrc+i]), "wlan0", 5000));
	}

	uint64_t now;
	unsigned int seqN = 0;

	for(int j=0; j<10000; j++)
	{
		for(unsigned int i=0; inSockets.size(); i++)
		{		
			if(inSockets[i].recvTry())
			{				
				setTime(now);
				int64_t owDelay = now - (*inSockets[i].getData());
				assert(owDelay > 0);
				delays[i].addEntry(owDelay);
			}
		}


		for(unsigned int i=0; i<outSockets.size(); i++)
		{
			setTime(now);
			outSockets[i].send(&now,seqN);
		}

		seqN++;

		usleep(interval);
	}

	for(unsigned int i=0; i<inSockets.size(); i++)	{ delays[i].dump(); }

	return 0;
}

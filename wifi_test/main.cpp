#include "common.h"
#include "time.h"
#include "udpSocket.h"

#include <cassert>
#include <fstream>

std::string WIPs[6] = { "192.168.4.14", "192.168.4.15", "192.168.4.16", "192.168.4.9", "192.168.4.8", "192.168.4.4" };

struct	dat1	{ char data[ 128]; };
struct	dat2	{ char data[ 256]; };
struct	dat3	{ char data[ 512]; };
struct	dat4	{ char data[1024]; };
struct	dat5	{ char data[2048]; };
struct	dat6	{ char data[4096]; };

dat1	dd1;
dat2	dd2;
dat3	dd3;
dat4	dd4;
dat5	dd5;
dat6	dd6;

udpSocket<dat1> socket1(ipInfo(WIPs[0], WIPs[1], "wlan0", 5000));
udpSocket<dat2> socket2(ipInfo(WIPs[0], WIPs[1], "wlan0", 5001));
udpSocket<dat3> socket3(ipInfo(WIPs[0], WIPs[1], "wlan0", 5002));
udpSocket<dat4> socket4(ipInfo(WIPs[0], WIPs[1], "wlan0", 5003));
udpSocket<dat5> socket5(ipInfo(WIPs[0], WIPs[1], "wlan0", 5004));
udpSocket<dat6> socket6(ipInfo(WIPs[0], WIPs[1], "wlan0", 5005));

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

void	send(uint dataSize)
{
	if( dataSize == 128 )
	{
		socket1.send(&dd1,0);
	}
	else if( dataSize == 256 )
	{
		socket2.send(&dd2,0);
	}
	else if( dataSize == 512 )
	{
		socket3.send(&dd3,0);
	}
	else if( dataSize == 1024 )
	{
		socket4.send(&dd4,0);
	}
	else if( dataSize == 2048 )
	{
		socket5.send(&dd5,0);
	}
	else if( dataSize == 4096)
	{
		socket6.send(&dd6,0);
	}
	else
	{
		std::cout << "Unknown data size" << std::endl;
	}
	
}

void	print_stats(uint dataSize, std::vector<uint64_t> times)
{
	uint64_t min = -1;
	uint64_t max = 0; 
	uint64_t sum = 0;

	for(uint i=0; i<times.size(); i++)
	{
		if( times[i] < min ) { min = times[i]; }
		if( times[i] > max ) { max = times[i]; }

		sum += times[i];
	}

	std::cout << "[dataSize=" << dataSize << "] [min=" << min << "] [avg=" << (sum/times.size()) << "] [max=" << max << "]" << std::endl;
}


int 	main(int argc, char* argv[])
{
	rTime start;
	std::vector<uint> dataSizes = {128,256,512,1024,2048,4096};
	std::vector<uint64_t> times;

	std::cout << "Sending UDP packets from blue0 to orange0 over wlan0 interface" << std::endl;
	
	for(uint i=0; i<dataSizes.size(); i++)
	{
		times.clear();

		for(uint j=0; j<100; j++)
		{
			start.init();
			send(dataSizes[i]);
			times.push_back(start.getTimePassed());
	
			usleep(10*1000);
		}

		print_stats(dataSizes[i],times);
	}

	return 0;
}

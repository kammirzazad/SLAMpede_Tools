#include "common.h"
#include "time.h"
#include "udpSocket.h"

#include <cassert>
#include <fstream>

#define	COUNT 	10000

std::string WIPs[6] = { "192.168.4.14", "192.168.4.15", "192.168.4.16", "192.168.4.9", "192.168.4.8", "192.168.4.4" };

struct	data 
{
	float arr[2][100];
};

float	getVal(int i, int j)
{
	return ((100*i)+j)/10000.0;
}

void	set(data& arg)
{
	for(int i=0; i<2; i++)
		for(int j=0; j<100; j++)
			arg.arr[i][j] = getVal(i,j);
}

bool	check(const data& arg)
{
	for(int i=0; i<2; i++)
		for(int j=0; j<100; j++)
			if ( arg.arr[i][j] != getVal(i,j) )
				return false;

	return true;
}

int main(int argc, char* argv[])
{

	if( strcmp(argv[1],"tx") == 0 )
	{
		data arg;
		set(arg);

		udpSocket<data> socket(ipInfo(WIPs[0], WIPs[1], "wlan0", 5000));

		for(int i=0; i<COUNT; i++)
		{
			usleep(1000);
			socket.send(&arg,i);
		}
	}
	else
	{
		udpSocket<data> socket(ipInfo(WIPs[1], WIPs[0], "wlan0", 5000));

		for(int i=0; i<COUNT; i++)
		{
			socket.recv();

			if( ! check(*socket.getData()) ) 
			{
				std::cout << socket.getSeqNumber() << std::endl;
			}
		}
	}

	return 0;
}

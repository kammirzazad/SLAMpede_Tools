#include "common.h"
#include "time.h"
#include "udpSocket.h"

#include <cassert>
#include <fstream>

std::string WIPs[6] = { "192.168.4.14", "192.168.4.15", "192.168.4.16", "192.168.4.9", "192.168.4.8", "192.168.4.4" };

struct	data 
{
	float arr[10][10];
};

float	getVal(int i, int j)
{
	return ((10*i)+j)/1000.0;
}

void	set(data& arg)
{
	for(int i=0; i<10; i++)
		for(int j=0; j<10; j++)
			arg.arr[i][j] = getVal(i,j);
}

bool	check(const data& arg)
{
	for(int i=0; i<10; i++)
		for(int j=0; j<10; j++)
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

		for(int i=0; i<100; i++)
		{
			usleep(1000);
			socket.send(&arg,i);
		}
	}
	else
	{
		udpSocket<data> socket(ipInfo(WIPs[1], WIPs[0], "wlan0", 5000));

		while(true)
		{
			socket.recv();
			std::cout << socket.getSeqNumber() << " " << check(*socket.getData()) << std::endl;
		}
	}

	return 0;
}

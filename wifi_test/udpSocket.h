#ifndef	OWPING_UDPSOCKET
#define	OWPING_UDPSOCKET

#include "common.h"
#include "ipInfo.h"
#include "network.h"

#define TIMEOUT_GRANULARITY 1000

template <typename T>
class	udpSocket
{
	private:

	static const	uint payloadSize = sizeof(uint) + sizeof(T);

	public:

	T*		getData()	{ return (T*)(buffer+sizeof(uint)); }

	uint		getSeqNumber()	{ return *((uint*)buffer); }

        void            send(T* data, uint seqN)
        {
			std::memcpy((void*)(buffer), (void*)&seqN, sizeof(uint));
			std::memcpy((void*)(buffer+sizeof(uint)), (void*)data, sizeof(T));

			assert(sendto(socketHandle, buffer, payloadSize, 0, (sockaddr*)&udpClient, len) == payloadSize);	
        }

	/* blocking receive */
	void		recv()
	{
			assert(recvfrom(socketHandle, buffer, payloadSize, 0, (sockaddr*)&udpClient, &len) != -1);
	}

	/* unblocking receive */
	bool		recvTry()
	{
			return (recvfrom(socketHandle, buffer, payloadSize, MSG_DONTWAIT, (sockaddr*)&udpClient, &len) != -1);
	}
		
	/* blocking receive with timeout */
	bool		recv(uint timeout_in_us)
	{				
			//std::cout << "Timeout=" << cdiv(timeout_in_us, TIMEOUT_GRANULARITY) << "ms" << std::endl;

			bool status = false;

			for(uint i=0; i<cdiv(timeout_in_us, TIMEOUT_GRANULARITY); i++)
			{
				status = recvTry();
			
				if(status){ break; }				

				usleep(TIMEOUT_GRANULARITY);
			}

/*
			setSocketTimeout(timeout_in_us);
			bool status = (recvfrom(socketHandle, buffer, payloadSize, 0, addr, len) != -1);			
			setSocketTimeout(0);
*/

			return status;
	}

	udpSocket(const ipInfo& params)
	{
			// create a socket
			socketHandle = socket(AF_INET, SOCK_DGRAM, 0);

			if(socketHandle == -1)
			{
				std::cout << "could not create a socket!" << std::endl;
				exit(1);
			}
	
			// attach to specific interface
			ifreq ifr;
			memset(&ifr, 0, sizeof(ifr));
			snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), params.selfIF.c_str());
			int rc = setsockopt(socketHandle, SOL_SOCKET, SO_BINDTODEVICE, (void *)&ifr, sizeof(ifr));	

			if(rc < 0)
			{
				perror("setsockopt() error for SO_BINDTODEVICE");
				printf("%s\n", strerror(errno));
				close(socketHandle);
				exit(-1);
			}		

			// set up port number and ip address
			udpServer.sin_port = htons(params.portNum);
			udpServer.sin_family = AF_INET;
			udpServer.sin_addr.s_addr = inet_addr(params.selfIP.c_str());

			// bind to the socket 
			rc = bind(socketHandle, (struct sockaddr*)&udpServer, sizeof(udpServer));

			if (rc != 0) 
			{
				std::cout << "Could not bind to " << params.selfIP << ":" << params.portNum << std::endl;
				close(socketHandle);
				exit(1);
			}

			udpClient.sin_port = htons(params.portNum);
			udpClient.sin_family = AF_INET;
			udpClient.sin_addr.s_addr = inet_addr(params.peerIP.c_str());

			len = sizeof(udpClient);
	}

	private:

	void		setSocketTimeout(uint timeout_in_us)
	{
			timeval tv;

			tv.tv_sec = (timeout_in_us/(1000*1000));
			tv.tv_usec = (timeout_in_us%(1000*1000));

			/* would this also affect all the following receives ? */
			if(setsockopt(socketHandle, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) < 0) 
			{
				std::cout << "Failed to set timeout to " << timeout_in_us << std::endl;
				exit(1);
			}			
	}	

	int		socketHandle;
	char		buffer[payloadSize];
	socklen_t	len;
	sockaddr_in	udpServer;
	sockaddr_in	udpClient;
};

#endif

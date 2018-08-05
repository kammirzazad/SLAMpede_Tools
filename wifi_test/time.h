#ifndef	OWPING_TIME_H
#define	OWPING_TIME_H

#include <chrono>

class	rTime
{	
	typedef std::chrono::time_point<std::chrono::high_resolution_clock> _rTime;

	public:

	rTime()	{ init(); }

	void	init()	{ t = now(); }		

	uint	getTimePassed()
	{	
		return std::chrono::duration_cast<std::chrono::microseconds>(now()-t).count();
	}

	static	uint64_t	getMilliSec()	
	{
		return std::chrono::duration_cast<std::chrono::milliseconds>(now().time_since_epoch()).count();
	}

	static	uint64_t	getMicroSec()
	{
		return std::chrono::duration_cast<std::chrono::microseconds>(now().time_since_epoch()).count();
	}

	static	uint64_t	getNanoSec()
	{
		return std::chrono::duration_cast<std::chrono::nanoseconds>(now().time_since_epoch()).count();
	}

	private:

	static	_rTime now()
	{
		return std::chrono::high_resolution_clock::now();
	}
	
	_rTime	t;
};

#endif

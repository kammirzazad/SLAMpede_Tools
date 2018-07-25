#ifndef	OWPING_TIME_H
#define	OWPING_TIME_H

#include <chrono>

using	namespace std::chrono;

void	setTime(uint64_t& t)
{
	auto now = high_resolution_clock::now();
	t = duration_cast<nanoseconds>(now.time_since_epoch()).count();
}

#endif

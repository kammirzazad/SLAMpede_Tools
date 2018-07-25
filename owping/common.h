#ifndef OWPING_COMMON_H
#define OWPING_COMMON_H

#include <vector>
#include <string>
#include <cassert>
#include <cstring>
#include <fstream>
#include <iostream>

typedef	unsigned int uint;

uint	cdiv(uint a, uint b)	{ return (a+b-1)/b; }

#define	MICRO_TO_MILI	1000
#define	NANO_TO_MICRO	1000
#define NANO_TO_MILI	1000*1000

struct  singleTimePoint { uint64_t tp0; };
struct  doubleTimePoint { uint64_t tp0, tp1; };

struct	sensorData
{
	uint	count;
	uint64_t minVal, maxVal;
};

/*
#include <cstdio>
#include <cstdlib>
#include <functional>	
#include <fcntl.h>		
#include <sys/types.h>	
#include <linux/stat.h>
*/

#endif


/*
 *        File: [:VIM_EVAL:]expand("<afile>:t")[:END_EVAL:]
 *  Created on: [:VIM_EVAL:]strftime("%Y %b %d")[:END_EVAL:]
 *      Author: [:VIM_EVAL:]expand("$USER")[:END_EVAL:]
 */
#include <stdio.h>
#include <stdlib.h>


int
main (void)
{
#ifndef ONLINE_JUDGE
#define C_LOG(...) printf(__VA_ARGS__)
  freopen ("input.txt", "r", stdin);
#else
#define C_LOG(...)
#endif

  return EXIT_SUCCESS;
}

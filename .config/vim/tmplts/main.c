/*
 *        Author: [:VIM_EVAL:]expand("$USER")[:END_EVAL:]
 *          File: [:VIM_EVAL:]expand("<afile>:p:t")[:END_EVAL:]
 *   Description: .
 *    Created on: [:VIM_EVAL:]strftime("%b %d %Y %R %z")[:END_EVAL:]
 */
#include <stdio.h>

int
main (void)
{
/* TODO: Move this preprocessor to codeforce flag file. */
#ifndef ONLINE_JUDGE
  freopen ("input.txt", "r", stdin);
#endif

#ifndef ONLINE_JUDGE
  fclose (stdin);
#endif
  return 0;
}

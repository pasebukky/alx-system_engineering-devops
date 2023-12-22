#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

/**
 * infinite_while - runs infinitely in a while loop
 *
 * Return: 0 in the end
 *
 */

int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - the entry to a program that creates 5 zombie process
 *
 * Return: 0 on sucess
 *
 */

int main(void)
{
int cp = 0;
pid_t pid;

while (cp < 5)
{
	pid = fork();
	if (!pid)
		break;
	printf("Zombie process created, PID: %i\n", (int)pid);
	cp++;
}
if (pid != 0)
	infinite_while();
return (0);
}

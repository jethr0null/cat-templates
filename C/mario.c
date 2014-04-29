#include <stdio.h>
#include <cs50.h>
#include <math.h>

int main()
{
	int h;
	//int p = 2;
	//int w = h - 2;
	printf("How tall would you like your Pyrimid to be? Enter a number between 1 and 23: ");
	h = GetInt();
	while ( h <= 0 || h > 23)
	{
	printf("Please enter a number which is greater than 0 and less than 24! \n");
	h = GetInt();
	}
	for(int i = 0; i < height; i++)
	{
		//print spaces printf( w * " ");
		//print hashes printf( p * "#");
		//p++;
		//print new line printf("\n")
	}
If h is between 0 and 24 we need to print that many lines. int w = whitespaces to be printed and for the top line is h - 2. int p = number of hashes to be printed and is equal to 2 and needs to be incremented by 1 each time while w needs to be decremented each time. 

}


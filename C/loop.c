#include <stdio.h>

int main()
{	
	int height = 10;
	int whitespace;
	int hash;
	int original_height = height;

	while ( height > 0 )
	{
		for ( whitespace = height - 2; whitespace > 0; whitespace-- )
			printf("a");
		
		for ( hash = original_height - height + 1 ; hash > 1; hash-- )
			printf("#");
		height--;	

		printf("\n");
	}
}

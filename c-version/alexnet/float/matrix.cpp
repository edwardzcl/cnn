#include <stdlib.h>
#include <string.h>
#include <stdio.h>


int main()
{
	int i,j,k;
	int a[2][2][3];
	for (i = 0; i < 2; i++)
	{
		for (j = 0; j < 2; j++)
		{
			for (k = 0; k < 3; k++)
			{
				a[i][j][k] = i + j + k;
			}
		}
	}
	int (*b)[2][3];
	b = a;

	printf("��ȡlabel���飺\n");



	printf("���10��label��\n");
	for (i = 0; i < 2; i++)
	{
		for (j = 0; j < 2; j++)
		{
			for (k = 0; k < 3; k++)
			{
				printf("%d\n", b[i][j][k]);
			}
		}
	}

	/*
	int  i[2][2][2] = { 1,2,3,4,5,6,7,8 };
	int (*pi)[2][2];
	int **pi1 = (int **)i;


	*/

	return 0;

}
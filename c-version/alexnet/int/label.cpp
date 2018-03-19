#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>



char  ***product_labelmatrix(FILE *fp)
{
	int i, j;
	char ***label;

	printf("获取label数组：\n");
	label = (char ***)malloc(sizeof(char **) * 18);
	for (i = 0; i < 18; i++)
	{
		label[i] = (char **)malloc(sizeof(char *) * 4);
		for (j = 0; j < 4; j++)
		{
			label[i][j] = (char *)malloc(11*sizeof(char));
			fgets(label[i][j], 11, fp);

		}
	}


	printf("输出10个label：\n");
	for (i = 0; i < 18; i++)
	{
		for (j = 0; j < 4; j++)
		{
			printf("%s", label[i][j]);
				;
		}
	}


	return label;

}


int main()
{
	FILE *fp;
	char ***label;

	if ((fp = fopen("label.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}


	label = product_labelmatrix(fp);


	return 0;
}
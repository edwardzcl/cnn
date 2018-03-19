//一个3D卷积操作过程,主要思想是多维指针动态申请内存

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>






void dynamic_imgarr(int*** arr, int m, int n, int p)                          //申请动态数组(图像)
{
	int i, j;
	arr = (int ***)malloc(sizeof(int **) * p);

	for (i = 0; i < p; i++)
	{
		arr[i] = (int **)malloc(sizeof(int*) * m);

		for (j = 0; j < m; j++)
		{
			arr[i][j] = (int *)malloc(sizeof(int) * n);
			memset(arr[i][j], 0, sizeof(int) * n);

		}


	}
}



int*** product_imgmatrix(FILE *fp,int m, int n, int p)
{
	int i, x, y;
	int*** arr_a;
	arr_a = NULL;
	dynamic_imgarr(arr_a, m, n, p);                               //输入数组（图像）


	printf("获取图像数组：\n");

	/*
	if ((fp = fopen("img.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	
	*/


	
	printf("输出一行图像数组：\n");
	for (y = 220; y < n; y++)
	{

		printf("%d", arr_a[2][226][y]);
		printf("\n");
	}

	

	return arr_a;
}










int main()
{

	int i,j,k,p;

	int ***arr_i;




	FILE *fp1;



	if ((fp1 = fopen("image.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}



		arr_i = product_imgmatrix(fp1, 227, 227, 3);     //输入数组（图像）

	fclose(fp1);

	return 0;

}



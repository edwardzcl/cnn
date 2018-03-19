#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>

#include <mat.h>






void dynamic_imgarr(float**** arr, int m, int n, int p)                          //申请动态数组(图像)
{
	int i, j;
	*arr = (float ***)malloc(sizeof(float **) * p);

	for (i = 0; i < p; i++)
	{
		(*arr)[i] = (float **)malloc(sizeof(float*) * m);

		for (j = 0; j < m; j++)
		{
			(*arr)[i][j] = (float *)malloc(sizeof(float) * n);
			memset((*arr)[i][j], 0, sizeof(float) * n);

		}


	}
}






void dynamic_weightarr(float***** arr, int m, int n, int p, int l)                          //申请动态数组(权值)
{
	int i, j, k;
	*arr = (float ****)malloc(sizeof(float ***) * l);

	for (i = 0; i < l; i++)
	{
		(*arr)[i] = (float ***)malloc(sizeof(float**) * p);

		for (j = 0; j < p; j++)
		{
			(*arr)[i][j] = (float **)malloc(sizeof(float*) * m);

			for (k = 0; k < m; k++)
			{
				(*arr)[i][j][k] = (float *)malloc(sizeof(float) * n);
				memset((*arr)[i][j][k], 0, sizeof(float) * n);

			}
		}
	}
}




float*** product_imgmatrix(FILE *fp, int m, int n, int p)
{
	int i, x, y;
	float*** arr_a;

	dynamic_imgarr(&arr_a, m, n, p);                               //输入数组（图像）


	printf("获取图像数组：\n");

	/*
	if ((fp = fopen("img.txt", "r+")) == NULL)
	{
	printf("Cannot open file!\n");
	exit(1);
	}


	*/


	for (i = 0; i < p; i++)
	{
		for (x = 0; x< m; x++)
		{
			for (y = 0; y < n; y++)
			{
				fscanf(fp, "%f", &arr_a[i][x][y]);
			}
		}
	}


	printf("输出一行图像数组：\n");
	for (y = 220; y < n; y++)
	{

		printf("%5f", arr_a[2][226][y]);
		printf("\n");
	}



	return arr_a;
}





float**** product_weightmatrix(float *initA, int m, int n, int p, int q)  //传文件指针是可以的，并且作为一种特殊的指针会接上次的调用
{
	int i, j, k, l;
	float**** arr_b;

	dynamic_weightarr(&arr_b, m, n, p, q);                                //输入数组（权值）

	printf("获取权值数组：\n");

	/*
	if ((fp = fopen("weight.txt", "r+")) == NULL)
	{
	printf("Cannot open file!\n");
	exit(1);
	}


	*/

	for (l = 0; l < q; l++)
	{
		for (k = 0; k < p; k++)
		{
			for (j = 0; j < m; j++)
			{
				for (i = 0; i < n; i++)
				{
					arr_b[l][k][j][i] = initA[l*p*m*n + k*m*n + i*m + j];

				}
			}
		}
	}






	printf("输出一行权值数据：\n");

	/*
	for (y = 0; y < n; y++)
	{

	printf("%5f", arr_b[2][2][1][y]);
	printf("\n");
	}

	*/


	return arr_b;
}





float *** product_biasmatrix(FILE *fp, int p)
{
	int i, x, y;
	float*** arr_bias;

	dynamic_imgarr(&arr_bias, 1, 1, p);                                //输入数组（偏移）


	printf("获取偏移数组：\n");
	/*

	if ((fp = fopen("bias.txt", "r+")) == NULL)
	{
	printf("Cannot open file!\n");
	exit(1);
	}


	*/

	for (i = 0; i < p; i++)
	{
		for (x = 0; x< 1; x++)
		{
			for (y = 0; y < 1; y++)
			{
				fscanf(fp, "%f", &arr_bias[i][x][y]);
			}
		}
	}

	/*
	printf("输出一行偏移数据：\n");

	printf("%5f", arr_bias[1][0][0]);
	printf("\n");

	*/

	return arr_bias;
}















/*
void dynamic_biasarr(float**** arr, int p)                          //申请动态数组(偏移),可采用图像的输入方式
{
int i, j;
*arr = (float ***)malloc(sizeof(float **) * p);

for (i = 0; i < p; i++)
{
(*arr)[i] = (float **)malloc(sizeof(float*) * 1);

for (j = 0; j < 1; j++)
{
(*arr)[i][j] = (float *)malloc(sizeof(float) * 1);
memset((*arr)[i][j], 0, sizeof(float) * 1);
}
}
}

*/





void free_imgarr(float**** arr, int m, int p)                                      //释放占用的内存(3D),不需要传int n
{
	int k, i;

	for (k = 0; k < p; k++)
	{
		for (i = 0; i < m; i++)
		{
			free((*arr)[k][i]);
			(*arr)[k][i] = 0;
		}
		free((*arr)[k]);
		(*arr)[k] = 0;
	}

	/*为用于后面的分段处理，不能将此图像数组直接全部取消指针标记，保留最高一层的指针标记（保留未释放的部分），然后进行索引即可，否则会出现全部被释放的情况
	free(*arr);
	*arr = 0;

	*/

}



void free_weightarr(float***** arr, int m, int p, int l)                         // //释放占用的内存(4D),不需要传int n
{
	int k, i, j;

	for (k = 0; k < l; k++)
	{
		for (i = 0; i < p; i++)
		{
			for (j = 0; j < m; j++)
			{
				free((*arr)[k][i][j]);
				(*arr)[k][i][j] = 0;

			}
			free((*arr)[k][i]);
			(*arr)[k][i] = 0;
		}
		free((*arr)[k]);
		(*arr)[k] = 0;
	}
	free(*arr);
	*arr = 0;
}






void dynamic_fcimgarr(float** arr_a, int mimg, int nimg, int pimg)                          //申请动态数组(fc图像)，其内存的释放可以直接在内部写释放
{

	*arr_a = (float *)malloc(sizeof(float) * (mimg*nimg*pimg));
	memset(*arr_a, 0, sizeof(float) * (mimg*nimg*pimg));


}






void dynamic_fcweightarr(float*** arr, int m, int n)                          //申请动态二维数组(fc权值)
{
	int i;
	*arr = (float **)malloc(sizeof(float*) * m);

	for (i = 0; i < m; i++)
	{
		(*arr)[i] = (float *)malloc(sizeof(float) * n);
		memset((*arr)[i], 0, sizeof(float) * n);

	}

}




float *product_fcimgmatrix(float ***arr_a, int mimg, int nimg, int pimg)
{
	int i, j, k, l;
	float* arr_fc;

	dynamic_fcimgarr(&arr_fc, mimg, nimg, pimg);                               //输入数组（fc图像）



	printf("获取一维图像数组：\n");
	l = 0;
	for (k = 0; k< pimg; k++)
	{
		for (j = 0; j < nimg; j++)
		{
			for (i = 0; i<mimg; i++)
			{
				arr_fc[l] = arr_a[k][i][j];
				l++;

			}
		}
	}


	/*
	printf("输出一行图像数组：\n");

	for (i = 0; i < (mimg*nimg*pimg);i++)
	{
	printf("arr_fc=%5f", arr_fc[i]);
	printf("\n");

	}

	*/




	return arr_fc;
}






float **product_fcweightmatrix(float *initA, int mw, int nw)
{
	int i, j;
	float** arr_fcweight;

	dynamic_fcweightarr(&arr_fcweight, mw, nw);                               //输入数组（fc权值）




	printf("获取权值数组：\n");


	/*

	if ((fp = fopen("fcweight.txt", "r+")) == NULL)
	{
	printf("Cannot open file!\n");
	exit(1);
	}



	*/

	for (j = 0; j < mw; j++)
	{
		for (i = 0; i < nw; i++)
		{
			arr_fcweight[j][i] = initA[i * mw + j];

		}
	}


	/*
	printf("输出一行权值数组：\n");
	for (j = 0; j < nw; j++)
	{

	printf("%5f", arr_fcweight[1][j]);
	printf("\n");
	}

	*/

	return arr_fcweight;
}



float *** product_fcbiasmatrix(FILE *fp, int p)
{
	int i, x, y;
	float*** arr_bias;

	dynamic_imgarr(&arr_bias, 1, 1, p);                                //输入数组（fc偏移）


	printf("获取偏移数组：\n");
	/*

	if ((fp = fopen("bias.txt", "r+")) == NULL)
	{
	printf("Cannot open file!\n");
	exit(1);
	}


	*/

	for (i = 0; i < p; i++)
	{
		for (x = 0; x< 1; x++)
		{
			for (y = 0; y < 1; y++)
			{
				fscanf(fp, "%f", &arr_bias[i][x][y]);
			}
		}
	}

	/*
	printf("输出一行偏移数据：\n");

	printf("%5f", arr_bias[1][0][0]);
	printf("\n");

	*/

	return arr_bias;
}






void free_fcweightarr(float*** arr, int m)                                      //释放占用的内存(2D),不需要传int n
{
	int i;

	for (i = 0; i < m; i++)
	{
		free((*arr)[i]);
		(*arr)[i] = 0;
	}
	free(*arr);
	*arr = 0;
}







void free_fcimgarr(float** arr)                                      //释放占用的内存(1D),不需要传int n
{

	free(*arr);
	*arr = 0;

}






//合并函数 用于将分段处理的两个图像块合成一个图像块
float ***combine(float ***arr_a, float ***arr_b, int mimg, int nimg, int pimg)
{
	int i, j, k;
	float ***arr_res;
	dynamic_imgarr(&arr_res, mimg, nimg, pimg * 2);

	printf("开始两个图像块的合并\n");

	for (k = 0; k < pimg * 2; k++)
	{
		for (i = 0; i < mimg; i++)
		{

			for (j = 0; j < nimg; j++)

			{
				arr_res[k][i][j] = k < pimg ? (arr_a[k][i][j]) : (arr_b[k - pimg][i][j]);
			}
		}
	}


	free_imgarr(&arr_a, mimg, pimg);
	free_imgarr(&arr_b, mimg, pimg);




	return arr_res;
}





//卷积函数
float*** conv(float ***arr_a, float ****arr_b, int mimg, int nimg, int pimg, int mw, int nw, int pw, int lw, int str)
{

	int i, j, k, l, p, q;
	float sum;
	float*** arr_res;
	dynamic_imgarr(&arr_res, (mimg - mw) / str + 1, (nimg - nw) / str + 1, lw);

	printf("开始卷积操作\n");

	for (k = 0; k < lw; k++)
	{
		for (q = 0; q<(mimg - mw) / str + 1; q++)
		{
			for (p = 0; p<(nimg - nw) / str + 1; p++)
			{
				sum = 0;
				for (j = 0; j < pw; j++)
				{
					for (i = q*str; i < q*str + mw; i++)
					{

						for (l = p*str; l < p*str + nw; l++)

						{
							sum = sum + (arr_a[j][i][l]) * (arr_b[k][j][i - q*str][l - p*str]);

						}
					}
				}
				//printf("sum=%f\n", sum);
				arr_res[k][q][p] = sum;
			}

		}


	}

	free_imgarr(&arr_a, mimg, pimg);
	//free_weightarr(&arr_b, mw, pw, lw);





	return  arr_res;

}




//bias函数
float*** bias(float ***arr_a, float ***arr_b, int mimg, int nimg, int pimg, int pw)
{

	int i, j, k;

	printf("开始bias操作\n");

	for (k = 0; k < pimg; k++)
	{
		for (i = 0; i < mimg; i++)
		{
			for (j = 0; j < nimg; j++)
			{

				arr_a[k][i][j] = arr_a[k][i][j] + arr_b[k][0][0];
				//printf("arr_a=%f\n", arr_a[k][i][j]);
			}
		}
	}
	//free_imgarr(&arr_b, 1, pw);
	return  arr_a;
}





//relu函数
float ***relu(float ***arr_bias, int mimg, int nimg, int pimg)
{
	int i, j, k;

	printf("开始relu操作\n");


	for (k = 0; k < pimg; k++)
	{
		for (i = 0; i<mimg; i++)
		{
			for (j = 0; j <nimg; j++)
			{
				if (arr_bias[k][i][j] <0)
					arr_bias[k][i][j] = 0;

			}

		}
	}
	return arr_bias;
}



//fc层relu函数

float *fcrelu(float *arr_bias, int mimg)
{
	int i;

	printf("开始fc层relu操作\n");


	for (i = 0; i<mimg; i++)
	{

		if (arr_bias[i] <0)
			arr_bias[i] = 0;

	}


	return arr_bias;
}







//池化函数
float *** pool(float ***arr_relu, int mimg, int nimg, int pimg, int size, int str)
{
	int i, j, k, p, q;
	float ***arr_pool;
	float ch;
	dynamic_imgarr(&arr_pool, (mimg - size) / str + 1, (nimg - size) / str + 1, pimg);

	printf("开始池化操作\n");


	for (k = 0; k < pimg; k++)
	{
		for (q = 0; q<(mimg - size) / str + 1; q++)
		{
			for (p = 0; p<(nimg - size) / str + 1; p++)
			{
				ch = arr_relu[k][q*str][p*str];
				for (i = q*str; i< q*str + size; i++)
				{
					for (j = p*str; j < p*str + size; j++)
					{
						if (arr_relu[k][i][j] > ch)
						{
							ch = arr_relu[k][i][j];
						}
					}

				}
				arr_pool[k][q][p] = ch;
			}
		}
	}

	free_imgarr(&arr_relu, mimg, pimg);
	return arr_pool;

}





//padding函数
float *** padding(float ***arr_a, int mimg, int nimg, int pimg, int size)
{

	int i, j, k;
	float*** arr_padding;
	dynamic_imgarr(&arr_padding, mimg + size * 2, nimg + size * 2, pimg);

	printf("开始padding操作\n");

	for (k = 0; k < pimg; k++)
	{
		for (i = size; i < mimg + size; i++)
		{

			for (j = size; j <nimg + size; j++)
			{
				arr_padding[k][i][j] = arr_a[k][i - size][j - size];
			}
		}
	}


	free_imgarr(&arr_a, mimg, pimg);
	return arr_padding;
}






//fc函数
//循环体内部可以进行一维增量
//如何释放动态内存空间
//mian函数中可以设置衔接指针
float * fc(float **arr_a, float *arr_b, float ***arr_c, int mw, int nw)
{
	int i, j, l;
	float *arr_res;

	arr_res = (float *)malloc(sizeof(float) * nw);
	memset(arr_res, 0, sizeof(float) * nw);

	printf("获取fcbias数组\n");



	/*
	if ((fp = fopen("fcbias.txt", "r+")) == NULL)
	{
	printf("Cannot open file!\n");
	exit(1);
	}


	*/


	printf("开始fc操作\n");

	l = 0;
	for (i = 0; i < mw; i++)
	{
		for (j = 0; j < nw; j++)
		{

			arr_res[l] = arr_res[l] + arr_a[i][j] * arr_b[j];
		}
		arr_res[l] = arr_res[l] + arr_c[l][0][0];
		l++;
	}




	free_fcimgarr(&arr_b);
	//free_fcweightarr(&arr_a, mw);
	//free_imgarr(&arr_c, 1, mw);
	return  arr_res;

}



//获取1000个输出神经元对应的classes字符串数组
char** product_classesmatrix(FILE *fp)
{
	int i;
	char** classes;


	printf("获取classes数组：\n");

	classes = (char **)malloc(1000 * sizeof(char*));
	for (i = 0; i < 1000; i++)
	{
		classes[i] = (char *)malloc(10 * sizeof(char));
		fscanf(fp, "%s", classes[i]);

	}


	printf("输出10个classes：\n");
	for (i = 995; i<1000; i++)
	{

		printf("%s", classes[i]);
		printf("\n");
	}



	return classes;
}




//获取正确的分类label字符串数组
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
			label[i][j] = (char *)malloc(11 * sizeof(char));
			fgets(label[i][j], 11, fp);
			label[i][j][9] = '\0';

		}
	}


	printf("输出10个label：\n");
	for (i = 0; i<18; i++)
	{
		printf("%s", label[i][0]);
		printf("\n")
			;
	}


	return label;

}



//找出1000个输出神经元最大值的标号
int max(float *arr_a)
{
	int i, category;
	float a;

	a = arr_a[0];
	category = 0;
	for (i = 1; i<1000; i++)
	{
		if (a < arr_a[i])
		{
			a = arr_a[i];
			category = i;

		}

	}


	return category;

}







int main()
{
	int i, j, k, p;
	int image_name;
	int image_num;
	int category;
	int	correct;

	float ***arr_i;
	float *arr_j;
	float **arr_k;

	float ***arr_b1;
	float ***arr_b2;
	float ***arr_b3;
	float ***arr_b4;
	float ***arr_b5;
	float ***arr_b6;
	float ***arr_b7;
	float ***arr_b8;

	float ****arr_w1;
	float ****arr_w21;
	float ****arr_w22;
	float ****arr_w3;
	float ****arr_w41;
	float ****arr_w42;
	float ****arr_w51;
	float ****arr_w52;
	float **arr_w6;
	float **arr_w7;
	float **arr_w8;

	float ***arr_r;
	float ***arr_r1;
	float ***arr_r2;

	char *result;
	char **classes;
	char ***label;

	FILE *fp1;
	FILE *fp2;
	FILE *fp3;
	FILE *fp5;
	FILE *fp6;
	FILE *fp7;
	FILE *fp8;



	MATFile *pmatFile = NULL;
	mxArray *pMxArray1 = NULL;
	mxArray *pMxArray2 = NULL;
	mxArray *pMxArray3 = NULL;
	mxArray *pMxArray4 = NULL;
	mxArray *pMxArray5 = NULL;
	mxArray *pMxArray6 = NULL;
	mxArray *pMxArray7 = NULL;
	mxArray *pMxArray8 = NULL;


	// 读取.mat文件（例：mat文件名为"initUrban.mat"，其中包含"initA"）  
	float *initA;
	float *initB;



	if ((fp1 = fopen("image17.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp2 = fopen("correct.txt", "w+")) == NULL)      //读入每类图像的正确数
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp3 = fopen("bias.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp5 = fopen("fcbias.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp6 = fopen("classes.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp7 = fopen("label.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp8 = fopen("image_name.txt", "r+")) == NULL)    //读取每类图像的总数量
	{
		printf("Cannot open file!\n");
		exit(1);
	}


	classes = product_classesmatrix(fp6);
	label = product_labelmatrix(fp7);

	/*
	printf("输出所有的正确label\n");
	for (i = 0; i < 18; i++)
	{
		for (j = 0; j < 4; j++)
		{
			printf("%s\n", label[i][j]);

		}
	}

	*/


	pmatFile = matOpen("parameters.mat", "r");

	//int M = mxGetM(pMxArray);
	//int N = mxGetN(pMxArray);


	pMxArray1 = matGetVariable(pmatFile, "weight_1");
	pMxArray2 = matGetVariable(pmatFile, "weight_2");
	pMxArray3 = matGetVariable(pmatFile, "weight_3");
	pMxArray4 = matGetVariable(pmatFile, "weight_4");
	pMxArray5 = matGetVariable(pmatFile, "weight_5");
	pMxArray6 = matGetVariable(pmatFile, "weight_6");
	pMxArray7 = matGetVariable(pmatFile, "weight_7");
	pMxArray8 = matGetVariable(pmatFile, "weight_8");

	initA = (float*)mxGetData(pMxArray1);
	arr_w1 = product_weightmatrix(initA, 11, 11, 3, 96);
	mxFree(initA);

	initA = (float*)mxGetData(pMxArray2);
	arr_w21 = product_weightmatrix(initA, 5, 5, 48, 128);
	initB = &initA[153600];
	arr_w22 = product_weightmatrix(initB, 5, 5, 48, 128);
	mxFree(initA);

	initA = (float*)mxGetData(pMxArray3);
	arr_w3 = product_weightmatrix(initA, 3, 3, 256, 384);
	mxFree(initA);

	initA = (float*)mxGetData(pMxArray4);
	arr_w41 = product_weightmatrix(initA, 3, 3, 192, 192);
	initB = &initA[331776];
	arr_w42 = product_weightmatrix(initB, 3, 3, 192, 192);
	mxFree(initA);

	initA = (float*)mxGetData(pMxArray5);
	arr_w51 = product_weightmatrix(initA, 3, 3, 192, 128);
	initB = &initA[221184];
	arr_w52 = product_weightmatrix(initB, 3, 3, 192, 128);
	mxFree(initA);

	initA = (float*)mxGetData(pMxArray6);
	arr_w6 = product_fcweightmatrix(initA, 4096, 9216);
	mxFree(initA);

	initA = (float*)mxGetData(pMxArray7);
	arr_w7 = product_fcweightmatrix(initA, 4096, 4096);
	mxFree(initA);

	initA = (float*)mxGetData(pMxArray8);
	arr_w8 = product_fcweightmatrix(initA, 1000, 4096);
	mxFree(initA);




	arr_b1 = product_biasmatrix(fp3, 96);

	arr_b2 = product_biasmatrix(fp3, 256);

	arr_b3 = product_biasmatrix(fp3, 384);

	arr_b4 = product_biasmatrix(fp3, 384);

	arr_b5 = product_biasmatrix(fp3, 256);

	arr_b6 = product_fcbiasmatrix(fp5, 4096);

	arr_b7 = product_fcbiasmatrix(fp5, 4096);

	arr_b8 = product_fcbiasmatrix(fp5, 1000);


	for (image_name = 16; image_name < 17; image_name++)
	{
		//fscanf(fp8, "%d", &image_num);
		correct = 0;

		for (p = 0; p < 49; p++)
		{

			arr_i = product_imgmatrix(fp1, 227, 227, 3);     //输入数组（图像）


															 //第一卷积层
			arr_r = conv(arr_i, arr_w1, 227, 227, 3, 11, 11, 3, 96, 4);   //卷积函数

			arr_r = bias(arr_r, arr_b1, 55, 55, 96, 96);

			arr_r = relu(arr_r, 55, 55, 96);

			arr_r = pool(arr_r, 55, 55, 96, 3, 2);





			//第二卷积层

			arr_r = padding(arr_r, 27, 27, 96, 2);

			arr_r1 = conv(arr_r, arr_w21, 31, 31, 48, 5, 5, 48, 128, 1);   //卷积函数

			arr_r = &(arr_r[48]);                                   //指针截取

			arr_r2 = conv(arr_r, arr_w22, 31, 31, 48, 5, 5, 48, 128, 1);   //卷积函数

			arr_r = combine(arr_r1, arr_r2, 27, 27, 128);              //合并图像

			arr_r = bias(arr_r, arr_b2, 27, 27, 256, 256);

			arr_r = relu(arr_r, 27, 27, 256);

			arr_r = pool(arr_r, 27, 27, 256, 3, 2);





			//第三卷积层

			arr_r = padding(arr_r, 13, 13, 256, 1);

			arr_r = conv(arr_r, arr_w3, 15, 15, 256, 3, 3, 256, 384, 1);   //卷积函数

			arr_r = bias(arr_r, arr_b3, 13, 13, 384, 384);

			arr_r = relu(arr_r, 13, 13, 384);



			printf("输出第1层卷积结果：\n");





			//第四卷积层

			arr_r = padding(arr_r, 13, 13, 384, 1);

			arr_r1 = conv(arr_r, arr_w41, 15, 15, 192, 3, 3, 192, 192, 1);   //卷积函数

			arr_r = &(arr_r[192]);                                   //指针截取

			arr_r2 = conv(arr_r, arr_w42, 15, 15, 192, 3, 3, 192, 192, 1);   //卷积函数

			arr_r = combine(arr_r1, arr_r2, 13, 13, 192);              //合并图像

			arr_r = bias(arr_r, arr_b4, 13, 13, 384, 384);

			arr_r = relu(arr_r, 13, 13, 384);





			//第五卷积层

			arr_r = padding(arr_r, 13, 13, 384, 1);

			arr_r1 = conv(arr_r, arr_w51, 15, 15, 192, 3, 3, 192, 128, 1);   //卷积函数

			arr_r = &(arr_r[192]);                                   //指针截取

			arr_r2 = conv(arr_r, arr_w52, 15, 15, 192, 3, 3, 192, 128, 1);   //卷积函数

			arr_r = combine(arr_r1, arr_r2, 13, 13, 128);              //合并图像

			arr_r = bias(arr_r, arr_b5, 13, 13, 256, 256);

			arr_r = relu(arr_r, 13, 13, 256);

			arr_r = pool(arr_r, 13, 13, 256, 3, 2);




			//第六全连接层

			arr_j = product_fcimgmatrix(arr_r, 6, 6, 256);

			arr_j = fc(arr_w6, arr_j, arr_b6, 4096, 9216);

			arr_j = fcrelu(arr_j, 4096);


			//第七全连接层

			arr_j = fc(arr_w7, arr_j, arr_b7, 4096, 4096);

			arr_j = fcrelu(arr_j, 4096);

			//第八全连接层



			arr_j = fc(arr_w8, arr_j, arr_b8, 1000, 4096);

			arr_j = fcrelu(arr_j, 1000);


			for (j = 990; j < 1000; j++)
			{
				printf("%5.8f\n", arr_j[j]);
				printf("\n");

			}

			//找出最大的概率输出点并获取它对应的label

			category = max(arr_j);
			printf("category=%d\n", category);
			result = classes[category];
			printf("result=%s\n", result);

			for (i = 0; i < 4; i++)
			{
				if (strcmp(label[16][i], result) == 0)
				{
					correct++;

				}

				printf("correct=%d\n", correct);


			}

			fprintf(fp2, "%d\t", p);
			fprintf(fp2, "%d\t", category);
			fprintf(fp2, "%s\t", result);
			fprintf(fp2, "%d\n", correct);
			free_fcimgarr(&arr_j);



		}

		//fprintf(fp2, "%d\n", correct);

	}




	//匹配输出label与正确label，并行正确率统计


	fclose(fp1);
	fclose(fp2);
	fclose(fp3);
	fclose(fp5);
	fclose(fp6);
	fclose(fp7);
	fclose(fp8);






	//matClose(pmatFile);
	//mxFree(initA);

	// 生成.mat文件  
	/*
	double *outA = new double[M*N];
	for (int i = 0; i < M; i++)
		for (int j = 0; j < N; j++)
			outA[M*j + i] = A[i][j];
	pmatFile = matOpen("A.mat", "w");
	pMxArray = mxCreateDoubleMatrix(M, N, mxREAL);
	mxSetData(pMxArray, outA);
	matPutVariable(pmatFile, "A", pMxArray);
	matClose(pmatFile);

	*/

	return 0;

}
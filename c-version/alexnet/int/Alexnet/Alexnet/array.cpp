#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>

//#include <mat.h>






void dynamic_imgarr(int**** arr, int m, int n, int p)                          //���붯̬����(ͼ��)
{
	int i, j;
	*arr = (int ***)malloc(sizeof(int **) * p);

	for (i = 0; i < p; i++)
	{
		(*arr)[i] = (int **)malloc(sizeof(int*) * m);

		for (j = 0; j < m; j++)
		{
			(*arr)[i][j] = (int *)malloc(sizeof(int) * n);
			memset((*arr)[i][j], 0, sizeof(int) * n);

		}


	}
}






void dynamic_weightarr(int***** arr, int m, int n, int p, int l)                          //���붯̬����(Ȩֵ)
{
	int i, j, k;
	*arr = (int ****)malloc(sizeof(int ***) * l);

	for (i = 0; i < l; i++)
	{
		(*arr)[i] = (int ***)malloc(sizeof(int**) * p);

		for (j = 0; j < p; j++)
		{
			(*arr)[i][j] = (int **)malloc(sizeof(int*) * m);

			for (k = 0; k < m; k++)
			{
				(*arr)[i][j][k] = (int *)malloc(sizeof(int) * n);
				memset((*arr)[i][j][k], 0, sizeof(int) * n);

			}
		}
	}
}




int*** product_imgmatrix(FILE *fp, int m, int n, int p)
{
	int i, x, y;
	int*** arr_a;

	dynamic_imgarr(&arr_a, m, n, p);                               //�������飨ͼ��


	printf("��ȡͼ�����飺\n");

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
				fscanf(fp, "%d", &arr_a[i][x][y]);
			}
		}
	}


	printf("���һ��ͼ�����飺\n");
	for (y = 220; y < n; y++)
	{

		printf("%d", arr_a[2][226][y]);
		printf("\n");
	}



	return arr_a;
}





int**** product_weightmatrix(FILE *fp, int m, int n, int p, int q)  //���ļ�ָ���ǿ��Եģ�������Ϊһ�������ָ�����ϴεĵ���
{
	int i, j, k, l;
	int**** arr_b;

	dynamic_weightarr(&arr_b, m, n, p, q);                                //�������飨Ȩֵ��

	printf("��ȡȨֵ���飺\n");

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
					fscanf(fp, "%d", &arr_b[l][k][j][i]);

				}
			}
		}
	}






	printf("���һ��Ȩֵ���ݣ�\n");

	/*
	for (y = 0; y < n; y++)
	{

	printf("%5f", arr_b[2][2][1][y]);
	printf("\n");
	}

	*/


	return arr_b;
}





int *** product_biasmatrix(FILE *fp, int p)
{
	int i, x, y;
	int*** arr_bias;

	dynamic_imgarr(&arr_bias, 1, 1, p);                                //�������飨ƫ�ƣ�


	printf("��ȡƫ�����飺\n");
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
				fscanf(fp, "%d", &arr_bias[i][x][y]);
			}
		}
	}

	/*
	printf("���һ��ƫ�����ݣ�\n");

	printf("%5f", arr_bias[1][0][0]);
	printf("\n");

	*/

	return arr_bias;
}















/*
void dynamic_biasarr(float**** arr, int p)                          //���붯̬����(ƫ��),�ɲ���ͼ������뷽ʽ
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





void free_imgarr(int**** arr, int m, int p)                                      //�ͷ�ռ�õ��ڴ�(3D),����Ҫ��int n
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

	/*Ϊ���ں���ķֶδ������ܽ���ͼ������ֱ��ȫ��ȡ��ָ���ǣ��������һ���ָ���ǣ�����δ�ͷŵĲ��֣���Ȼ������������ɣ���������ȫ�����ͷŵ����
	free(*arr);
	*arr = 0;

	*/

}



void free_weightarr(int***** arr, int m, int p, int l)                         // //�ͷ�ռ�õ��ڴ�(4D),����Ҫ��int n
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






void dynamic_fcimgarr(int** arr_a, int mimg, int nimg, int pimg)                          //���붯̬����(fcͼ��)�����ڴ���ͷſ���ֱ�����ڲ�д�ͷ�
{

	*arr_a = (int *)malloc(sizeof(int) * (mimg*nimg*pimg));
	memset(*arr_a, 0, sizeof(int) * (mimg*nimg*pimg));


}






void dynamic_fcweightarr(int*** arr, int m, int n)                          //���붯̬��ά����(fcȨֵ)
{
	int i;
	*arr = (int **)malloc(sizeof(int*) * m);

	for (i = 0; i < m; i++)
	{
		(*arr)[i] = (int *)malloc(sizeof(int) * n);
		memset((*arr)[i], 0, sizeof(int) * n);

	}

}




int *product_fcimgmatrix(int ***arr_a, int mimg, int nimg, int pimg)
{
	int i, j, k, l;
	int* arr_fc;

	dynamic_fcimgarr(&arr_fc, mimg, nimg, pimg);                               //�������飨fcͼ��



	printf("��ȡһάͼ�����飺\n");
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
	printf("���һ��ͼ�����飺\n");

	for (i = 0; i < (mimg*nimg*pimg);i++)
	{
	printf("arr_fc=%5f", arr_fc[i]);
	printf("\n");

	}

	*/




	return arr_fc;
}






int **product_fcweightmatrix(FILE *fp, int mw, int nw)
{
	int i, j;
	int** arr_fcweight;

	dynamic_fcweightarr(&arr_fcweight, mw, nw);                               //�������飨fcȨֵ��




	printf("��ȡȨֵ���飺\n");


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
			fscanf(fp, "%d", &arr_fcweight[j][i]);

		}
	}


	/*
	printf("���һ��Ȩֵ���飺\n");
	for (j = 0; j < nw; j++)
	{

	printf("%5f", arr_fcweight[1][j]);
	printf("\n");
	}

	*/

	return arr_fcweight;
}



int *** product_fcbiasmatrix(FILE *fp, int p)
{
	int i, x, y;
	int*** arr_bias;

	dynamic_imgarr(&arr_bias, 1, 1, p);                                //�������飨fcƫ�ƣ�


	printf("��ȡƫ�����飺\n");
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
				fscanf(fp, "%d", &arr_bias[i][x][y]);
			}
		}
	}

	/*
	printf("���һ��ƫ�����ݣ�\n");

	printf("%5f", arr_bias[1][0][0]);
	printf("\n");

	*/

	return arr_bias;
}






void free_fcweightarr(int*** arr, int m)                                      //�ͷ�ռ�õ��ڴ�(2D),����Ҫ��int n
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







void free_fcimgarr(int** arr)                                      //�ͷ�ռ�õ��ڴ�(1D),����Ҫ��int n
{

	free(*arr);
	*arr = 0;

}






//�ϲ����� ���ڽ��ֶδ��������ͼ���ϳ�һ��ͼ���
int ***combine(int ***arr_a, int ***arr_b, int mimg, int nimg, int pimg)
{
	int i, j, k;
	int ***arr_res;
	dynamic_imgarr(&arr_res, mimg, nimg, pimg * 2);

	printf("��ʼ����ͼ���ĺϲ�\n");

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





//�������
int*** conv(int ***arr_a, int ****arr_b, int mimg, int nimg, int pimg, int mw, int nw, int pw, int lw, int str)
{

	int i, j, k, l, p, q;
	int sum;
	int*** arr_res;
	dynamic_imgarr(&arr_res, (mimg - mw) / str + 1, (nimg - nw) / str + 1, lw);

	printf("��ʼ�������\n");

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




//bias����
int*** bias(int ***arr_a, int ***arr_b, int mimg, int nimg, int pimg, int pw)
{

	int i, j, k;

	printf("��ʼbias����\n");

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





//relu����
int ***relu(int ***arr_bias, int mimg, int nimg, int pimg)
{
	int i, j, k;

	printf("��ʼrelu����\n");


	for (k = 0; k < pimg; k++)
	{
		for (i = 0; i<mimg; i++)
		{
			for (j = 0; j <nimg; j++)
			{
				if (arr_bias[k][i][j] <0)
					arr_bias[k][i][j] = 0;
				    arr_bias[k][i][j] = arr_bias[k][i][j]>>10;


			}

		}
	}
	return arr_bias;
}



//fc��relu����

int *fcrelu(int *arr_bias, int mimg)
{
	int i;

	printf("��ʼfc��relu����\n");


	for (i = 0; i<mimg; i++)
	{

		if (arr_bias[i] <0)
			arr_bias[i] = 0;
		    arr_bias[i]=arr_bias[i] >> 10;


	}


	return arr_bias;
}







//�ػ�����
int *** pool(int ***arr_relu, int mimg, int nimg, int pimg, int size, int str)
{
	int i, j, k, p, q;
	int ***arr_pool;
	int ch;
	dynamic_imgarr(&arr_pool, (mimg - size) / str + 1, (nimg - size) / str + 1, pimg);

	printf("��ʼ�ػ�����\n");


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





//padding����
int *** padding(int ***arr_a, int mimg, int nimg, int pimg, int size)
{

	int i, j, k;
	int*** arr_padding;
	dynamic_imgarr(&arr_padding, mimg + size * 2, nimg + size * 2, pimg);

	printf("��ʼpadding����\n");

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






//fc����
//ѭ�����ڲ����Խ���һά����
//����ͷŶ�̬�ڴ�ռ�
//mian�����п��������ν�ָ��
int * fc(int **arr_a, int *arr_b, int ***arr_c, int mw, int nw)
{
	int i, j, l;
	int *arr_res;

	arr_res = (int *)malloc(sizeof(int) * nw);
	memset(arr_res, 0, sizeof(int) * nw);

	printf("��ȡfcbias����\n");



	/*
	if ((fp = fopen("fcbias.txt", "r+")) == NULL)
	{
	printf("Cannot open file!\n");
	exit(1);
	}


	*/


	printf("��ʼfc����\n");

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



//��ȡ1000�������Ԫ��Ӧ��classes�ַ�������
char** product_classesmatrix(FILE *fp)
{
	int i;
	char** classes;


	printf("��ȡclasses���飺\n");

	classes = (char **)malloc(1000 * sizeof(char*));
	for (i = 0; i < 1000; i++)
	{
		classes[i] = (char *)malloc(10 * sizeof(char));
		fscanf(fp, "%s", classes[i]);

	}


	printf("���10��classes��\n");
	for (i = 995; i<1000; i++)
	{

		printf("%s", classes[i]);
		printf("\n");
	}



	return classes;
}




//��ȡ��ȷ�ķ���label�ַ�������
char  ***product_labelmatrix(FILE *fp)
{
	int i, j;
	char ***label;

	printf("��ȡlabel���飺\n");
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


	printf("���10��label��\n");
	for (i = 0; i<18; i++)
	{
		printf("%s", label[i][0]);
		printf("\n")
			;
	}


	return label;

}



//�ҳ�1000�������Ԫ���ֵ�ı��
int max(int *arr_a)
{
	int i, category;
	int a;

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

	int ***arr_i;
	int *arr_j;
	int **arr_k;

	int ***arr_b1;
	int ***arr_b2;
	int ***arr_b3;
	int ***arr_b4;
	int ***arr_b5;
	int ***arr_b6;
	int ***arr_b7;
	int ***arr_b8;

	int ****arr_w1;
	int ****arr_w21;
	int ****arr_w22;
	int ****arr_w3;
	int ****arr_w41;
	int ****arr_w42;
	int ****arr_w51;
	int ****arr_w52;
	int **arr_w6;
	int **arr_w7;
	int **arr_w8;

	int ***arr_r;
	int ***arr_r1;
	int ***arr_r2;

	char *result;
	char **classes;
	char ***label;

	FILE *fp1;
	FILE *fp2;
	FILE *fp3;
	FILE *fp4;
	FILE *fp5;
	FILE *fp6;
	FILE *fp7;
	FILE *fp8;
	FILE *fp9;





	// ��ȡ.mat�ļ�������mat�ļ���Ϊ"initUrban.mat"�����а���"initA"��  
	//int *initA;
	//int *initB;



	if ((fp1 = fopen("image.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp2 = fopen("correct.txt", "w+")) == NULL)      //����ÿ��ͼ�����ȷ��
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp3 = fopen("bias.txt", "r+")) == NULL)
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp4 = fopen("weight.txt", "r+")) == NULL)
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

	if ((fp8 = fopen("image_name.txt", "r+")) == NULL)    //��ȡÿ��ͼ���������
	{
		printf("Cannot open file!\n");
		exit(1);
	}

	if ((fp9 = fopen("fcweight.txt", "r+")) == NULL)    //��ȡÿ��ͼ���������
	{
		printf("Cannot open file!\n");
		exit(1);
	}




	classes = product_classesmatrix(fp6);
	label = product_labelmatrix(fp7);

	/*
	printf("������е���ȷlabel\n");
	for (i = 0; i < 18; i++)
	{
	for (j = 0; j < 4; j++)
	{
	printf("%s\n", label[i][j]);

	}
	}

	*/



	
	arr_w1 = product_weightmatrix(fp4, 11, 11, 3, 96);
	arr_w21 = product_weightmatrix(fp4, 5, 5, 48, 128);
	arr_w22 = product_weightmatrix(fp4, 5, 5, 48, 128);
	arr_w3 = product_weightmatrix(fp4, 3, 3, 256, 384);
	arr_w41 = product_weightmatrix(fp4, 3, 3, 192, 192);
	arr_w42 = product_weightmatrix(fp4, 3, 3, 192, 192);
	arr_w51 = product_weightmatrix(fp4, 3, 3, 192, 128);
	arr_w52 = product_weightmatrix(fp4, 3, 3, 192, 128);
	arr_w6 = product_fcweightmatrix(fp9, 4096, 9216);
	arr_w7 = product_fcweightmatrix(fp9, 4096, 4096);
	arr_w8 = product_fcweightmatrix(fp9, 1000, 4096);




	arr_b1 = product_biasmatrix(fp3, 96);

	arr_b2 = product_biasmatrix(fp3, 256);

	arr_b3 = product_biasmatrix(fp3, 384);

	arr_b4 = product_biasmatrix(fp3, 384);

	arr_b5 = product_biasmatrix(fp3, 256);

	arr_b6 = product_fcbiasmatrix(fp5, 4096);

	arr_b7 = product_fcbiasmatrix(fp5, 4096);

	arr_b8 = product_fcbiasmatrix(fp5, 1000);


	for (image_name = 0; image_name < 18; image_name++)
	{
		fscanf(fp8, "%d", &image_num);
		correct = 0;

		for (p = 0; p < image_num; p++)
		{

			arr_i = product_imgmatrix(fp1, 227, 227, 3);     //�������飨ͼ��


															 //��һ�����
			arr_r = conv(arr_i, arr_w1, 227, 227, 3, 11, 11, 3, 96, 4);   //�������

			arr_r = bias(arr_r, arr_b1, 55, 55, 96, 96);

			arr_r = relu(arr_r, 55, 55, 96);

			arr_r = pool(arr_r, 55, 55, 96, 3, 2);





			//�ڶ������

			arr_r = padding(arr_r, 27, 27, 96, 2);

			arr_r1 = conv(arr_r, arr_w21, 31, 31, 48, 5, 5, 48, 128, 1);   //�������

			arr_r = &(arr_r[48]);                                   //ָ���ȡ

			arr_r2 = conv(arr_r, arr_w22, 31, 31, 48, 5, 5, 48, 128, 1);   //�������

			arr_r = combine(arr_r1, arr_r2, 27, 27, 128);              //�ϲ�ͼ��

			arr_r = bias(arr_r, arr_b2, 27, 27, 256, 256);

			arr_r = relu(arr_r, 27, 27, 256);

			arr_r = pool(arr_r, 27, 27, 256, 3, 2);





			//���������

			arr_r = padding(arr_r, 13, 13, 256, 1);

			arr_r = conv(arr_r, arr_w3, 15, 15, 256, 3, 3, 256, 384, 1);   //�������

			arr_r = bias(arr_r, arr_b3, 13, 13, 384, 384);

			arr_r = relu(arr_r, 13, 13, 384);






			//���ľ����

			arr_r = padding(arr_r, 13, 13, 384, 1);

			arr_r1 = conv(arr_r, arr_w41, 15, 15, 192, 3, 3, 192, 192, 1);   //�������

			arr_r = &(arr_r[192]);                                   //ָ���ȡ

			arr_r2 = conv(arr_r, arr_w42, 15, 15, 192, 3, 3, 192, 192, 1);   //�������

			arr_r = combine(arr_r1, arr_r2, 13, 13, 192);              //�ϲ�ͼ��

			arr_r = bias(arr_r, arr_b4, 13, 13, 384, 384);

			arr_r = relu(arr_r, 13, 13, 384);





			//��������

			arr_r = padding(arr_r, 13, 13, 384, 1);

			arr_r1 = conv(arr_r, arr_w51, 15, 15, 192, 3, 3, 192, 128, 1);   //�������

			arr_r = &(arr_r[192]);                                   //ָ���ȡ

			arr_r2 = conv(arr_r, arr_w52, 15, 15, 192, 3, 3, 192, 128, 1);   //�������

			arr_r = combine(arr_r1, arr_r2, 13, 13, 128);              //�ϲ�ͼ��

			arr_r = bias(arr_r, arr_b5, 13, 13, 256, 256);

			arr_r = relu(arr_r, 13, 13, 256);

			arr_r = pool(arr_r, 13, 13, 256, 3, 2);




			//����ȫ���Ӳ�

			arr_j = product_fcimgmatrix(arr_r, 6, 6, 256);

			arr_j = fc(arr_w6, arr_j, arr_b6, 4096, 9216);

			arr_j = fcrelu(arr_j, 4096);


			//����ȫ���Ӳ�

			arr_j = fc(arr_w7, arr_j, arr_b7, 4096, 4096);

			arr_j = fcrelu(arr_j, 4096);

			//�ڰ�ȫ���Ӳ�



			arr_j = fc(arr_w8, arr_j, arr_b8, 1000, 4096);

			arr_j = fcrelu(arr_j, 1000);


			for (j = 990; j < 1000; j++)
			{
				printf("%d\n", arr_j[j]);
				printf("\n");

			}

			//�ҳ����ĸ�������㲢��ȡ����Ӧ��label

			category = max(arr_j);
			printf("category=%d\n", category);
			result = classes[category];
			printf("result=%s\n", result);

			for (i = 0; i < 4; i++)
			{
				if (strcmp(label[image_name][i], result) == 0)
				{
					correct++;

				}

				printf("correct=%d\n", correct);


			}

			/*
			fprintf(fp2, "%d\t", p);
			fprintf(fp2, "%d\t", category);
			fprintf(fp2, "%s\t", result);
			fprintf(fp2, "%d\n", correct);
			free_fcimgarr(&arr_j);

			*/


		}

		fprintf(fp2, "%d\n", correct);

	}




	//ƥ�����label����ȷlabel��������ȷ��ͳ��


	fclose(fp1);
	fclose(fp2);
	fclose(fp3);
	fclose(fp4);
	fclose(fp5);
	fclose(fp6);
	fclose(fp7);
	fclose(fp8);
	fclose(fp9);






	//matClose(pmatFile);
	//mxFree(initA);

	// ����.mat�ļ�  
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

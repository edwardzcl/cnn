#ifndef __MINST_
#define __MINST_
/*
MINST���ݿ���һ����дͼ�����ݿ⣬����
*/

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <random>
#include <time.h>

typedef struct MinstImg{
	int c;           // ͼ���
	int r;           // ͼ���
	float** ImgData; // ͼ�����ݶ�ά��̬����
}MinstImg;

typedef struct MinstImgArr{
	int ImgNum;        // �洢ͼ�����Ŀ
	MinstImg* ImgPtr;  // �洢ͼ������ָ��
}*ImgArr;              // �洢ͼ�����ݵ�����

typedef struct MinstLabel{
	int l;            // �����ǵĳ�
	float* LabelData; // ����������
}MinstLabel;

typedef struct MinstLabelArr{
	int LabelNum;
	MinstLabel* LabelPtr;
}*LabelArr;              // �洢ͼ���ǵ�����

LabelArr read_Lable(const char* filename); // ����ͼ����

ImgArr read_Img(const char* filename); // ����ͼ��

void save_Img(ImgArr imgarr,char* filedir); // ��ͼ�����ݱ�����ļ�

#endif
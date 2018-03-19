#include<stdio.h>
#include <iostream>
#include <fstream>
#include <math.h>
#include <time.h>
using namespace std;

void softmax(float num[10], float num_out[10]);
float max_2(float a, float b);
float max_4(float a, float b, float c, float d);

void main()
{
	clock_t start, finish;
	double  duration;
	static float im_in[784];
	static float weights_1[500];
	static float biases_1[20];
	static float weights_3[25000];
	static float biases_3[50];
	static float weights_5[400000];
	static float biases_5[500];
	static float weights_7[5000];
	static float biases_7[10];
	float layer_out_1_fm[24][24][20];
	float layer_out_2_fm[12][12][20];
	float layer_out_3_fm[8][8][50];
	float layer_out_4_fm[4][4][50];
	float layer_out_5_fm[500];
	float layer_out_6_fm[500];
	float layer_out_7_fm[10];
	float layer_out_8_fm[10];
	int i;
	int stride = 1;
	int pool_stride = 2;

	/*//begin to read layer6's output
	cout << "reading input image file" << "\n";
	std::ifstream image_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\layer5_output.txt");
	if (image_in.good()) {
		for (int i = 0; i<500; i++) {
			image_in >> layer_out_5_fm[i];
			//cout<<im_in[i]<<"\n";
		}
		cout << "read succeed." << "\n";
		image_in.close();
	}
	else {
		printf("Read layer5_output.txt failed!\n");
	}*/
	start = clock();
	//begin to read image file 
	cout << "reading input image file" << "\n";
	std::ifstream image_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\0_number_255.txt");
	if (image_in.good()) {
		for (int i = 0; i<784; i++) {
			image_in >> im_in[i];
			//cout<<im_in[i]<<"\n";
		}
		cout << "read succeed." << "\n";
		image_in.close();
	}
	else {
		printf("Read 0_number_255.txt failed!\n");
	}

	cout << "reading layer1's weights file" << "\n";
	std::ifstream weights_1_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\weights_1.txt");
	if (weights_1_in.good()) {
		for (int i = 0; i<500; i++) {
			weights_1_in >> weights_1[i];
		}
		cout << "read succeed." << "\n";
		weights_1_in.close();
	}
	else {
		printf("Read weights_1.txt failed!\n");
	}

	//begin to read layer1's bias
	cout << "reading layer1's biases file" << "\n";
	std::ifstream biases_1_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\biases_1.txt");
	if (biases_1_in.good()) {
		for (int i = 0; i<20; i++) {
			biases_1_in >> biases_1[i];
		}
		cout << "read succeed." << "\n";
		biases_1_in.close();
	}
	else {
		printf("Read biases_1.txt failed!\n");
	}

	//begin to read layer3's weights 
	cout << "reading layer3's weights file" << "\n";
	std::ifstream weights_3_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\weights_3.txt");
	if (weights_3_in.good()) {
		for (int i = 0; i<25000; i++) {
			weights_3_in >> weights_3[i];
		}
		cout << "read succeed." << "\n";
		weights_3_in.close();
	}
	else {
		printf("Read weights_3.txt failed!\n");
	}

	//begin to read layer3's bias
	cout << "reading layer3's biases file" << "\n";
	std::ifstream biases_3_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\biases_3.txt");
	if (biases_3_in.good()) {
		for (int i = 0; i<50; i++) {
			biases_3_in >> biases_3[i];
		}
		cout << "read succeed." << "\n";
		biases_3_in.close();
	}
	else {
		printf("Read biases_3.txt failed!\n");
	}

	//begin to read layer5's weights 
	cout << "reading layer5's weights file" << "\n";
	std::ifstream weights_5_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\weights_5.txt");
	if (weights_5_in.good()) {
		for (int i = 0; i<400000; i++) {
			weights_5_in >> weights_5[i];
		}
		cout << "read succeed." << "\n";
		weights_5_in.close();
	}
	else {
		printf("Read weights_5.txt failed!\n");
	}

	//begin to read layer5's bias
	cout << "reading layer5's biases file" << "\n";
	std::ifstream biases_5_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\biases_5.txt");
	if (biases_5_in.good()) {
		for (int i = 0; i<500; i++) {
			biases_5_in >> biases_5[i];
		}
		cout << "read succeed." << "\n";
		biases_5_in.close();
	}
	else {
		printf("Read biases_7.txt failed!\n");
	}

	//begin to read layer7's weights 
	cout << "reading layer7's weights file" << "\n";
	std::ifstream weights_7_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\weights_7.txt");
	if (weights_7_in.good()) {
		for (int i = 0; i<5000; i++) {
			weights_7_in >> weights_7[i];
		}
		cout << "read succeed." << "\n";
		weights_7_in.close();
	}
	else {
		printf("Read weights_7.txt failed!\n");
	}

	//begin to read layer7's bias
	cout << "reading layer7's biases file" << "\n";
	std::ifstream biases_7_in("D:\\IMSLAB\\VivadoHLSProject\\CNN_FPGA-master\\cnn_hls_correct\\mnist_cnn\\biases_7.txt");
	if (biases_7_in.good()) {
		for (int i = 0; i<10; i++) {
			biases_7_in >> biases_7[i];
		}
		cout << "read succeed." << "\n";
		biases_7_in.close();
	}
	else {
		printf("Read biases_7.txt failed!\n");
	}

	/*for (int i = 0; i < 20; i++)
	printf("%.20f\n", biases_1[i]);*/

	

	//1st layer, convolution1
	  //initialization
	for (int i = 0; i<24; i++) {
		for (int j = 0; j<24; j++) {
			for (int k = 0; k<20; k++) {
				//layer_out_1_fm[i][j][k] = biases_1[k];
				layer_out_1_fm[i][j][k] = 0;
				//printf("i%dj%dk%d:%.20f\n", i, j, k, layer_out_1_fm[i][j][k]);
			}
		}
	}
	//convolution computation
	for (int out_dep = 0; out_dep<20; out_dep++) {
		for (int row = 0; row<24; row++) {
			for (int col = 0; col<24; col++) {
				for (int in_dep = 0; in_dep<1; in_dep++) {
					for (int i = 0; i<5; i++) {
						for (int j = 0; j<5; j++) {
							//float weight_temp = weights_1[i * 5 + j + in_dep * 25 + out_dep * 25 * 1];
							//float input_temp = im_in[((stride*row + i) * 28 + (stride*col + j)) * 1 + in_dep];
							//layer_out_1_fm[row][col][out_dep] +=
								//weight_temp * input_temp;
								//weights_1[((i * 5 + j) * 1 + in_dep) * 20 + out_dep] * im_in[((stride*row + i) * 28 + (stride*col + j)) * 1 + in_dep];
							layer_out_1_fm[row][col][out_dep] +=
								weights_1[i*5+j+in_dep*25+ out_dep*25*1]*im_in[((stride*row + i) * 28 + (stride*col + j)) * 1 + in_dep];						
						}
					}
					//printf("i%dj%dk%d:%.20f\n", row, col, out_dep, layer_out_1_fm[row][col][out_dep]);
				}
			}
		}
	} //end of 1st layer:convolutiong_1
	
	//2nd layer, maxpooling_1
	for (int out_dep = 0; out_dep<20; out_dep++) {
		for (int row = 0; row<12; row++) {
			for (int col = 0; col<12; col++) {
				layer_out_2_fm[row][col][out_dep] = max_4(
					layer_out_1_fm[pool_stride*row + 0][pool_stride*col + 0][out_dep],
					layer_out_1_fm[pool_stride*row + 0][pool_stride*col + 1][out_dep],
					layer_out_1_fm[pool_stride*row + 1][pool_stride*col + 0][out_dep],
					layer_out_1_fm[pool_stride*row + 1][pool_stride*col + 1][out_dep]);
			}
		}
	}//end of 2nd layer:maxpooling_1

	//3rd layer convolution 2
	//initialization
	for (int i = 0; i<8; i++) {
		for (int j = 0; j<8; j++) {
			for (int k = 0; k<50; k++) {
				layer_out_3_fm[i][j][k] = biases_3[k];
				//printf("i%dj%dk%d:%.20f\n", i, j, k, layer_out_3_fm[i][j][k]);
			}
		}
	}
	//convolution computation
	for (int out_dep = 0; out_dep<50; out_dep++) {
		for (int row = 0; row<8; row++) {
			for (int col = 0; col<8; col++) {
				for (int in_dep = 0; in_dep<20; in_dep++) {
					for (int i = 0; i<5; i++) {
						for (int j = 0; j<5; j++) {
							layer_out_3_fm[row][col][out_dep] +=
								weights_3[i*5+j+in_dep* 25+out_dep*20*25] * layer_out_2_fm[stride*row + i][stride*col + j][in_dep];
						}
					}
				}
				//printf("i%dj%dk%d:%.20f\n", row, col, out_dep, layer_out_3_fm[row][col][out_dep]);
			}
		}
	} //end of 3rd layer:conv 2

	//4th layer, maxpooling
	for (int out_dep = 0; out_dep<50; out_dep++){
		for (int row = 0; row<4; row++) {
			for (int col = 0; col<4; col++) {
				layer_out_4_fm[row][col][out_dep] = max_4(
					layer_out_3_fm[pool_stride*row + 0][pool_stride*col + 0][out_dep],
					layer_out_3_fm[pool_stride*row + 0][pool_stride*col + 1][out_dep],
					layer_out_3_fm[pool_stride*row + 1][pool_stride*col + 0][out_dep],
					layer_out_3_fm[pool_stride*row + 1][pool_stride*col + 1][out_dep]);
				//printf("i%dj%dk%d:%.20f\n", row, col, out_dep, layer_out_4_fm[row][col][out_dep]);
			}
		}
	} //end of 4th layer:maxpooling_2

	//5th layer, convolution
	  //5th layer,biases initialization
	for (int i = 0; i<500; i++) {
		layer_out_5_fm[i] = biases_5[i];
		//printf("i%d:%.20f\n", i,  layer_out_5_fm[i]);
	} 
	  //5th layer, convolution computation
	for (int out_dep = 0; out_dep<500; out_dep++) {
		//for (int row = 0; row < 4;row++) {
			//for (int col = 0; col < 4;col++) {
				for (int in_dep = 0; in_dep < 50; in_dep++) {
					for (int i = 0; i < 4;i++) {
						for(int j = 0;j < 4;j++){
							layer_out_5_fm[out_dep] +=
								layer_out_4_fm[i][j][in_dep] * weights_5[i * 4 + j + in_dep * 16 + out_dep * 50 * 16];
					    }
				   // }
				//}			
			}		
		}
		//printf("i%d:%.20f\n", out_dep, layer_out_5_fm[out_dep]);
	}//end of 5th layer

	//initialize 6th layer 
	for (int i = 0; i<500; i++) {
		if (layer_out_5_fm[i]<0)
			layer_out_6_fm[i] = 0;
		else
			layer_out_6_fm[i] = layer_out_5_fm[i];
	}//end of 6th layer, RELU activation

	//initialize 7th layer conv
	for (int i = 0; i<10; i++) {
		layer_out_7_fm[i] = biases_7[i];
		for (int j = 0; j<500; j++) {
			layer_out_7_fm[i] += layer_out_6_fm[j] * weights_7[i * 500 + j];
		}
	}//end of 7th layer£¬ convolution

	//8th layer
	softmax(layer_out_7_fm, layer_out_8_fm);//end of 8th layer softmax

	printf("The result of the softmax is\n");

	for (i = 0; i < 10 ; i++) {
		printf("num%d:%.20f\n", i, layer_out_8_fm[i]);
	}

	finish = clock();
	duration = (double)(finish - start) / CLOCKS_PER_SEC;
	printf("%f seconds\n", duration);

}

float max_2(float a, float b) {
	if (a>b)
		return a;
	else
		return b;
}

float max_4(float a, float b, float c, float d) {
	float temp_1, temp_2;
	temp_1 = max_2(a, b);
	temp_2 = max_2(c, d);
	return max_2(temp_1, temp_2);
}

void softmax(float num[10], float num_out[10]) {
	float sum = 0;
	float e_num[10];
	for (int i = 0; i<10; i++) {
		e_num[i] = expf(num[i]);
		sum += e_num[i];
	}
	
	for (int i = 0; i<10; i++) {
		num_out[i] = e_num[i] / sum;
	}
}
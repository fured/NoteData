#include <stdio.h>
#include "JNI_test.h"

JNIEXPORT void JNICALL Java_JNI_1test_testHello(JNIEnv *env, jobject obj){
	printf("the first JNC program!");
	return;
}

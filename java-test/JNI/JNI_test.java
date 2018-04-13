public class JNI_test{
	public native void testHello();

	public static void main(String[] args){
		System.out.println("welcome to JNI!");
		System.out.println(System.getProperty("java.library.path"));
		System.setProperty("java.library.path",System.getProperty("java.library.path")+":/home/fuli/NoteData/java-test/JNI");
		System.out.println(System.getProperty("java.library.path"));
		//System.loadLibrary("libtestJNI");
		System.load("/home/fuli/NoteData/java-test/JNI/libtestJNI.so");
		JNI_test jnitest = new JNI_test();
		jnitest.testHello();
	}
}

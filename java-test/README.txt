javac first.java #产生first.class字节码文件
java first #搜索first类，并执行主（main）方法
搜索类的路径，默认是CLASSPATH所指的路径，所以为了可以搜到我们自己写的first类
需要将当前目录添加到CLASSPATH
CLSSPATH=$CLASSPATH:.     .表示当前路径
或者直接把first.class字节码文件，放在jdk/lib下，不限麻烦的话。然后就可以在任何地方执行
java first

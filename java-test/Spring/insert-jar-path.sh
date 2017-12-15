#将/home/ts/NoteData/spring-framework-3.2.0.RELEASE/libs/下的所有jar包，加到CLASSPATH路径
for i in /home/ts/NoteData/spring-framework-3.2.0.RELEASE/libs/*.jar
do
	echo $i
	CLASSPATH=$CLASSPATH:$i
done

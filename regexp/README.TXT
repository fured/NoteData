Regular Expression introdution
1.Composition
	(1).Ordinary character 
		1>.NOt print character
			\cx	匹配由x指明的控制字符。如：\cM 匹配一个Control-M 或回车符
			\f	匹配一个换页符
			\n	匹配一个换行符
			\r	匹配一个回车符
			\s	匹配任何空白字符，如：空格、tab、换页等
			\S	匹配任何非空白字符
			\t	匹配一个制表符
			\v	匹配一个垂直制表符
		2>.Print charactrt
			0-9 a-z A-Z punctuation character and so on
	(2).Special character(Metacharacters)
		$	匹配字符串的结尾位置，自身\$
		()	标记一个子表达式的开始和结尾，自身\( \)
		*	匹配前面的子表达式0次或多次
		+	匹配前面的子表达式1次或多次
		.	匹配除换行符\n之外的任何单字符
		[	标记一个中括号表达式的开始
		?	匹配前面的子表达式0次或1次
		?	当该字符紧跟在任何一个其他限定符后面时，匹配模式是非贪婪的。非贪婪模式尽可能少地匹配所搜索的字符串，默认是贪婪模式，尽可能多地匹配
		\	将下一个字符标记为特殊字符或原义字符、或向后引用、或八进制转义符
		^	匹配输入字符串的开始位置
		{	标记限定符表达式的开始
		|	指明两项之间的一个选择
		(pattern)	匹配 pattern 并获取这一匹配。所获取的匹配可以从产生的 Matches 集合得到，在VBScript 中使用 SubMatches 集合，在JScript 中则使用 $0…$9 属性。要匹配圆括号字符，请使用 '\(' 或 '\)'。
		(?:pattern)	匹配 pattern 但不获取匹配结果，也就是说这是一个非获取匹配，不进行存储供以后使用
		(?=pattern)	正向肯定预查（look ahead positive assert），在任何匹配pattern的字符串开始处匹配查找字符串
		(?!pattern)	正向否定预查(negative assert)，在任何不匹配pattern的字符串开始处匹配查找字符串
		(?<=pattern)	反向(look behind)肯定预查，与正向肯定预查类似，只是方向相反
		(?<!pattern)	反向否定预查，与正向否定预查类似，只是方向相反。
	(3).组织普通字符和特殊字符的关系
		1>.限定符
			*	匹配前面的子表达式0次或多次
			+	匹配前面的子表达式1次或多次
			?	匹配前面的子表达式0次或1次
			{n}	匹配确定的n次
			{n,}	至少匹配n次
			{n,m}	最好匹配n次，最多匹配m次
		2>.定位符
			^   匹配输入字符串的开始位置
			$   匹配字符串的结尾位置，自身\$
			\b	匹配一个字边界，即字与空格间的位置
			\B	非字边界匹配
		3>.选择
			用（）将所有选项括起来，相邻的选择项之间用｜分隔。
			但（）的副作用是，相关的匹配会被缓存，可用?:放在第一个选项前来消除这种副作用。
			?:	非捕获元之一
			?=	非捕获元，正向预查，在任何开始匹配（）中的正则表达式模式的位置来匹配搜索字符串
			?!	非捕获元，反向预查，在任何开始不匹配该正则表达式模式的位置来匹配搜索字符串
		4>.反向引用
			对一个正则表达式模式或部分模式两边添加圆括号将导致相关匹配存储到一个临时缓冲区中，所捕获的每个子匹配都按照在正则表达式模式中从左到右出现的顺序存储。缓冲区编号从 1 开始，最多可存储 99 个捕获的子表达式。每个缓冲区都可以使用 \n 访问，其中 n 为一个标识特定缓冲区的一位或两位十进制数。
			可以使用非捕获元字符 ?:、?= 或 ?! 来重写捕获，忽略对相关匹配的保存。 
2.优先级
	\	转义符
	() []
	*, +, ?, {n}, {n,}, {n,m} 	限定符
	^, $, \任何元字符、任何字符
	| 替换、“或”操作
3.匹配规则
	(1).基本模式匹配
		模式，是正则表达式最基本的元素，它是一组描述字符串特征的字符，模式可以很简单也可以很复杂
	(2).字符族
		使用［］来表示一个字符族，用来匹配字符族中的某一个字符。
		eg:[a-z]	匹配所有的小写字母
		   [0-9]	匹配所有的数字
		   [0-9\.\-]	匹配所有的数字、句号、减号
	(3).确定重复出现
		使用｛｝来表示字符或表达式重复出现的次数。

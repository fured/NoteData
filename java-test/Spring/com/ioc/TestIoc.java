package com.ioc;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.env.EnvironmentCapable;
public class TestIoc{
	public static void main(String[] args){
		TestIoc cc = new TestIoc();
//		cc.testUser();
		cc.testDemo1();
	}

	public void testUser(){
		ApplicationContext context = new ClassPathXmlApplicationContext("bean1.xml");
		User user = (User) context.getBean("user");
		System.out.println(user);
		user.add();
	}

	public void testDemo1(){
		ApplicationContext context = new ClassPathXmlApplicationContext("bean1.xml");
	//	ApplicationContext context1 = new ClassPathXmlApplicationContext("bean1.xml");
		Demo1 demo1 = (Demo1) context.getBean("demo1");
		System.out.println(demo1);
		demo1.out();
	}
}

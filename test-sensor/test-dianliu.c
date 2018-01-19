#include<stdio.h>
#include<stdlib.h>
#include <modbus.h>

int main(void)
{
	modbus_t *mb;
	uint16_t tab_reg[32] = {0};
	mb = modbus_new_rtu("/dev/ttyUSB0",9600,'N',8,1);
	modbus_set_slave(mb,1);//set slave address
	
	modbus_connect(mb);
	
	struct timeval t;
	t.tv_sec = 0;
	t.tv_usec = 1000000;
	modbus_set_response_timeout(mb,t.tv_sec,t.tv_usec);
	
//	while(1){	
//		modbus_write_register(mb,87,2);
		//sleep(3);
		int regs = modbus_read_registers(mb,0,1,tab_reg);	
		
		printf("number:%d,%d\n",regs,tab_reg[0]);
//		sleep(5);	
//	}
	modbus_close(mb);
	modbus_free(mb);
	
	return 0;
}


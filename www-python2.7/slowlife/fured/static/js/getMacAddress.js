function MacInfo(){
	console.log("Get Mac Address!")
	var locator =new ActiveXObject ("WbemScripting.SWbemLocator");
	var service = locator.ConnectServer(".");
	var properties = service.ExecQuery("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled =True");
	var e =new Enumerator (properties);
	{
		var p = e.item();
		var mac = p.MACAddress;
		alert(mac)
	}
}
MacInfo();

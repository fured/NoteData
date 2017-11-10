import asyncio,functools,time
from aiohttp import web
from table import User,Blog,Comment,next_id

def get(path):
	def decorator(func):
		@functools.wraps(func)
		def wrapper(*args,**kw):
			return func(*args,**kw)
		wrapper.__method__ = "GET"
		wrapper.__route__ = path
		return wrapper
	return decorator

def post(path):
	def decorator(func):
		@functools.wraps(func)
		def wrapper(*args,**kw):
			return func(*args,**kw)
		wrapper.__method__ = "POST"
		wrapper.__route__ = path
		return wrapper
	return decorator


@get("/")
def index(request):
	a = dir(request)	
	n = 0
	with open("/home/ts/file.txt","w") as f:
		for bb in a:
			a = "%s = %s\n" % (bb,getattr(a,bb,None))
			f.write(a)
			n = n+1
	print(n)
	print(request.content_type)
	print(request._payload)
	params = request.json()
	a = isinstance(params,dict)
	print(a)
	a = yield from User.findAll()
	return {"__template__":"index.html","users":a}

@get("/blog")
def blog(request):
	summary = "you are so beautiful in white.boom,boom,boom.I don't know.what happen!"
	blogs = [
			Blog(id = "1",name = "Test" , summary = summary,created_at = time.time()-120),
			Blog(id = "2",name = "Bob" , summary = summary,created_at = time.time()-3600),
			Blog(id = "3",name = "Tom" , summary = summary,created_at = time.time()-7200),	
		]
	return {"__template__":"blogs.html","blogs":blogs}

@get("/first")
def first(request):
	a = dir(request)
	n = 0 
	for bb in a:
		print(bb,end=", ")
		n = n+ 1
	print(n)
	return web.Response(body = b"<h1>First</h1>",content_type = "text/html")

@get("/register")
def register(request):
	return {"__template__":"register.html"}

@post("/api/users")
def api_register_user(request):
	a = dir(request)
	n = 0
	with open("/home/ts/filepost.txt","w") as f:
		for bb in a:
			a = "%s = %s\n" % (bb,getattr(request,bb,None))
			f.write(a)
			n = n+1
	print(n)
	print(request.content_type)
	#a = isinstance(request.json(),dict)
	#print(a)
	#print(type(request))
	#print(type(request._message))
	print(request._payload)
	print(type(request._payload))
	#print(request._payload.readline()) 
	#g = request._payload.readline()
	g = dir(request._payload)
	for n in g:
		print("start...")
		print("%s:%s" % (n,getattr(request._payload,n,None)))
	#print(request.)
	#print(request.payload.get("name",None))
'''	

	if not name or not name.strip():
		return "name is error!"
	if not email or not _RE_EMAIL.match(email):
		return "email is error!"
	if not passwd or not _RE_EMAIL.match(passwd):
		return "passwd is error!"
	users = yield from User.findAll("email = ?",[email])
	if len(users) >0:
		return "register failed: email is already in use"
	uid = next_id()
	sha1_passwd = "%s:%s" % (uid,passwd)
	user = User(id = uid,name = name.strip(),email = email,passwd = hashlib.sha1(sha1_passwd.encode("utf-8")).hexdigest(),image = "http://www.gravatar.com/avatar/%s?d=mm&s=120" % hashlib.md5(email.encode("utf-8")).hexdigest())
	yield from user.save()
'''

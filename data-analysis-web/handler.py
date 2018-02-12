import asyncio,functools,time,json,re,pdb,hashlib,time,logging,markdown2,base64
from aiohttp import web
from table import User,Blog,Comment,next_id

COOKIE_NAME = "oncesession"
_COOKIE_KEY = "Awesome"

def usercookie(user,max_age):
	#generate cookie string by :id-expires-sha1
	expires = str(int(time.time() + max_age))
	s = '%s-%s-%s-%s' % (user.id, user.password, expires, _COOKIE_KEY)
	L = [user.id, expires, hashlib.sha1(s.encode('utf-8')).hexdigest()]
	return "-".join(L)

def cookieuser(cookie_str):
	#parse cookie and load user if cookie is valid
	if not cookie_str:
		return None
	try:
		L = cookie_str.split("-")
		if len(L) != 3:
			return None
		uid,expires,sha1 = L
		if int(expires) < time.time():
			return None
		user = yield from User.find(uid)
		if user is None:
			return None
		s = "%s-%s-%s-%s" % (uid,user.password,expires,_COOKIE_KEY)
		if sha1 != hashlib.sha1(s.encode("utf-8")).hexdigest():
			print("invalid sha1")
			return None
		user.passwd = "******"
		return user
	except Exception as e:
		logging.exception(e)
		return None
def text2html(text):
	lines = map(lambda s: '<p>%s</p>' % s.replace('&', '&amp;').replace('<', '&lt;').replace('>','&gt;'), filter(lambda s: s.strip() != '', text.split('\n')))
	return "".join(lines)

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


@get("/blog")
def index(request):
	a = dir(request)	
	n = 0
#	with open("/home/ts/file.txt","w") as f:
#		for bb in a:
#			a = "%s = %s\n" % (bb,getattr(a,bb,None))
#			f.write(a)
#			n = n+1
#	print(n)
#	print(request.content_type)
#	print(request._payload)
#	params = request.json()
#	a = isinstance(params,dict)
#	print(a)
#	user = User(name = "ddd",email = "ddd@example.com",passwd = "123qwe",image = "qwewrffsaf")
#	yield from user.save()
	a = yield from User.findAll()
	#pdb.set_trace()
	return {"__template__":"index.html","users":a}

@get("/")
def blog(request):
	'''
	summary = "you are so beautiful in white.boom,boom,boom.I don't know.what happen!"
	blogs = [
			Blog(id = "1",name = "Test" , summary = summary,created_at = time.time()-120),
			Blog(id = "2",name = "Bob" , summary = summary,created_at = time.time()-3600),
			Blog(id = "3",name = "Tom" , summary = summary,created_at = time.time()-7200),	
		]
	'''
#	pdb.set_trace()
	blogs = yield from Blog.findAll()
#	print("===================")
#	print(blogs)
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

@get("/image")
def get_image(request):
	return {"__template__":"images.html"}
@get("/register")
def register(request):
	return {"__template__":"register.html"}

@get("/signin")
def signin(request):
	return {"__template__":"signin.html"}

@get("/signout")
def signout(request):
	referer = request.headers.get('Referer')
	r = web.HTTPFound(referer or '/')
	r.set_cookie(COOKIE_NAME, '-deleted-', max_age=0, httponly=True) 
	logging.info('user signed out.')
	return r 

@get("/manage/blogs/create")
def manage_create_blog(request):
	return {"__template__":"manage_blog_edit.html","id":"","action":"/api/blogs"}




_RE_EMAIL = re.compile(r'^[a-z0-9\.\-\_]+\@[a-z0-9\-\_]+(\.[a-z0-9\-\_]+){1,4}$')
_RE_SHA1 = re.compile(r'^[0-9a-f]{40}$') 

@post("/api/users")
@asyncio.coroutine
def api_register_user(request):
#	pdb.set_trace()
	body = yield from request.text()
	kw = json.loads(body)
	print(kw["name"],kw["email"],kw["passwd"])	
#	pdb.set_trace()
	strs = kw["image"]
	tup = re.findall("data:image/(png|jpeg);base64,(.*)",strs)
	imgdata = base64.b64decode(tup[0][1])
	filename = kw["name"] +"."+tup[0][0]
	imagepath = "static/img/"+filename
	with open(imagepath,"wb") as file:
		file.write(imgdata)
	
	if not kw["name"] or not kw["name"].strip():
		return "name is error!"
	if not kw["email"] or not _RE_EMAIL.match(kw["email"]):
		return "email is error!"
	if not kw["passwd"] or not _RE_SHA1.match(kw["passwd"]):
		return "passwd is error!"
	users = yield from User.findAll("email = ?",[kw["email"]])
	if len(users) >0:
		return "register failed: email is already in use"
	uid = next_id()
	sha1_passwd = "%s:%s" % (uid,kw["passwd"])
	user = User(id = uid,name = kw["name"].strip(),email = kw["email"],password = hashlib.sha1(sha1_passwd.encode("utf-8")).hexdigest(),image ="/"+imagepath)
	yield from user.save()
#	pdb.set_trace()
	#make session cookie
	r = web.Response()
	r.set_cookie(COOKIE_NAME,usercookie(user,864000),max_age = 86400,httponly=True)
	user.passwd = "******"
	r.content_type = "application/json"
	r.body = json.dumps(user,ensure_ascii=False).encode("utf-8")
	return r

@post("/api/authenticate")
@asyncio.coroutine
def authenticate(request):
	body = yield from request.text()
	print(body)
#	pdb.set_trace()
	kw = json.loads(body)
	if not kw["email"]:
		return "invalid email!"
	if not kw["passwd"]:
		return "invalid password!"
	users = yield from User.findAll("email = ?",[kw["email"]])
	if len(users) == 0:
		return "email not exist"
	user = users[0]
	#check passwd
	sha1 = hashlib.sha1()
	sha1.update(user.id.encode("utf-8"))
	sha1.update(b":")
	sha1.update(kw["passwd"].encode("utf-8"))
	if user.password != sha1.hexdigest():
		return "invalid password"
	#authenicate ok,set cookie
	r = web.Response()
	r.set_cookie(COOKIE_NAME,usercookie(user,864000),max_age = 86400,httponly=True)
	user.passwd = "******"
	r.content_type = "application/json"
	r.body = json.dumps(user,ensure_ascii=False).encode("utf-8")
	return r

@get("/api/blog/{id}")
@asyncio.coroutine
def api_get_blog(request):
#	pdb.set_trace()
	id = request.__blogid__
	#blog = yield from Blog.find(id)
	blogs = yield from Blog.findAll('user_id=?', [id], orderBy='created_at desc')
	#for c in blogs:
	#	c.html_content = text2html(c.content)
	#blog.html_content = markdown2.markdown(.content)
	#print(blogs[0].get("user_image"))
	#print(blogs[0].get("user_name"))
	return {"__template__":"user_blogs.html","blogs":blogs}
#,"comments":comments}

@post('/api/blogs/{id}/comments')
def api_create_comment(request):
	body = yield from request.text()
	kw = json.loads(body)
	user = request.__user__
	if user is None:
		print('Please signin first.')
	if not kw["content"] or not kw["content"].strip():
		print('please input content')
	blog = yield from Blog.find(request.__blogid__)
	if blog is None:
		print('not the Blog')
	comment = Comment(blog_id=blog.id, user_id=user.id, user_name=user.name, user_image=user.image, content=kw["content"].strip())
	yield from comment.save()
	return comment


@get("/blog/{id}")
@asyncio.coroutine
def get_blog(request):
	id = request.__blogid__
	blog = yield from Blog.find(id)
	comments= yield from Comment.findAll("blog_id=?",[id],orderBy="created_at desc")
	return {"__template__":"blog.html","blog":blog,"comments":comments}

@post("/api/blogs")
@asyncio.coroutine
def api_create_blog(request):
	if request.__user__ is None: 
#or not request.__user__.admin:
		return "please firstly signin!"
	body = yield from request.text()
	kw = json.loads(body)	
	if not kw["name"] or not kw["name"].strip():
		return "name is error!"
	if not kw["summary"] or not kw["summary"].strip():
		return "summary is error!"
	if not kw["content"] or not kw["content"].strip():
		return "conent is error!"
	blog = Blog(user_id = request.__user__.id,user_name = request.__user__.name,user_image = request.__user__.image,name = kw["name"].strip(),summary = kw["summary"].strip(),content = kw["content"].strip())
	yield from blog.save()
	print(request.__user__.id)
	return blog

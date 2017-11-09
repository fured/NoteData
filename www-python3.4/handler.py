import asyncio,functools,time
from aiohttp import web
from table import User,Blog,Comment

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
@asyncio.coroutine
def index(request):
	a = yield from User.findAll()
	return {"__template__":"index.html","users":a}
@get("/blog")
@asyncio.coroutine
def blog(request):
	summary = "you are so beautiful in white.boom,boom,boom.I don't know.what happen!"
	blogs = [
			Blog(id = "1",name = "Test" , summary = summary,created_at = time.time()-120),
			Blog(id = "2",name = "Bob" , summary = summary,created_at = time.time()-3600),
			Blog(id = "3",name = "Tom" , summary = summary,created_at = time.time()-7200),	
		]
	return {"__template__":"blogs.html","blogs":blogs}
@get("/first")
@asyncio.coroutine
def first(request):
	return web.Response(body = b"<h1>First</h1>",content_type = "text/html")

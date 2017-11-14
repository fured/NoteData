import asyncio,logging
from aiohttp import web
from table import User
import oorm
import os,json
import pdb
from handler import COOKIE_NAME,cookieuser
from jinja2 import Environment,FileSystemLoader
def init_jinja2(app,**kw):
	print("init jinja2...")
	options = dict(
		autoescape = kw.get("autoescape",True),
		block_start_string = kw.get("block_start_string","{%"),
		block_end_string = kw.get("block_end_string","%}"),
		variable_start_string = kw.get("variable_start_string","{{"),
		variable_end_string = kw.get("variable_end_string","}}"),
		auto_reload = kw.get("auto_reload",True)
	)
	path = kw.get("path",None)
	if path is None:
		path = os.path.join(os.path.dirname(os.path.abspath(__file__)),"templates")
	print("template path :%s" % path)
	env = Environment(loader = FileSystemLoader(path),**options)
	filters = kw.get("filters",None)
	app["__templating__"] = env

@asyncio.coroutine
def logger_factory(app,handler):
	@asyncio.coroutine
	def logger(request):
#		pdb.set_trace()
		print("Request:Method:%s Path:%s URL:%s" % (request.method,request.path,request.url))
		if request.path.startswith("/api/blog/") and len(request.path) > 20:
			request.__blogid__ = request.path[10:]
		return (yield from handler(request))
	return logger

@asyncio.coroutine
def auth_factory(app,handler):
	@asyncio.coroutine
	def auth(request):
#		pdb.set_trace()
		print("check user:%s %s" % (request.method,request.path))
		request.__user__ = None
		cookie_str = request.cookies.get(COOKIE_NAME)
		if cookie_str:
			user = yield from cookieuser(cookie_str)
			if user:
				print("set current user:%s" % user.email)
				request.__user__ = user
		if request.path.startswith('/manage/') and (request.__user__ is None or not request.__user__.admin):
			return web.HTTPFound("/signin")
		return (yield from handler(request))
	return auth

@asyncio.coroutine
def response_factory(app,handler):
	@asyncio.coroutine
	def response(request):
#		pdb.set_trace()
		print("Response handler...")
		r = yield from handler(request)
#		pdb.set_trace()
		if isinstance(r,web.StreamResponse):
			return r
		if isinstance(r,bytes):
			resp = web.Response(body = r)
			resp.content_type = "application/octet-stream"
			return resp
		if isinstance(r,str):
			if r.startswith("redirect:"):
				return web.HTTPFound(r[9:])
			resp = web.Response(body = r.encode("utf-8"))
			resp.content_type = "text/html;charset=utf-8"
			return resp
		if isinstance(r,dict):
			#pdb.set_trace()
			template = r.get("__template__")
			if template is None:
				resp = web.Response(body = json.dumps(r,ensure_ascii = False,default = lambda o : o.__dict__).encode("utf-8"))
				resp.content_type = "application/json;charset=utf-8"
				return resp
			else:
				r["__user__"] = request.__user__
				resp = web.Response(body= app["__templating__"].get_template(template).render(**r).encode("utf-8"))
				resp.content_type = "text/html;charset=utf-8"
				return resp
		if isinstance(r,int) and r >=100 and r < 600:
			return web.Response(r)
		if isinstance(r,tuple) and len(r) == 2:
			t,m = r
			if isinstance(r,int) and t >=100 and t < 600:
				return web.Response(t.str(m))
		#default return
		resp = web.Response(body=str(r).encode("utf-8"))
		resp.content_type = "text/plain;charset=utf-8"
		return resp
	return response
			
def AddRoute(app,module_name):
	mod = __import__(module_name,globals(),locals())
	for attr in dir(mod):
		if attr.startswith("_"):
			continue
		fn = getattr(mod,attr)
		if callable(fn):
			method = getattr(fn,"__method__",None)
			path = getattr(fn,"__route__",None)
			if method and path:
#				pdb.set_trace()
				app.router.add_route(method,path,fn)	

@asyncio.coroutine
def init(loop):
	print("1")
	yield from oorm.create_pool(loop,user = "www-data",password = "www-data",db = "awesome")
#	a = yield from User.findAll()
#	for user in a:
#		print("name:%s,email:%s,password:%s" % (user.name,user.email,user.passwd)) 
#	pdb.set_trace()
	app = web.Application(loop = loop,middlewares = [logger_factory,auth_factory,response_factory])
	init_jinja2(app)
	print("2")

#	app.router.add_route("GET","/",handler.index)
#	print("3")
#	app.router.add_route("GET","/first",handler.first)
#	print("4")
	
	AddRoute(app,"handler")
	CssJsPath = os.path.join(os.path.dirname(os.path.abspath(__file__)),"static")
	app.router.add_static("/static/",CssJsPath)
	print("static file(css\js and so on) in %s ==>%s" % ("/static/",CssJsPath))  
	srv = yield from loop.create_server(app.make_handler(),"127.0.0.1",9000)
	print("5")
	return srv

loop = asyncio.get_event_loop()
print("a")
loop.run_until_complete(init(loop))
print("b")
loop.run_forever() 
print("c")

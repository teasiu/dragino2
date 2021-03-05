--teasiu<teasiu@qq.com>
module("luci.controller.blog", package.seeall)

function index()
	
	entry({"admin", "services", "blog"}, call("action_blog"), _("路由建站说明"), 01)
end
function action_blog()
	local reboot = luci.http.formvalue("blog")
	luci.template.render("admin_system/blog")
end

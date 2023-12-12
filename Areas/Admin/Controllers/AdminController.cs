using System;
using System.Diagnostics;
using System.Web.Mvc;

namespace MyProject_MVC.Areas.Admin.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin/Admin
        public ActionResult Index()
        {
            //bool test = Session["idUser"] != null;
            //if (test)
            //{
            return View();
            //}
            //else
            //{ return RedirectToAction("Login", "Account", new { area = "" }); }
        }
    }
}
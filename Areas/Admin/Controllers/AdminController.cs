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
            return View();
        }
    }
}
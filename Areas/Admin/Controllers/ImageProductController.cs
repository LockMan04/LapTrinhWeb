using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MyProject_MVC.Models;

namespace MyProject_MVC.Areas.Admin.Controllers
{
    public class ImageProductController : Controller
    {
        private ProductDbContext db = new ProductDbContext();

        // GET: Admin/ImageProduct
        public ActionResult Index()
        {
            return View(db.Product_Category.ToList());
        }
    }
}

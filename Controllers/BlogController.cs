using MyProject_MVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Net;

namespace MyProject_MVC.Controllers
{
    public class BlogController : Controller
    {
        ProductDbContext db = new ProductDbContext();
        // GET: Blog
        public ActionResult Index()
        {
            List<Blog> blogs = db.Blogs.ToList();
            return View(blogs.ToList());
        }

        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Blog blog = db.Blogs.Find(id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            return View(blog);
        }
    }
}
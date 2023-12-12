using MyProject_MVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyProject_MVC.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        [HandleError]
        public ActionResult Index()
        {
            ProductDbContext dbContext = new ProductDbContext();
            List<Product_Category> listProducts = dbContext.Product_Category.ToList();
            return View(listProducts);
        }

        public ActionResult Search(String search = "")
        {
            var dbContext = new ProductDbContext();
            var searchItem = dbContext.Product_Category.Where(p => p.ProName.Contains(search) || p.CatName.Contains(search)).ToList();
            return View(searchItem);
        }
    }
}
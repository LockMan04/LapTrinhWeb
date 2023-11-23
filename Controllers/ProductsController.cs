using MyProject_MVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace New_Project_MVC.Controllers
{
    public class ProductsController : Controller
    {

        // GET: Products
        public ActionResult Index(int categoryId = 1)
        {
            ProductDbContext dbContext = new ProductDbContext();
            List<Product_Category> listProducts = dbContext.Product_Category.ToList();
            return View(listProducts);
        }

        public ActionResult Sale()
        {
            ProductDbContext dbContext = new ProductDbContext();
            List<Product_Category> listProducts = dbContext.Product_Category.ToList();
            return View(listProducts);
        }

        public ActionResult Details(int id)
        {
            ProductDbContext dbContext = new ProductDbContext();
            Product product = dbContext.Products.Include(c => c.Category).FirstOrDefault(x => x.ProId == id);
            return View(product);
        }

    }
}
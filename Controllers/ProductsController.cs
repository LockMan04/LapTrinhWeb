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
        ProductDbContext dbContext = new ProductDbContext();

        // GET: Products
        public ActionResult Index(int categoryId = 1)
        {
            List<Product_Category> listProducts = dbContext.Product_Category.ToList();
            return View(listProducts);
        }

        public ActionResult Sale()
        {
            List<Product_Category> listProducts = dbContext.Product_Category.ToList();
            return View(listProducts);
        }

        public ActionResult Details(int id)
        {
            Product product = dbContext.Products.Include(c => c.Category).FirstOrDefault(x => x.ProId == id);
            return View(product);
        }

        //public ActionResult ProductsByCategory(int categoryId)
        //{
        //    List<Product_Category> listProducts = dbContext.Product_Category.ToList();
        //    return View(listProducts);
        //}


    }
}
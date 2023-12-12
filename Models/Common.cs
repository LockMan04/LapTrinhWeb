using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace MyProject_MVC.Models
{
    public class Common
    {
        public static List<Product_Category> GetProducts()
        {
            List<Product_Category> products = new List<Product_Category>();
            DbContext db = new DbContext("name=ProductDbContext");
            products = db.Set<Product_Category>().ToList<Product_Category>();
            return products;
        }

        public static List<Category> GetCategories()
        {
            List<Category> category = new List<Category>();
            DbContext db = new DbContext("name=ProductDbContext");
            category = db.Set<Category>().ToList<Category>();
            return category;
        }
    }
}
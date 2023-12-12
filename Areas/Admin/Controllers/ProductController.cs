using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MyProject_MVC.Models;

namespace MyProject_MVC.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        private ProductDbContext db = new ProductDbContext();

        // GET: Admin/Product
        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.Category);
            return View(products.ToList());
        }

        public ActionResult Search(string searchTerm = "")
        {
            var searchResults = db.Products
                .Where(p => p.ProName.Contains(searchTerm))
                .ToList();

            return PartialView("_SearchResults", searchResults);
        }

        // GET: Admin/Product/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // GET: Admin/Product/Create
        public ActionResult Create()
        {
            ViewBag.CategoryId = new SelectList(db.Categories, "CategoryId", "CatName").Skip(1);
            return View();
        }

        // POST: Admin/Product/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProId,ProName,ProImage,ProPrice,TypeOf, CategoryId, NewProImageName")] Product product, HttpPostedFileBase ProImageFile)
        {
            if (ModelState.IsValid)
            {
                // Xử lý tệp tin ảnh
                if (ProImageFile != null && ProImageFile.ContentLength > 0)
                {
                    string catName = db.Categories
                                    .Where(c => c.CategoryId == product.CategoryId)
                                    .Select(c => c.CatName)
                                    .FirstOrDefault();
                    string virPath = "/images/" + catName.ToLower() + "/";
                    string phyPath = Server.MapPath("~/" + virPath + "/");
                    // Đổi tên tệp tin ảnh để tránh trùng lặp
                    string fileName = Path.GetFileNameWithoutExtension(ProImageFile.FileName);
                    string fileExtension = Path.GetExtension(ProImageFile.FileName);

                    // Nếu có NewProImageName, sử dụng nó, ngược lại sử dụng tên mặc định
                    string newFileName = !string.IsNullOrEmpty(product.ProImage)
                        ? virPath + product.ProImage + fileExtension
                        : virPath + fileName + "_" + Guid.NewGuid().ToString() + fileExtension;

                    // Lưu tệp tin ảnh vào thư mục mong muốn
                    string path = phyPath + product.ProImage + fileExtension;
                    ProImageFile.SaveAs(path);

                    // Xóa tệp tin ảnh cũ nếu tồn tại
                    if (!string.IsNullOrEmpty(product.ProImage))
                    {
                        string oldImagePath = Path.Combine(Server.MapPath("~/Images"), product.ProImage);
                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }

                    // Lưu tên tệp tin ảnh mới vào model
                    product.ProImage = newFileName;
                }
                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            // Nếu ModelState không hợp lệ, tái tạo ViewBag.CategoryId
            ViewBag.CategoryId = new SelectList(db.Categories, "CategoryId", "CatName", product.CategoryId);
            return View(product);
        }


        // GET: Admin/Product/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryId = new SelectList(db.Categories, "CategoryId", "CatName", product.CategoryId);
            return View(product);
        }

        // POST: Admin/Product/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProId,ProName,ProImage,ProPrice,TypeOf,CategoryId")] Product product)
        {
            if (ModelState.IsValid)
            {
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CategoryId = new SelectList(db.Categories, "CategoryId", "CatName", product.CategoryId);
            return View(product);
        }

        // GET: Admin/Product/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Admin/Product/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

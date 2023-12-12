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
    public class BlogsController : Controller
    {
        private ProductDbContext db = new ProductDbContext();

        // GET: Admin/Blogs
        public ActionResult Index()
        {
            var blogs = db.Blogs.Include(b => b.User);
            return View(blogs.ToList());
        }

        // GET: Admin/Blogs/Create
        public ActionResult Create()
        {
            ViewBag.AuthorId = new SelectList(db.Users, "UserId", "UserName");
            return View();
        }

        // POST: Admin/Blogs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Title,Content,AuthorId, SummaryContent")] Blog blog, HttpPostedFileBase BlogAvata)
        {
            blog.CreatedAt = DateTime.Now;
            string nameTemp = blog.BlogId + string.Format("{0:ddMMyyhhmm}", blog.CreatedAt);

            if (ModelState.IsValid)
            {
                if (BlogAvata != null)
                {
                    // Xử lý tệp tin ảnh
                    string virPath = "/images/blog/";
                    string phyPath = Server.MapPath("~" + virPath);
                    // Đổi tên tệp tin ảnh để tránh trùng lặp
                    string fileExtension = Path.GetExtension(BlogAvata.FileName);

                    string newFileName = virPath + nameTemp + fileExtension;

                    // Lưu tệp tin ảnh vào thư mục mong muốn
                    string path = phyPath + nameTemp + fileExtension;
                    BlogAvata.SaveAs(path);

                    // Lưu tên tệp tin ảnh mới vào model
                    blog.BlogAvata = newFileName;
                }

                db.Blogs.Add(blog);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.AuthorId = new SelectList(db.Users, "UserId", "UserName", blog.AuthorId);
            return View(blog);
        }

        // GET: Admin/Blogs/Edit/5
        public ActionResult Edit(int? id)
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
            ViewBag.AuthorId = new SelectList(db.Users, "UserId", "UserName", blog.AuthorId);
            return View(blog);
        }

        // POST: Admin/Blogs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BlogId,Title,Content,AuthorId,CreatedAt, SummaryContent, BlogAvata")] Blog blog)
        {
            if (ModelState.IsValid)
            {
                db.Entry(blog).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.AuthorId = new SelectList(db.Users, "UserId", "UserName", blog.AuthorId);
            return View(blog);
        }

        // GET: Admin/Blogs/Delete/5
        public ActionResult Delete(int? id)
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

        // POST: Admin/Blogs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Blog blog = db.Blogs.Find(id);
            db.Blogs.Remove(blog);
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

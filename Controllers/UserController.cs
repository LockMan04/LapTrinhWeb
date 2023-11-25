using MyProject_MVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Controllers
{
    public class UserController : Controller
    {
        ProductDbContext objModel = new ProductDbContext();
        //GET: SignUp

        public ActionResult SignUp()
        {
            return View();
        }

        //POST: SignUp
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SignUp(User _user)
        {
            if (ModelState.IsValid)
            {
                var check = objModel.Users.FirstOrDefault(s => s.UserEmail == _user.UserEmail);
                if (check == null)
                {
                    //_user.UserPassword = GetMD5(_user.UserPassword);
                    objModel.Configuration.ValidateOnSaveEnabled = false;
                    objModel.Users.Add(_user);
                    objModel.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.error = "Email already exists";
                    return View();
                }
            }
            return View();
        }

        //create a string MD5
        //public static string GetMD5(string str)
        //{
        //    MD5 md5 = new MD5CryptoServiceProvider();
        //    byte[] fromData = Encoding.UTF8.GetBytes(str);
        //    byte[] targetData = md5.ComputeHash(fromData);
        //    string byte2String = null;

        //    for (int i = 0; i < targetData.Length; i++)
        //    {
        //        byte2String += targetData[i].ToString("x2");
        //    }
        //    return byte2String;
        //}

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string email, string password)
        {
            if (ModelState.IsValid)
            {


                //var f_password = GetMD5(password);
                var data = objModel.Users.Where(s => s.UserEmail.Equals(email) && s.UserPassword.Equals(password)).ToList();
                if (data.Count() > 0)
                {
                    //add session
                    Session["FullName"] = data.FirstOrDefault().UserName;
                    Session["Email"] = data.FirstOrDefault().UserEmail;
                    Session["idUser"] = data.FirstOrDefault().UserId;
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.error = "Login failed";
                    return RedirectToAction("Login");
                }
            }
            return View();
        }


        //Logout
        public ActionResult Logout()
        {
            Session.Clear();//remove session
            return RedirectToAction("Login");
        }
    }
}
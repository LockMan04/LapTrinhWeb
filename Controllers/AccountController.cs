using MyProject_MVC.Models;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;

public class AccountController : Controller
{
    private ProductDbContext db = new ProductDbContext();

    // GET: /Account/Register
    public ActionResult Register()
    {
        return View();
    }

    // POST: /Account/Register
    [HttpPost]
    [ValidateAntiForgeryToken]
    public ActionResult Register(User user)
    {
        if (ModelState.IsValid)
        {
            // Kiểm tra xem email đã tồn tại chưa
            if (db.Users.Any(u => u.UserEmail == user.UserEmail))
            {
                ViewBag.ErrorMessage = "Email đã tồn tại";
                return View(user);
            }

            // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
            user.UserPassword = GetMD5(user.UserPassword);

            db.Users.Add(user);
            db.SaveChanges();

            return RedirectToAction("Login");
        }

        return View(user);
    }

    // GET: /Account/Login
    public ActionResult Login()
    {
        return View();
    }

    // POST: /Account/Login
    [HttpPost]
    [ValidateAntiForgeryToken]
    public ActionResult Login(User user)
    {
        if (ModelState.IsValid)
        {
            var f_password = GetMD5(user.UserPassword);

            var data = db.Users.FirstOrDefault(s => s.UserEmail.Equals(user.UserEmail) && s.UserPassword.Equals(f_password));
            if (data != null)
            {
                bool IsAdmin = (user.UserEmail.ToLower() == "admin@gmail.com" && f_password == GetMD5(user.UserPassword));
                if (IsAdmin)
                {
                    return RedirectToAction("Index", "Admin", new { area = "Admin" });
                }
                else
                {
                    Session["FullName"] = data.UserName;
                    Session["Email"] = data.UserEmail;
                    Session["idUser"] = data.UserId;

                    return RedirectToAction("Index", "Home");
                }
            }
            else
            {
                ViewBag.error = "Tài Khoản hoặc mật khẩu lỗi";
                return View();
            }
        }
        return View(user);
    }


    // GET: /Account/Logout
    public ActionResult Logout()
    {
        Session.Clear();
        return RedirectToAction("Index", "Home");
    }

    // Hàm mã hóa mật khẩu MD5
    private string GetMD5(string input)
    {
        MD5 md5 = new MD5CryptoServiceProvider();
        byte[] fromData = Encoding.UTF8.GetBytes(input);
        byte[] targetData = md5.ComputeHash(fromData);
        string byte2String = null;

        for (int i = 0; i < targetData.Length; i++)
        {
            byte2String += targetData[i].ToString("x2");
        }
        return byte2String;
    }
}

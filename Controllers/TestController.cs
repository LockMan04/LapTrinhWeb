using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyProject_MVC.Controllers
{
    public class TestController : Controller
    {
        // GET: Test
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult AddToCart(int productId, int quantity)
        {
            // Logic để thêm sản phẩm vào giỏ hàng
            // ...

            // Trả về kết quả JSON
            return Json(new { success = true, message = "Sản phẩm đã được thêm vào giỏ hàng thành công" });
        }

        public JsonResult GetCartItemCount()
        {
            int itemCount = 0;

            // Logic để lấy số lượng sản phẩm trong giỏ hàng
            // ...

            return Json(itemCount, JsonRequestBehavior.AllowGet);
        }

    }
}
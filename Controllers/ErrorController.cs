using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyProject_MVC.Controllers
{
    public class ErrorController : Controller
    {
        // Xử lý lỗi 404 - Not Found
        public ActionResult NotFound()
        {
            Response.StatusCode = 404; // Thiết lập mã trạng thái HTTP 404
            return View();
        }

        // Xử lý lỗi 500 - Internal Server Error
        public ActionResult InternalServerError()
        {
            Response.StatusCode = 500; // Thiết lập mã trạng thái HTTP 500
            return View();
        }
    }
}
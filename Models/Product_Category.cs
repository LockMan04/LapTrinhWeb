//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MyProject_MVC.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Product_Category
    {
        public int ProId { get; set; }
        public string ProName { get; set; }
        public string ProImage { get; set; }
        public Nullable<decimal> ProPrice { get; set; }
        public string TypeOf { get; set; }
        public int CategoryId { get; set; }
        public string CatName { get; set; }
    }
}
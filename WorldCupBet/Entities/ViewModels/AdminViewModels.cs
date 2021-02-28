using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.ViewModels
{
    public class AccountViewModel
    {
        public int UserId { get; set; }

        [Required]
        [DisplayName("Tên đăng nhập")]
        public string Username { get; set; }
        [Required]
        [DisplayName("Họ và tên")]
        public string Fullname { get; set; }
        [Required]
        [DisplayName("Tài khoản")]
        public int Balance { get; set; }

        public int UserRole { get; set; }
    }

    public class MultiAccountsViewModel
    {
        [Required]
        [DisplayName("Danh sách tên đăng nhập")]
        public string Usernames { get; set; }
        [Required]
        [DisplayName("Danh sách họ và tên")]
        public string Fullnames { get; set; }
    }

    public class ResetPasswordViewModel
    {
        [Required]
        [DisplayName("Tên đăng nhập")]
        public string Username { get; set; }
    }

    public class TransactionViewModel
    {
        public int UserId { get; set; }

        [Required]
        [DisplayName("Tên đăng nhập")]
        public string Username { get; set; }

        [DisplayName("Họ và tên")]
        public string Fullname { get; set; }

        [Required]
        [DisplayName("Số tiền")]
        public int? Amount { get; set; }

        [DisplayName("Tài khoản")]
        public int Balance { get; set; }

        public int TransactionType { get; set; }
    }
}

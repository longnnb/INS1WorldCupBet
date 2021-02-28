using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.SessionModels
{
    public class CurrentUser
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public string Fullname { get; set; }
        public int UserRole { get; set; }
        public int Balance { get; set; }
        public bool IsFirstLogin { get; set; }
    }
}

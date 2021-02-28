using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.ViewModels
{
    public class UserHistory
    {
        public string Content { get; set; }
        public DateTime Time { get; set; }
    }
}

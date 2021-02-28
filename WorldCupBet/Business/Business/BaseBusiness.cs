using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.DataModels;
namespace Business
{
    public class BaseBusiness
    {
        protected WorldCupBetDbContext dbContext;

        public BaseBusiness()
        {
            dbContext = new WorldCupBetDbContext();
        }
    }
}

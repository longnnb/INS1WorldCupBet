using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WorldCupBet.CustomActionFilters;

namespace WorldCupBet.Controllers
{
    [CheckIsFirstLogin]
    public class BaseController : Controller
    {
        // GET: Base
    }
}
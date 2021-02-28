using Business;
using Common;
using Entities.DataModels;
using Entities.SessionModels;
using Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WorldCupBet.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            BetBusiness business = new BetBusiness();
            var matches = business.GetMatches();
            var user = Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser);
            var teams = business.GetAliveTeams();
            var model = new HomeViewModel()
            {
                Matches = matches,
                Balance = (user != null) ? new UserBusiness().GetUserBalance(user.UserId) : 0,
                UserId = (user != null) ? user.UserId : 0,
                AliveTeams = teams,
                ChampionTeamBet = (user != null) ? new UserBusiness().GetChampionTeamBet(user.UserId) : string.Empty
            };
            return View(model);
        }

        public ActionResult Login()
        {
            if (Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser) != null)
            {
                return RedirectToAction("Index");
            }
            return View();
        }

        [HttpPost]
        public ActionResult Login(string username, string password)
        {
            UserBusiness business = new UserBusiness();
            if (business.CheckCredentials(username, UserHelper.EncryptPassword(password)))
            {
                Utilities.SaveCache(Constants.CacheKeys.CurrentUser, business.GetCurrentUser(username));

                return Json(new
                {
                    result = Constants.ReturnMessages.Successful
                });
            }
            else
            {
                return Json(new
                {
                    result = Constants.ReturnMessages.Fail
                });
            }
        }

        public ActionResult Logoff()
        {
            Utilities.RemoveCache(Constants.CacheKeys.CurrentUser);
            return RedirectToAction("Index", "Home");
        }

        public ActionResult AccessDenied()
        {
            return View();
        }

        public ActionResult AllMatches()
        {
            BetBusiness business = new BetBusiness();
            var matches = business.GetMatches();
            var user = Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser);
            var model = new HomeViewModel()
            {
                Matches = matches,
                Balance = (user != null) ? user.Balance : 0,
                UserId = (user != null) ? user.UserId : 0
            };
            return View(model);
        }
    }
}
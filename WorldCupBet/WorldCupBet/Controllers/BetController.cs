using Business;
using Common;
using Entities.SessionModels;
using Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WorldCupBet.Controllers
{
    public class BetController : BaseController
    {
        [HttpPost]
        public ActionResult GetTeamBetInfo(int matchId)
        {
            var user = Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser);
            BetBusiness business = new BetBusiness();
            if (user != null)
            {
                var model = business.GetTeamBetInfo(matchId, user.UserId);
                user.Balance = model.UserBalance;
                Utilities.SaveCache(Constants.CacheKeys.CurrentUser, user);
                return Json(new
                {
                    betStatus = model.BetStatus,
                    betAmount = model.BetAmount,
                    betTeam = model.BetTeam,
                    userBalance = model.UserBalance,
                    isLocked = model.IsLocked
                });
            }
            else
            {
                var model = business.GetTeamBetInfo(matchId);
                return Json(new
                {
                    betStatus = 0,
                    userBalance = 0,
                    isLocked = model.IsLocked
                });
            }
        }

        [HttpPost]
        public ActionResult TeamBet(TeamBetViewModel model)
        {
            var user = Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser);
            if (user != null)
            {
                model.UserId = user.UserId;
                BetBusiness business = new BetBusiness();
                model = business.TeamBet(model);
                user.Balance = model.UserBalance;
                Utilities.SaveCache(Constants.CacheKeys.CurrentUser, user);
                return Json(new
                {
                    result = model.Result,
                    betAmount = model.BetAmount,
                    userBalance = model.UserBalance,
                    betStatus = model.BetStatus,
                    betTeam = model.BetTeam,
                    isLocked = model.IsLocked
                });
            }
            else
            {
                return Json(new
                {
                    result = Constants.ReturnMessages.UserNotLogin
                });
            }
        }

        [HttpPost]
        public ActionResult GetUnderOverBetInfo(int matchId)
        {
            var user = Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser);
            BetBusiness business = new BetBusiness();
            if (user != null)
            {
                var model = business.GetUnderOverBetInfo(matchId, user.UserId);
                user.Balance = model.UserBalance;
                Utilities.SaveCache(Constants.CacheKeys.CurrentUser, user);
                return Json(new
                {
                    betStatus = model.BetStatus,
                    betAmount = model.BetAmount,
                    betSide = model.BetSide,
                    userBalance = model.UserBalance,
                    isLocked = model.IsLocked
                });
            }
            else
            {
                var model = business.GetTeamBetInfo(matchId);
                return Json(new
                {
                    betStatus = 0,
                    userBalance = 0,
                    isLocked = model.IsLocked
                });
            }
        }

        [HttpPost]
        public ActionResult UnderOverBet(UnderOverBetViewModel model)
        {
            var user = Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser);
            if (user != null)
            {
                model.UserId = user.UserId;
                BetBusiness business = new BetBusiness();
                model = business.UnderOverBet(model);
                user.Balance = model.UserBalance;
                Utilities.SaveCache(Constants.CacheKeys.CurrentUser, user);
                return Json(new
                {
                    result = model.Result,
                    betAmount = model.BetAmount,
                    userBalance = model.UserBalance,
                    betStatus = model.BetStatus,
                    betSide = model.BetSide,
                    isLocked = model.IsLocked
                });
            }
            else
            {
                return Json(new
                {
                    result = Constants.ReturnMessages.UserNotLogin
                });
            }
        }

        [HttpPost]
        public ActionResult ChampionBet(string teamCode)
        {
            BetBusiness business = new BetBusiness();
            var result = business.ChampionBet(teamCode);

            if (result.Equals(Constants.ReturnMessages.Successful))
            {
                var user = Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser);
                user.Balance -= 30000;
                Utilities.SaveCache(Constants.CacheKeys.CurrentUser, user);
            }

            return Json(new
            {
                result = result
            });
        }
    }
}
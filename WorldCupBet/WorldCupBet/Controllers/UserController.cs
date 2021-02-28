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
using WorldCupBet.CustomActionFilters;
using static Common.Constants;

namespace WorldCupBet.Controllers
{
    [CheckUserSession]
    public class UserController : BaseController
    {
        // GET: User
        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ChangePassword(string oldPassword, string newPassword, string confirmPassword)
        {
            var username = Utilities.GetCache<CurrentUser>(CacheKeys.CurrentUser).Username;
            oldPassword = UserHelper.EncryptPassword(oldPassword);
            newPassword = UserHelper.EncryptPassword(newPassword);

            UserBusiness business = new UserBusiness();
            var result = business.ChangePassword(username, oldPassword, newPassword);

            if (result.Equals(ReturnMessages.Successful))
            {
                var user = business.GetCurrentUser(username);
                Utilities.SaveCache(CacheKeys.CurrentUser, user);
            }

            return Json(new
            {
                message = result
            });
        }

        public ActionResult UserProfile()
        {
            var user = Utilities.GetCache<CurrentUser>(CacheKeys.CurrentUser);
            UserBusiness business = new UserBusiness();
            user.Balance = business.GetUserBalance(user.UserId);
            Utilities.SaveCache(CacheKeys.CurrentUser, user);
            return View(user);
        }

        public ActionResult UserHistory()
        {
            var user = Utilities.GetCache<CurrentUser>(CacheKeys.CurrentUser);
            UserBusiness business = new UserBusiness();
            var historyList = business.GetUserHistory(user.UserId);
            return View(historyList);
        }
    }
}
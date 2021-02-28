using Business;
using Common;
using Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WorldCupBet.CustomActionFilters;

namespace WorldCupBet.Controllers
{
    [AdminOnly]
    public class AdminController : BaseController
    {
        public ActionResult AdminIndex()
        {
            return View();
        }
        // GET: Admin
        public ActionResult CreateAccount()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreateAccount(AccountViewModel model)
        {
            AdminBusiness business = new AdminBusiness();
            var result = business.CreateAccount(model.Username, model.Fullname, model.Balance);
            if (result.Equals(Constants.ReturnMessages.Successful))
            {
                ModelState.AddModelError("", string.Format("Success. Tài khoản {0} đã được tạo.", model.Username));
                return View();
            }
            else if (result.Equals(Constants.ReturnMessages.UsernameExist))
            {
                ModelState.AddModelError("", string.Format("Fail. Tài khoản {0} đã tồn tại.", model.Username));
                return View();
            }
            else
            {
                ModelState.AddModelError("", "Fail. Vui lòng thử lại");
                return View();
            }
        }

        public ActionResult CreateMultiAccounts()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreateMultiAccounts(MultiAccountsViewModel model)
        {
            var usernames = model.Usernames.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            var fullnames = model.Fullnames.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

            AdminBusiness business = new AdminBusiness();
            var result = business.CreateMultiAccounts(usernames, fullnames);
            if (result.Equals(Constants.ReturnMessages.Successful))
            {
                ModelState.AddModelError("", "Tạo accounts thành công");
                return View();
            }
            else if (result.Equals(Constants.ReturnMessages.ListNotMapping))
            {
                ModelState.AddModelError("", "List accounts & names không mapping số lượng");
                return View();
            }
            else
            {
                ModelState.AddModelError("", "Fail. Vui lòng thử lại");
                return View();
            }
        }

        public ActionResult ResetPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ResetPassword(ResetPasswordViewModel model)
        {
            AdminBusiness business = new AdminBusiness();
            var result = business.ResetPassword(model.Username);
            if (result.Equals(Constants.ReturnMessages.Successful))
            {
                ModelState.AddModelError("", string.Format("Success. Đã reset pasword cho {0}.", model.Username));
                return View();
            }
            else if (result.Equals(Constants.ReturnMessages.UserNotFound))
            {
                ModelState.AddModelError("", string.Format("Fail. Không tìm thấy tài khoản {0}.", model.Username));
                return View();
            }
            else
            {
                ModelState.AddModelError("", "Fail. Vui lòng thử lại");
                return View();
            }
        }

        public ActionResult MakeTransaction(int type, string username = "")
        {
            var transaction = new TransactionViewModel
            {
                TransactionType = type,
                Username = username
            };

            return View(transaction);
        }

        [HttpPost]
        public ActionResult MakeTransaction(TransactionViewModel model)
        {
            if (model.Amount == null || model.Amount <= 0)
            {
                ModelState.AddModelError("", "Không hợp lệ. Nhập số tiền >= 0.");
                return View(model);
            }

            TransactionBusiness transactionBusiness = new TransactionBusiness();
            int balance;
            if (model.TransactionType == 1)
            {
                balance = transactionBusiness.Deposit(model.Username, model.Amount.Value);
            }
            else if (model.TransactionType == 2)
            {
                balance = transactionBusiness.Withdraw(model.Username, model.Amount.Value);
            }
            else
            {
                ModelState.AddModelError("", "Giao dịch không hợp lệ.");
                return View(model);
            }

            if (balance == -1)
            {
                ModelState.AddModelError("", string.Format("Fail. Không tìm thấy tài khoản {0}.", model.Username));
            }
            else
            {
                ModelState.AddModelError("", string.Format("Success. Số dư hiện tại của {0}: {1} đ", model.Username, balance.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))));
            }
            return View(model);
        }

        public ActionResult ListMatches()
        {
            BetBusiness betBusiness = new BetBusiness();
            var matches = betBusiness.GetMatches();
            return View(matches);
        }

        public ActionResult EditMatch(int matchId)
        {
            BetBusiness betBusiness = new BetBusiness();
            var match = betBusiness.GetMatch(matchId);
            return View(match);
        }

        [HttpPost]
        public ActionResult EditMatch(MatchViewModel model)
        {
            AdminBusiness business = new AdminBusiness();
            business.EditMatch(model);
            return RedirectToAction("ListMatches");
        }

        public ActionResult PayBet(int matchId)
        {
            BetBusiness betBusiness = new BetBusiness();
            var result = betBusiness.PayBet(matchId);
            return RedirectToAction("ListMatches");
        }

        public ActionResult ListUserBalance()
        {
            AdminBusiness adminBusiness = new AdminBusiness();
            var list = adminBusiness.GetUserBalanceList();
            return View(list);
        }

        public ActionResult EditUser(int userId)
        {
            AdminBusiness adminBusiness = new AdminBusiness();
            var model = adminBusiness.GetAccountInfo(userId);
            return View(model);
        }

        [HttpPost]
        public ActionResult EditUser(AccountViewModel model)
        {
            AdminBusiness adminBusiness = new AdminBusiness();
            adminBusiness.SaveAccountInfo(model);
            ModelState.AddModelError("", "Successful");
            return View();
        }
    }
}
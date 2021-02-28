using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.DataModels;
using System.Data.Entity;
using Common;
using Entities.SessionModels;
using Entities.ViewModels;

namespace Business
{
    public class UserBusiness : BaseBusiness
    {
        public CurrentUser GetCurrentUser(string username)
        {
            username = username.Trim();
            var currentUser = (from u in dbContext.Users
                              join ua in dbContext.UserAccounts
                              on u.UserId equals ua.UserId
                              where u.Username == username
                              select new CurrentUser()
                              {
                                  UserId = u.UserId,
                                  Username = u.Username,
                                  Fullname = u.Fullname,
                                  UserRole = u.UserRole,
                                  IsFirstLogin = u.IsFirstLogin,
                                  Balance = ua.Balance
                              }).FirstOrDefault();

            return currentUser;
        }

        public bool CheckCredentials(string username, string password)
        {
            username = username.Trim();
            return dbContext.Credentials.Any(x => x.Username.Equals(username) && x.Password.Equals(password));
        }

        public string ChangePassword(string username, string oldPassword, string newPassword)
        {
            username = username.Trim();
            if (CheckCredentials(username, oldPassword))
            {
                var credential = dbContext.Credentials.FirstOrDefault(x => x.Username.Equals(username));
                credential.Password = newPassword;
                dbContext.Entry(credential).State = EntityState.Modified;

                var user = dbContext.Users.FirstOrDefault(x => x.Username.Equals(username));
                user.IsFirstLogin = false;
                dbContext.Entry(user).State = EntityState.Modified;

                dbContext.SaveChanges();

                return Constants.ReturnMessages.Successful;
            }
            else
            {
                return Constants.ReturnMessages.WrongPassword;
            }
        }

        public int GetUserBalance(int userId)
        {
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == userId);
            return userAccount.Balance;
        }

        public List<UserHistory> GetUserHistory(int userId)
        {
            var historyList = dbContext.ActivityLogs.Where(x => x.UserId == userId).Select(x => new UserHistory
            {
                Time = x.Created.Value,
                Content = x.Content
            });
            return historyList.ToList();
        }

        public string GetChampionTeamBet(int userId)
        {
            var bet = dbContext.ChampionBets.FirstOrDefault(x => x.UserId == userId);
            return (bet != null) ? bet.TeamCode : string.Empty; 
        }
    }
}

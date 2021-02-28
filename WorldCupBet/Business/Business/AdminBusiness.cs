using Common;
using Entities.DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using Entities.ViewModels;

namespace Business
{
    public class AdminBusiness : BaseBusiness
    {
        public string CreateAccount(string username, string fullname = "", int balance = 0)
        {
            username = username.Trim();
            if (dbContext.Users.Any(x => x.Username.Equals(username)))
            {
                return Constants.ReturnMessages.UsernameExist;
            }
            else
            {
                var newUser = new User
                {
                    Username = username,
                    Fullname = fullname,
                    UserRole = (int)Enums.UserRoles.User,
                    IsFirstLogin = true,
                    Created = DateTime.Now
                };
                dbContext.Users.Add(newUser);
                dbContext.SaveChanges();

                var user = dbContext.Users.FirstOrDefault(x => x.Username.Equals(username));
                var userAccount = new UserAccount()
                {
                    UserId = user.UserId,
                    Username = username,
                    Balance = 0,
                    Created = DateTime.Now
                };
                dbContext.UserAccounts.Add(userAccount);

                var credential = new Credential()
                {
                    UserId = user.UserId,
                    Username = username,
                    Password = UserHelper.EncryptPassword(username)
                };
                dbContext.Credentials.Add(credential);

                dbContext.SaveChanges();

                if (balance > 0)
                {
                    TransactionBusiness transactionBusiness = new TransactionBusiness();
                    transactionBusiness.Deposit(username, balance);
                }

                return Constants.ReturnMessages.Successful;
            }
        }

        public string CreateMultiAccounts(string[] usernames, string[] fullnames)
        {

            var userCount = usernames.Length;
            var nameCount = fullnames.Length;

            if (userCount != nameCount)
            {
                return Constants.ReturnMessages.ListNotMapping;
            }

            for (int i = 0; i < userCount; i++)
            {
                var username = usernames[i].Trim();

                if (dbContext.Users.Any(x => x.Username.ToLower().Equals(username.ToLower())))
                    continue;

                var newUser = new User
                {
                    Username = username,
                    Fullname = fullnames[i].Trim(),
                    UserRole = (int)Enums.UserRoles.User,
                    IsFirstLogin = true,
                    Created = DateTime.Now
                };
                dbContext.Users.Add(newUser);
                dbContext.SaveChanges();

                var user = dbContext.Users.FirstOrDefault(x => x.Username.Equals(username));
                var userAccount = new UserAccount()
                {
                    UserId = user.UserId,
                    Username = username,
                    Balance = 0,
                    Created = DateTime.Now
                };
                dbContext.UserAccounts.Add(userAccount);

                var credential = new Credential()
                {
                    UserId = user.UserId,
                    Username = username,
                    Password = UserHelper.EncryptPassword(username)
                };
                dbContext.Credentials.Add(credential);

                dbContext.SaveChanges();
            }

            return Constants.ReturnMessages.Successful;
        }

        public string ResetPassword(string username)
        {
            username = username.Trim();
            var credential = dbContext.Credentials.FirstOrDefault(x => x.Username.ToLower().Equals(username.ToLower()));
            if (credential != null)
            {
                credential.Password = UserHelper.EncryptPassword(credential.Username);
                dbContext.Entry(credential).State = EntityState.Modified;
                dbContext.SaveChanges();
                return Constants.ReturnMessages.Successful;
            }
            else
            {
                return Constants.ReturnMessages.UserNotFound;
            }
        }

        public void EditMatch(MatchViewModel model)
        {
            var match = dbContext.Matches.Find(model.MatchId);
            var teamBet = dbContext.TeamBets.FirstOrDefault(x => x.MatchId == model.MatchId);
            var underOverBet = dbContext.UnderOverBets.FirstOrDefault(x => x.MatchId == model.MatchId);
            {
                match.Score1 = model.Score1;
                match.Score2 = model.Score2;
                match.IsStarted = model.IsStarted;
                match.IsFinished = model.IsFinished;
                match.MatchTime = model.MatchTime;
                match.MatchRound = model.MatchRound;
                //match.TeamCode1 = model.Team1Code;
                //match.TeamCode2 = model.Team2Code;
            }
            {
                teamBet.Odds1 = model.Odds1;
                teamBet.Odds2 = model.Odds2;
                teamBet.PaidRate1 = model.PaidRate1;
                teamBet.PaidRate2 = model.PaidRate2;
                teamBet.IsLocked = model.IsBetLocked;
            }
            {
                underOverBet.TotalGoalsBet = model.UnderOverGoals;
                underOverBet.PaidRate1 = model.UnderOverPaidRate1;
                underOverBet.PaidRate2 = model.UnderOverPaidRate2;
                underOverBet.IsLocked = model.IsBetLocked;
            }
            dbContext.Entry(match).State = EntityState.Modified;
            dbContext.Entry(teamBet).State = EntityState.Modified;
            dbContext.Entry(underOverBet).State = EntityState.Modified;
            dbContext.SaveChanges();
        }

        public List<TransactionViewModel> GetUserBalanceList()
        {
            var list = from u in dbContext.Users
                       join ua in dbContext.UserAccounts
                       on u.UserId equals ua.UserId
                       orderby u.Username
                       select new TransactionViewModel
                       {
                           UserId = u.UserId,
                           Username = u.Username,
                           Fullname = u.Fullname,
                           Balance = ua.Balance
                       };

            return list.ToList();
        }

        public AccountViewModel GetAccountInfo(int userId)
        {
            var user = dbContext.Users.FirstOrDefault(x => x.UserId == userId);
            return new AccountViewModel()
            {
                UserId = user.UserId,
                Fullname = user.Fullname,
                Username = user.Username,
                UserRole = user.UserRole
            };
        }

        public void SaveAccountInfo(AccountViewModel model)
        {
            var user = dbContext.Users.FirstOrDefault(x => x.UserId == model.UserId);
            user.Username = model.Username;
            user.Fullname = model.Fullname;
            user.UserRole = model.UserRole;
            dbContext.Entry(user).State = EntityState.Modified;
            dbContext.SaveChanges();
        }
    }
}

using Entities.DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common;
using System.Data.Entity;

namespace Business
{
    public class TransactionBusiness : BaseBusiness
    {
        public int Deposit(int userId, int amount)
        {
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == userId);
            if (userAccount == null)
            {
                return -1;
            }

            userAccount.Balance += amount;
            userAccount.Updated = DateTime.Now;
            dbContext.Entry(userAccount).State = EntityState.Modified;
            var userTransaction = new UserTransaction()
            {
                UserId = userAccount.UserId,
                TransactionType = (int)Enums.TransactionTypes.Deposit,
                Amount = amount,
                Created = DateTime.Now
            };
            dbContext.UserTransactions.Add(userTransaction);

            ActivityLog activityLog = new ActivityLog()
            {
                UserId = userId,
                Content = string.Format(Constants.StringFormat.Deposit, amount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                Created = DateTime.Now
            };
            dbContext.ActivityLogs.Add(activityLog);

            dbContext.SaveChanges();
            return userAccount.Balance;
        }

        public int Deposit(string username, int amount)
        {
            username = username.Trim();
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.Username.ToLower() == username.ToLower());
            if (userAccount == null)
            {
                return -1;
            }

            userAccount.Balance += amount;
            userAccount.Updated = DateTime.Now;
            dbContext.Entry(userAccount).State = EntityState.Modified;
            var userTransaction = new UserTransaction()
            {
                UserId = userAccount.UserId,
                TransactionType = (int)Enums.TransactionTypes.Deposit,
                Amount = amount,
                Created = DateTime.Now
            };
            dbContext.UserTransactions.Add(userTransaction);

            ActivityLog activityLog = new ActivityLog()
            {
                UserId = userAccount.UserId,
                Content = string.Format(Constants.StringFormat.Deposit, amount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                Created = DateTime.Now
            };
            dbContext.ActivityLogs.Add(activityLog);

            dbContext.SaveChanges();
            return userAccount.Balance;
        }

        public int Withdraw(int userId, int amount)
        {
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == userId);
            if (userAccount == null)
            {
                return -1;
            }

            userAccount.Balance -= amount;
            userAccount.Updated = DateTime.Now;
            dbContext.Entry(userAccount).State = EntityState.Modified;
            var userTransaction = new UserTransaction()
            {
                UserId = userAccount.UserId,
                TransactionType = (int)Enums.TransactionTypes.Withdraw,
                Amount = amount,
                Created = DateTime.Now
            };
            dbContext.UserTransactions.Add(userTransaction);

            ActivityLog activityLog = new ActivityLog()
            {
                UserId = userId,
                Content = string.Format(Constants.StringFormat.Withdraw, amount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                Created = DateTime.Now
            };
            dbContext.ActivityLogs.Add(activityLog);

            dbContext.SaveChanges();
            return userAccount.Balance;
        }

        public int Withdraw(string username, int amount)
        {
            username = username.Trim();
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.Username.ToLower() == username.ToLower());
            if (userAccount == null)
            {
                return -1;
            }

            userAccount.Balance -= amount;
            userAccount.Updated = DateTime.Now;
            dbContext.Entry(userAccount).State = EntityState.Modified;
            var userTransaction = new UserTransaction()
            {
                UserId = userAccount.UserId,
                TransactionType = (int)Enums.TransactionTypes.Withdraw,
                Amount = amount,
                Created = DateTime.Now
            };
            dbContext.UserTransactions.Add(userTransaction);

            ActivityLog activityLog = new ActivityLog()
            {
                UserId = userAccount.UserId,
                Content = string.Format(Constants.StringFormat.Withdraw, amount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                Created = DateTime.Now
            };
            dbContext.ActivityLogs.Add(activityLog);

            dbContext.SaveChanges();
            return userAccount.Balance;
        }

        public int Bet(int userId, int amount, int matchId)
        {
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == userId);
            if (userAccount == null)
            {
                return -1;
            }

            userAccount.Balance -= amount;
            userAccount.Updated = DateTime.Now;
            dbContext.Entry(userAccount).State = EntityState.Modified;
            var userTransaction = new UserTransaction()
            {
                UserId = userAccount.UserId,
                MatchId = matchId,
                TransactionType = (int)Enums.TransactionTypes.Bet,
                Amount = amount,
                Created = DateTime.Now
            };
            dbContext.UserTransactions.Add(userTransaction);
            dbContext.SaveChanges();
            return userAccount.Balance;
        }

        public int Bet(string username, int amount, int matchId)
        {
            username = username.Trim();
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.Username.ToLower() == username.ToLower());
            if (userAccount == null)
            {
                return -1;
            }

            userAccount.Balance -= amount;
            userAccount.Updated = DateTime.Now;
            dbContext.Entry(userAccount).State = EntityState.Modified;
            var userTransaction = new UserTransaction()
            {
                UserId = userAccount.UserId,
                MatchId = matchId,
                TransactionType = (int)Enums.TransactionTypes.Bet,
                Amount = amount,
                Created = DateTime.Now
            };
            dbContext.UserTransactions.Add(userTransaction);
            dbContext.SaveChanges();
            return userAccount.Balance;
        }

        public int Refund(int userId, int amount, int matchId)
        {
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == userId);
            if (userAccount == null)
            {
                return -1;
            }

            userAccount.Balance += amount;
            userAccount.Updated = DateTime.Now;
            dbContext.Entry(userAccount).State = EntityState.Modified;
            var userTransaction = new UserTransaction()
            {
                UserId = userAccount.UserId,
                MatchId = matchId,
                TransactionType = (int)Enums.TransactionTypes.Refund,
                Amount = amount,
                Created = DateTime.Now
            };
            dbContext.UserTransactions.Add(userTransaction);
            dbContext.SaveChanges();
            return userAccount.Balance;
        }

        public int Refund(string username, int amount, int matchId)
        {
            username = username.Trim();
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.Username.ToLower() == username.ToLower());
            if (userAccount == null)
            {
                return -1;
            }

            userAccount.Balance += amount;
            userAccount.Updated = DateTime.Now;
            dbContext.Entry(userAccount).State = EntityState.Modified;
            var userTransaction = new UserTransaction()
            {
                UserId = userAccount.UserId,
                MatchId = matchId,
                TransactionType = (int)Enums.TransactionTypes.Refund,
                Amount = amount,
                Created = DateTime.Now
            };
            dbContext.UserTransactions.Add(userTransaction);
            dbContext.SaveChanges();
            return userAccount.Balance;
        }
    }
}

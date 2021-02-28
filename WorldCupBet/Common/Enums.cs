using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class Enums
    {
        public enum UserRoles
        {
            Admin = 1,
            User = 2
        }

        public enum TransactionTypes
        {
            Deposit = 1,
            Withdraw = 2,
            Bet = 3,
            Refund = 4
        }

        public enum BetTypes
        {
            TeamBet = 1,
            ScoreBet = 2,
            UnderOverBet = 3,
            ChampionBet = 4
        }

        public enum BetStatus
        {
            Pending = 1,
            Accepted = 2,
            Draw = 3,
            Lose = 4,
            Paid = 5,
            Cancel = 9
        }

        public enum BetAction
        {
            Bet = 1,
            AddMoney = 2,
            Edit = 3,
            GetMoney = 4,
            Cancel = 9
        }

        public enum UnderOverSire
        {
            Under = 1,
            Over = 2
        }
    }
}

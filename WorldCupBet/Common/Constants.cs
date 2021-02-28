using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class Constants
    {
        public class CacheKeys
        {
            public const string CurrentUser = "CurrentUser";
            public const string CmnEntityModel = "CmnEntityModel";
        }

        public class ReturnMessages
        {
            //common
            public const string Successful = "Successful";
            public const string Fail = "Fail";
            public const string UserNotFound = "UserNotFound";
            public const string DataNotValid = "DataNotValid";
            public const string UserNotLogin = "UserNotLogin";

            //change password
            public const string WrongPassword = "WrongPassword";

            //create acc
            public const string UsernameExist = "UsernameExist";

            //creare multi acc
            public const string ListNotMapping = "ListNotMapping";

            //bet
            public const string LockedMatch = "LockedMatch";
            public const string NotEnoughMoney = "NotEnoughMoney";
            public const string AlreadyBet = "AlreadyBet";

        }

        public class BetAmout
        {
            public const int TeamBet_MinAmount = 10000;
            public const int TeamBet_MaxAmount = 300000;
            public const int UnderOverBet_MinAmount = 10000;
            public const int UnderOverBet_MaxAmount = 300000;
            public const int ScoreBet_DefaultAmount = 5000;
        }

        public class StringFormat
        {
            public const string Deposit = "Nạp <b>{0} đ</b> vào tài khoản.";
            public const string Withdraw = "Rút <b>{0} đ</b> từ tài khoản.";

            public const string TeamBet = "Đặt cược thành công trận <b>{0}</b>, cược <b>{1}</b> số tiền <b>{2} đ</b>.";
            public const string TeamBetWinRefund = "Thắng cược trận <b>{0}</b>, nhận lại <b>{1} đ</b>.";
            public const string TeamBetDrawRefund = "Hòa cược trận <b>{0}</b>, nhận lại <b>{1} đ</b>.";
            public const string TeamBetLoseRefund = "Thua cược trận <b>{0}</b>, nhận lại <b>{1} đ</b>.";
            public const string TeamBetLose = "Thua cược trận <b>{0}</b>.";

            public const string UnderOverBet = "Đặt cược <b>TÀI XỈU</b> thành công trận <b>{0}</b>, cược <b>{1}</b> số tiền <b>{2} đ</b>.";
            public const string UnderOverBetWinRefund = "Thắng cược <b>TÀI XỈU</b> trận <b>{0}</b>, nhận lại <b>{1} đ</b>.";
            public const string UnderOverBetDrawRefund = "Hòa cược <b>TÀI XỈU</b> trận <b>{0}</b>, nhận lại <b>{1} đ</b>.";
            public const string UnderOverBetLoseRefund = "Thua cược <b>TÀI XỈU</b> trận <b>{0}</b>, nhận lại <b>{1} đ</b>.";
            public const string UnderOverBetLose = "Thua cược <b>TÀI XỈU</b> trận <b>{0}</b>.";
        }
    }
}

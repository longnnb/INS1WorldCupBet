using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.ViewModels
{
    public class BetViewModel
    {
        public int UserId { get; set; }
        public int MatchId { get; set; }
        public int BetStatus { get; set; }
        public int UserBalance { get; set; }
        public int BetAmount { get; set; }
        public bool IsLocked { get; set; }
        public string Result { get; set; }
    }

    public class TeamBetViewModel : BetViewModel
    {
        public int BetTeam { get; set; }
    }

    public class ScoreBetViewModel : BetViewModel
    {
        public List<int> BetScoreIdList { get; set; }
    }

    public class UnderOverBetViewModel : BetViewModel
    {
        public int BetSide { get; set; } //use BetTeam column in Bets, 1 for Under, 2 for Over
    }
}

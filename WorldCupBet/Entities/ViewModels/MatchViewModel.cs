using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.ViewModels
{
    public class MatchViewModel
    {
        public int MatchId { get; set; }
        [DisplayName("Vòng đấu")]
        public string MatchRound { get; set; }
        [DisplayName("Mã đội 1")]
        public string Team1Code { get; set; }
        [DisplayName("Tên đội 1")]
        public string Team1Name { get; set; }
        [DisplayName("Mã đội 2")]
        public string Team2Code { get; set; }
        [DisplayName("Tên đội 2")]
        public string Team2Name { get; set; }
        [DisplayName("Tỉ số đội 1")]
        public int? Score1 { get; set; }
        [DisplayName("Tỉ số đội 2")]
        public int? Score2 { get; set; }
        [DisplayName("Tỉ lệ chấp 1")]
        public double? Odds1 { get; set; }
        [DisplayName("Tỉ lệ chấp 2")]
        public double? Odds2 { get; set; }
        [DisplayName("Tỉ lệ trả 1")]
        public double? PaidRate1 { get; set; }
        [DisplayName("Tỉ lệ trả 2")]
        public double? PaidRate2 { get; set; }
        [DisplayName("Thời gian")]
        public DateTime MatchTime { get; set; }
        [DisplayName("Đội thắng")]
        public int? WinTeam { get; set; }
        [DisplayName("Kèo tài xỉu")]
        public double? UnderOverGoals { get; set; }
        [DisplayName("Tỉ lệ trả xỉu")]
        public double? UnderOverPaidRate1 { get; set; }
        [DisplayName("Tỉ lệ trả tài")]
        public double? UnderOverPaidRate2 { get; set; }
        [DisplayName("Kq tài xỉu")]
        public int? UnderOverResult { get; set; }
        [DisplayName("KT đặt kèo")]
        public bool IsStarted { get; set; }
        [DisplayName("KT trận đấu")]
        public bool IsFinished { get; set; }
        [DisplayName("Khóa đặt kèo")]
        public bool IsBetLocked { get; set; }
        public List<ScoreBetItem> ScoreBetList { get; set; }
    }

    public class ScoreBetItem
    {
        public int MatchId { get; set; }
        public int ScoreId { get; set; }
        public int Score1 { get; set; }
        public int Score2 { get; set; }
        public double PaidRate { get; set; }
    }
}

namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ScoreBet
    {
        public int ScoreBetId { get; set; }

        public int MatchId { get; set; }

        public int ScoreId { get; set; }

        public int Score1 { get; set; }

        public int Score2 { get; set; }

        public bool IsRightScore { get; set; }

        public double PaidRate { get; set; }

        public bool IsLocked { get; set; }
    }
}

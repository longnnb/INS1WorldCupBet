namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class UnderOverBet
    {
        public int UnderOverBetId { get; set; }

        public int MatchId { get; set; }

        public double? TotalGoalsBet { get; set; }

        public int? Result { get; set; }

        public double? PaidRate1 { get; set; }

        public double? PaidRate2 { get; set; }

        public bool IsLocked { get; set; }
    }
}

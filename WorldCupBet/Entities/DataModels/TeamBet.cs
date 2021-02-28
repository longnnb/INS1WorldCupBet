namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TeamBet
    {
        public int TeamBetId { get; set; }

        public int MatchId { get; set; }

        public double? Odds1 { get; set; }

        public double? Odds2 { get; set; }

        public double? PaidRate1 { get; set; }

        public double? PaidRate2 { get; set; }

        public int? WinTeam { get; set; }

        public bool IsLocked { get; set; }
    }
}

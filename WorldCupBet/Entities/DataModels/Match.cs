namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Match
    {
        public int MatchId { get; set; }

        [StringLength(10)]
        public string MatchRound { get; set; }

        [Required]
        [StringLength(5)]
        public string TeamCode1 { get; set; }

        [Required]
        [StringLength(5)]
        public string TeamCode2 { get; set; }

        public int? Score1 { get; set; }

        public int? Score2 { get; set; }

        public DateTime MatchTime { get; set; }

        public bool IsStarted { get; set; }

        public bool IsFinished { get; set; }
    }
}

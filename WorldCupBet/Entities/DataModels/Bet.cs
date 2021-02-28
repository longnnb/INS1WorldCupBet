namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Bet
    {
        public int Id { get; set; }

        public int BetId { get; set; }

        public int BetType { get; set; }

        public int MatchId { get; set; }

        public int UserId { get; set; }

        public int BetTeam { get; set; }

        public int Amount { get; set; }

        public int Status { get; set; }

        public bool IsLocked { get; set; }

        public DateTime? Created { get; set; }

        public DateTime? Updated { get; set; }
    }
}

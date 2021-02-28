namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ActivityLog
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        public int? MatchId { get; set; }

        public int? BetType { get; set; }

        public string Content { get; set; }

        public DateTime? Created { get; set; }
    }
}

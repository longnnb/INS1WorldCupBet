namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ChampionBet
    {
        public int Id { get; set; }

        public int? UserId { get; set; }

        [StringLength(5)]
        public string TeamCode { get; set; }

        public DateTime? Created { get; set; }
    }
}

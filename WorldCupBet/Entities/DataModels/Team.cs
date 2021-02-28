namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Team
    {
        public int TeamId { get; set; }

        [Required]
        [StringLength(5)]
        public string TeamCode { get; set; }

        [Required]
        [StringLength(50)]
        public string TeamName { get; set; }

        [Required]
        [StringLength(1)]
        public string Group { get; set; }

        public bool IsOut { get; set; }
    }
}

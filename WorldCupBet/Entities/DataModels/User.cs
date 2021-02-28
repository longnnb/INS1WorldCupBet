namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class User
    {
        public int UserId { get; set; }

        [Required]
        [StringLength(50)]
        public string Username { get; set; }

        [StringLength(50)]
        public string Fullname { get; set; }

        public int UserRole { get; set; }

        public bool IsFirstLogin { get; set; }

        public DateTime? Created { get; set; }
    }
}

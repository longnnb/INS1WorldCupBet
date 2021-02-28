namespace Entities.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class UserTransaction
    {
        [Key]
        public int TransactionId { get; set; }

        public int UserId { get; set; }

        public int? MatchId { get; set; }

        public int TransactionType { get; set; }

        public int Amount { get; set; }

        public DateTime? Created { get; set; }
    }
}

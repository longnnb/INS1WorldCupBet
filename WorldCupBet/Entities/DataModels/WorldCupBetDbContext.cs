namespace Entities.DataModels
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class WorldCupBetDbContext : DbContext
    {
        public WorldCupBetDbContext()
            : base("name=WorldCupBetDbContext")
        {
        }

        public virtual DbSet<Bet> Bets { get; set; }
        public virtual DbSet<Credential> Credentials { get; set; }
        public virtual DbSet<Match> Matches { get; set; }
        public virtual DbSet<ScoreBet> ScoreBets { get; set; }
        public virtual DbSet<UnderOverBet> UnderOverBets { get; set; }
        public virtual DbSet<TeamBet> TeamBets { get; set; }
        public virtual DbSet<Team> Teams { get; set; }
        public virtual DbSet<UserAccount> UserAccounts { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UserTransaction> UserTransactions { get; set; }
        public virtual DbSet<ActivityLog> ActivityLogs { get; set; }
        public virtual DbSet<ChampionBet> ChampionBets { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Match>()
                .Property(e => e.TeamCode1)
                .IsUnicode(false);

            modelBuilder.Entity<Match>()
                .Property(e => e.TeamCode2)
                .IsUnicode(false);

            modelBuilder.Entity<Team>()
                .Property(e => e.TeamCode)
                .IsUnicode(false);

            modelBuilder.Entity<Team>()
                .Property(e => e.Group)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<ChampionBet>()
                .Property(e => e.TeamCode)
                .IsUnicode(false);
        }
    }
}

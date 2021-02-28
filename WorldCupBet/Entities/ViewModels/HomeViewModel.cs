using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.DataModels;

namespace Entities.ViewModels
{
    public class HomeViewModel
    {
        public List<MatchViewModel> Matches { get; set; }
        public int Balance { get; set; }
        public int UserId { get; set; }
        public List<Team> AliveTeams { get; set; }
        public string ChampionTeamBet { get; set; }
    }
}

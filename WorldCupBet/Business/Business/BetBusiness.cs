using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common;
using Entities;
using Entities.SessionModels;
using Entities.ViewModels;
using Entities.DataModels;
using System.Data.Entity;

namespace Business
{
    public class BetBusiness : BaseBusiness
    {
        #region public methods
        public MatchViewModel GetMatch(int matchId)
        {
            var teams = from t in dbContext.Teams
                        select new
                        {
                            t.TeamCode,
                            t.TeamName
                        };

            var match = (from m in dbContext.Matches
                         join tb in dbContext.TeamBets
                         on m.MatchId equals tb.MatchId
                         join uob in dbContext.UnderOverBets
                         on m.MatchId equals uob.MatchId
                         where m.MatchId == matchId
                         select new MatchViewModel()
                         {
                             MatchId = m.MatchId,
                             MatchRound = m.MatchRound,
                             Team1Code = m.TeamCode1,
                             Team2Code = m.TeamCode2,
                             Team1Name = (from t in teams where t.TeamCode == m.TeamCode1 select t.TeamName).FirstOrDefault(),
                             Team2Name = (from t in teams where t.TeamCode == m.TeamCode2 select t.TeamName).FirstOrDefault(),
                             Score1 = m.Score1,
                             Score2 = m.Score2,
                             Odds1 = tb.Odds1,
                             Odds2 = tb.Odds2,
                             PaidRate1 = tb.PaidRate1,
                             PaidRate2 = tb.PaidRate2,
                             MatchTime = m.MatchTime,
                             UnderOverGoals = uob.TotalGoalsBet,
                             UnderOverPaidRate1 = uob.PaidRate1,
                             UnderOverPaidRate2 = uob.PaidRate2,
                             UnderOverResult = uob.Result,
                             IsStarted = m.IsStarted,
                             IsFinished = m.IsFinished,
                             IsBetLocked = tb.IsLocked
                         }).FirstOrDefault();

            return match;
        }

        public List<MatchViewModel> GetMatches()
        {
            this.LockBet();

            var teams = from t in dbContext.Teams
                        select new
                        {
                            t.TeamCode,
                            t.TeamName
                        };

            var matches = (from m in dbContext.Matches
                           join tb in dbContext.TeamBets
                           on m.MatchId equals tb.MatchId
                           join uob in dbContext.UnderOverBets
                           on m.MatchId equals uob.MatchId
                           select new MatchViewModel()
                           {
                               MatchId = m.MatchId,
                               MatchRound = m.MatchRound,
                               Team1Code = m.TeamCode1,
                               Team2Code = m.TeamCode2,
                               Team1Name = (from t in teams where t.TeamCode == m.TeamCode1 select t.TeamName).FirstOrDefault(),
                               Team2Name = (from t in teams where t.TeamCode == m.TeamCode2 select t.TeamName).FirstOrDefault(),
                               Score1 = m.Score1,
                               Score2 = m.Score2,
                               Odds1 = tb.Odds1,
                               Odds2 = tb.Odds2,
                               PaidRate1 = tb.PaidRate1,
                               PaidRate2 = tb.PaidRate2,
                               MatchTime = m.MatchTime,
                               WinTeam = tb.WinTeam,
                               UnderOverGoals = uob.TotalGoalsBet,
                               UnderOverPaidRate1 = uob.PaidRate1,
                               UnderOverPaidRate2 = uob.PaidRate2,
                               UnderOverResult = uob.Result,
                               IsStarted = m.IsStarted,
                               IsFinished = m.IsFinished,
                               IsBetLocked = tb.IsLocked
                           });

            //foreach (var match in matches)
            //{
            //    var scoreBetItem = dbContext.ScoreBets.Where(x => x.MatchId == match.MatchId).Select(x => new ScoreBetItem
            //    {
            //        MatchId = x.MatchId,
            //        Score1 = x.Score1,
            //        Score2 = x.Score2,
            //        ScoreId = x.ScoreId,
            //        PaidRate = x.PaidRate
            //    });
            //    if (scoreBetItem != null && scoreBetItem.Count() > 0)
            //    {
            //        match.ScoreBetList = scoreBetItem.ToList();
            //    }
            //}

            return matches.ToList();
        }

        public TeamBetViewModel GetTeamBetInfo(int matchId, int userId = 0)
        {
            this.LockBet();

            var isLockBet = this.CheckLockedBet(matchId);

            if (userId == 0)
            {
                return new TeamBetViewModel
                {
                    IsLocked = isLockBet
                };
            }

            var bet = dbContext.Bets.FirstOrDefault(b => b.UserId == userId && b.MatchId == matchId && b.BetType == (int)Enums.BetTypes.TeamBet);
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == userId);
            if (bet == null)
            {
                return new TeamBetViewModel
                {
                    BetStatus = 0,
                    UserBalance = userAccount.Balance,
                    IsLocked = isLockBet
                };
            }

            return new TeamBetViewModel
            {
                UserId = userId,
                MatchId = matchId,
                BetAmount = bet.Amount,
                BetStatus = bet.Status,
                BetTeam = bet.BetTeam,
                UserBalance = userAccount.Balance,
                IsLocked = isLockBet
            };
        }

        public TeamBetViewModel TeamBet(TeamBetViewModel model)
        {
            this.LockBet();
            var isLockBet = this.CheckLockedBet(model.MatchId);
            if (isLockBet)
            {
                model.Result = Constants.ReturnMessages.LockedMatch;
                model.IsLocked = true;
                return model;
            }
            var isValidTeamBet = this.CheckValidTeamBet(model);
            if (!isValidTeamBet)
            {
                model.Result = Constants.ReturnMessages.DataNotValid;
                return model;
            }

            var match = GetMatch(model.MatchId);
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == model.UserId);
            model.UserBalance = userAccount.Balance;

            var isBetExist = dbContext.Bets.Any(b => b.UserId == model.UserId && b.MatchId == model.MatchId && b.BetType == (int)Enums.BetTypes.TeamBet);
            if (!isBetExist)
            {
                bool isEnoughBalance = model.UserBalance >= model.BetAmount;
                if (isEnoughBalance)
                {
                    TransactionBusiness transactionBusiness = new TransactionBusiness();
                    model.UserBalance = transactionBusiness.Bet(model.UserId, model.BetAmount, model.MatchId);

                    dbContext.ActivityLogs.Add(new ActivityLog()
                    {
                        MatchId = model.MatchId,
                        UserId = model.UserId,
                        Created = DateTime.Now,
                        Content = string.Format(Constants.StringFormat.TeamBet, match.Team1Name + " - " + match.Team2Name,
                        model.BetTeam == 1 ? match.Team1Name : match.Team2Name, model.BetAmount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                        BetType = (int)Enums.BetTypes.TeamBet
                    });
                }

                dbContext.Bets.Add(new Bet
                {
                    BetId = dbContext.TeamBets.Where(x => x.MatchId == model.MatchId).Select(x => x.TeamBetId).FirstOrDefault(),
                    BetType = (int)Enums.BetTypes.TeamBet,
                    MatchId = model.MatchId,
                    UserId = model.UserId,
                    BetTeam = model.BetTeam,
                    Amount = model.BetAmount,
                    Status = isEnoughBalance ? (int)Enums.BetStatus.Accepted : (int)Enums.BetStatus.Pending,
                    IsLocked = false,
                    Created = DateTime.Now,
                    Updated = DateTime.Now
                });


                dbContext.SaveChanges();

                model.Result = Constants.ReturnMessages.Successful;
            }
            else
            {
                var teamBet = dbContext.Bets.FirstOrDefault(b => b.UserId == model.UserId && b.MatchId == model.MatchId && b.BetType == (int)Enums.BetTypes.TeamBet);
                if (teamBet.Status == (int)Enums.BetStatus.Pending)
                {
                    bool isEnoughBalance = model.UserBalance >= model.BetAmount;
                    if (isEnoughBalance)
                    {
                        TransactionBusiness transactionBusiness = new TransactionBusiness();
                        model.UserBalance = transactionBusiness.Bet(model.UserId, model.BetAmount, model.MatchId);
                        teamBet.Status = (int)Enums.BetStatus.Accepted;
                        dbContext.Entry(teamBet).State = System.Data.Entity.EntityState.Modified;

                        dbContext.ActivityLogs.Add(new ActivityLog()
                        {
                            MatchId = model.MatchId,
                            UserId = model.UserId,
                            Created = DateTime.Now,
                            Content = string.Format(Constants.StringFormat.TeamBet, match.Team1Name + " - " + match.Team2Name,
                            model.BetTeam == 1 ? match.Team1Name : match.Team2Name, model.BetAmount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                            BetType = (int)Enums.BetTypes.TeamBet
                        });

                        dbContext.SaveChanges();
                        model.Result = Constants.ReturnMessages.Successful;
                    }
                    else
                    {
                        model.Result = Constants.ReturnMessages.NotEnoughMoney;
                    }
                }
            }

            var updatedTeamBet = dbContext.Bets.FirstOrDefault(b => b.UserId == model.UserId && b.MatchId == model.MatchId && b.BetType == (int)Enums.BetTypes.TeamBet);
            model.BetStatus = updatedTeamBet.Status;

            return model;
        }

        public string PayBet(int matchId)
        {
            var tb = PayTeamBet(matchId);
            var uob = PayUnderOverBet(matchId);
            if (tb == Constants.ReturnMessages.Successful && uob == Constants.ReturnMessages.Successful)
            {
                return Constants.ReturnMessages.Successful;
            }
            else
            {
                return Constants.ReturnMessages.Fail;
            }
        }

        public string PayTeamBet(int matchId)
        {
            var teamBet = dbContext.TeamBets.FirstOrDefault(x => x.MatchId == matchId);
            var match = GetMatch(matchId);
            if (match.Score1 == null || match.Score2 == null)
            {
                return Constants.ReturnMessages.Fail;
            }

            int winTeam = 0;
            var calScore1 = match.Score1 + teamBet.Odds1;
            var calScore2 = match.Score2 + teamBet.Odds2;

            bool payHalf = false;
            double paidMultiple = 1;

            if (calScore1 > calScore2) //team1 win
            {
                winTeam = 1;
                if (calScore1 - calScore2 == 0.25)
                {
                    payHalf = true;
                    paidMultiple = 0.5;
                }
            }
            else if (calScore2 > calScore1) //team2 win
            {
                winTeam = 2;
                if (calScore2 - calScore1 == 0.25)
                {
                    payHalf = true;
                    paidMultiple = 0.5;
                }
            }
            else //draw
            {
                teamBet.WinTeam = winTeam;
                dbContext.Entry(teamBet).State = EntityState.Modified;
                dbContext.SaveChanges();

                TransactionBusiness transactionBusiness = new TransactionBusiness();
                var drawBets = dbContext.Bets.Where(x => x.MatchId == matchId && x.BetType == (int)Enums.BetTypes.TeamBet
                                                && x.Status == (int)Enums.BetStatus.Accepted);

                foreach (var bet in drawBets)
                {
                    transactionBusiness.Refund(bet.UserId, bet.Amount, matchId);

                    bet.Status = (int)Enums.BetStatus.Draw;
                    dbContext.Entry(bet).State = EntityState.Modified;

                    dbContext.ActivityLogs.Add(new ActivityLog()
                    {
                        MatchId = matchId,
                        UserId = bet.UserId,
                        Created = DateTime.Now,
                        Content = string.Format(Constants.StringFormat.TeamBetDrawRefund, match.Team1Name + " - " + match.Team2Name, bet.Amount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                        BetType = (int)Enums.BetTypes.TeamBet
                    });
                }
                dbContext.SaveChanges();

                return Constants.ReturnMessages.Successful;
            }

            teamBet.WinTeam = winTeam;
            dbContext.Entry(teamBet).State = EntityState.Modified;
            dbContext.SaveChanges();

            TransactionBusiness business = new TransactionBusiness();
            var winBets = dbContext.Bets.Where(x => x.MatchId == matchId && x.BetType == (int)Enums.BetTypes.TeamBet
                                            && x.Status == (int)Enums.BetStatus.Accepted && x.BetTeam == winTeam);
            foreach (var bet in winBets)
            {
                int refundAmout = 0;
                if (winTeam == 1)
                {
                    refundAmout = (int)(bet.Amount + bet.Amount * teamBet.PaidRate1 * paidMultiple);
                }
                else if (winTeam == 2)
                {
                    refundAmout = (int)(bet.Amount + bet.Amount * teamBet.PaidRate2 * paidMultiple);
                }
                business.Refund(bet.UserId, refundAmout, matchId);

                bet.Status = (int)Enums.BetStatus.Paid;
                dbContext.Entry(bet).State = EntityState.Modified;

                dbContext.ActivityLogs.Add(new ActivityLog()
                {
                    MatchId = matchId,
                    UserId = bet.UserId,
                    Created = DateTime.Now,
                    Content = string.Format(Constants.StringFormat.TeamBetWinRefund, match.Team1Name + " - " + match.Team2Name, refundAmout.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                    BetType = (int)Enums.BetTypes.TeamBet
                });
            }

            var loseBets = dbContext.Bets.Where(x => x.MatchId == matchId && x.BetType == (int)Enums.BetTypes.TeamBet
                                            && x.Status == (int)Enums.BetStatus.Accepted && x.BetTeam != winTeam);
            foreach (var bet in loseBets)
            {
                if (payHalf)
                {
                    int refundAmout = (int)(bet.Amount * paidMultiple);
                    business.Refund(bet.UserId, refundAmout, matchId);

                    dbContext.ActivityLogs.Add(new ActivityLog()
                    {
                        MatchId = matchId,
                        UserId = bet.UserId,
                        Created = DateTime.Now,
                        Content = string.Format(Constants.StringFormat.TeamBetLoseRefund, match.Team1Name + " - " + match.Team2Name, refundAmout.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                        BetType = (int)Enums.BetTypes.TeamBet
                    });
                }
                else
                {
                    dbContext.ActivityLogs.Add(new ActivityLog()
                    {
                        MatchId = matchId,
                        UserId = bet.UserId,
                        Created = DateTime.Now,
                        Content = string.Format(Constants.StringFormat.TeamBetLose, match.Team1Name + " - " + match.Team2Name),
                        BetType = (int)Enums.BetTypes.TeamBet
                    });
                }
                bet.Status = (int)Enums.BetStatus.Lose;
                dbContext.Entry(bet).State = EntityState.Modified;
            }

            dbContext.SaveChanges();

            return Constants.ReturnMessages.Successful;
        }

        public ScoreBetViewModel GetScoreBetInfo(int matchId, int userId = 0)
        {
            this.LockBet();

            var isLockBet = this.CheckLockedBet(matchId);

            if (userId == 0)
            {
                return new ScoreBetViewModel
                {
                    IsLocked = isLockBet
                };
            }

            var userScoreBets = dbContext.Bets.Where(b => b.UserId == userId && b.MatchId == matchId && b.BetType == (int)Enums.BetTypes.ScoreBet);
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == userId);
            if (userScoreBets != null && userScoreBets.Count() > 0)
            {
                return new ScoreBetViewModel
                {
                    UserId = userId,
                    MatchId = matchId,
                    BetStatus = userScoreBets.Select(x => x.Status).FirstOrDefault(),
                    BetScoreIdList = userScoreBets.Select(x => x.BetTeam).ToList(),
                    UserBalance = userAccount.Balance,
                    IsLocked = isLockBet
                };
            }
            else
            {
                return new ScoreBetViewModel
                {
                    BetStatus = 0,
                    UserBalance = userAccount.Balance,
                    IsLocked = isLockBet
                };
            }
        }

        public UnderOverBetViewModel GetUnderOverBetInfo(int matchId, int userId = 0)
        {
            this.LockBet();

            var isLockBet = this.CheckLockedBet(matchId);

            if (userId == 0)
            {
                return new UnderOverBetViewModel
                {
                    IsLocked = isLockBet
                };
            }

            var bet = dbContext.Bets.FirstOrDefault(b => b.UserId == userId && b.MatchId == matchId && b.BetType == (int)Enums.BetTypes.UnderOverBet);
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == userId);
            if (bet == null)
            {
                return new UnderOverBetViewModel
                {
                    BetStatus = 0,
                    UserBalance = userAccount.Balance,
                    IsLocked = isLockBet
                };
            }

            return new UnderOverBetViewModel
            {
                UserId = userId,
                MatchId = matchId,
                BetAmount = bet.Amount,
                BetStatus = bet.Status,
                BetSide = bet.BetTeam,
                UserBalance = userAccount.Balance,
                IsLocked = isLockBet
            };
        }

        public UnderOverBetViewModel UnderOverBet(UnderOverBetViewModel model)
        {
            this.LockBet();
            var isLockBet = this.CheckLockedBet(model.MatchId);
            if (isLockBet)
            {
                model.Result = Constants.ReturnMessages.LockedMatch;
                model.IsLocked = true;
                return model;
            }
            var isValidBet = this.CheckValidUnderOverBet(model);
            if (!isValidBet)
            {
                model.Result = Constants.ReturnMessages.DataNotValid;
                return model;
            }

            var match = GetMatch(model.MatchId);
            var userAccount = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == model.UserId);
            model.UserBalance = userAccount.Balance;

            var isBetExist = dbContext.Bets.Any(b => b.UserId == model.UserId && b.MatchId == model.MatchId && b.BetType == (int)Enums.BetTypes.UnderOverBet);
            if (!isBetExist)
            {
                bool isEnoughBalance = model.UserBalance >= model.BetAmount;
                if (isEnoughBalance)
                {
                    TransactionBusiness transactionBusiness = new TransactionBusiness();
                    model.UserBalance = transactionBusiness.Bet(model.UserId, model.BetAmount, model.MatchId);

                    dbContext.ActivityLogs.Add(new ActivityLog()
                    {
                        MatchId = model.MatchId,
                        UserId = model.UserId,
                        Created = DateTime.Now,
                        Content = string.Format(Constants.StringFormat.UnderOverBet, match.Team1Name + " - " + match.Team2Name,
                        model.BetSide == 1 ? "XỈU" : "TÀI", model.BetAmount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                        BetType = (int)Enums.BetTypes.UnderOverBet
                    });
                }

                dbContext.Bets.Add(new Bet
                {
                    BetId = dbContext.UnderOverBets.Where(x => x.MatchId == model.MatchId).Select(x => x.UnderOverBetId).FirstOrDefault(),
                    BetType = (int)Enums.BetTypes.UnderOverBet,
                    MatchId = model.MatchId,
                    UserId = model.UserId,
                    BetTeam = model.BetSide,
                    Amount = model.BetAmount,
                    Status = isEnoughBalance ? (int)Enums.BetStatus.Accepted : (int)Enums.BetStatus.Pending,
                    IsLocked = false,
                    Created = DateTime.Now,
                    Updated = DateTime.Now
                });


                dbContext.SaveChanges();

                model.Result = Constants.ReturnMessages.Successful;
            }
            else
            {
                var underOverBet = dbContext.Bets.FirstOrDefault(b => b.UserId == model.UserId && b.MatchId == model.MatchId && b.BetType == (int)Enums.BetTypes.UnderOverBet);
                if (underOverBet.Status == (int)Enums.BetStatus.Pending)
                {
                    bool isEnoughBalance = model.UserBalance >= model.BetAmount;
                    if (isEnoughBalance)
                    {
                        TransactionBusiness transactionBusiness = new TransactionBusiness();
                        model.UserBalance = transactionBusiness.Bet(model.UserId, model.BetAmount, model.MatchId);
                        underOverBet.Status = (int)Enums.BetStatus.Accepted;
                        dbContext.Entry(underOverBet).State = System.Data.Entity.EntityState.Modified;

                        dbContext.ActivityLogs.Add(new ActivityLog()
                        {
                            MatchId = model.MatchId,
                            UserId = model.UserId,
                            Created = DateTime.Now,
                            Content = string.Format(Constants.StringFormat.UnderOverBet, match.Team1Name + " - " + match.Team2Name,
                            model.BetSide == 1 ? "XỈU" : "TÀI", model.BetAmount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                            BetType = (int)Enums.BetTypes.UnderOverBet
                        });

                        dbContext.SaveChanges();
                        model.Result = Constants.ReturnMessages.Successful;
                    }
                    else
                    {
                        model.Result = Constants.ReturnMessages.NotEnoughMoney;
                    }
                }
            }

            var updatedUnderOverBet = dbContext.Bets.FirstOrDefault(b => b.UserId == model.UserId && b.MatchId == model.MatchId && b.BetType == (int)Enums.BetTypes.UnderOverBet);
            model.BetStatus = updatedUnderOverBet.Status;

            return model;
        }

        public string PayUnderOverBet(int matchId)
        {
            var uoBet = dbContext.UnderOverBets.FirstOrDefault(x => x.MatchId == matchId);
            var match = GetMatch(matchId);
            if (match.Score1 == null || match.Score2 == null)
            {
                return Constants.ReturnMessages.Fail;
            }

            int winSide = 0;
            var totalScore = match.Score1 + match.Score2;

            bool payHalf = false;
            double paidMultiple = 1;

            if (totalScore < uoBet.TotalGoalsBet) //under win
            {
                winSide = 1;
                if (uoBet.TotalGoalsBet - totalScore == 0.25)
                {
                    payHalf = true;
                    paidMultiple = 0.5;
                }
            }
            else if (totalScore > uoBet.TotalGoalsBet) //over win
            {
                winSide = 2;
                if (totalScore - uoBet.TotalGoalsBet == 0.25)
                {
                    payHalf = true;
                    paidMultiple = 0.5;
                }
            }
            else //draw
            {
                uoBet.Result = winSide;
                dbContext.Entry(uoBet).State = EntityState.Modified;
                dbContext.SaveChanges();

                TransactionBusiness transactionBusiness = new TransactionBusiness();
                var drawBets = dbContext.Bets.Where(x => x.MatchId == matchId && x.BetType == (int)Enums.BetTypes.UnderOverBet
                                                && x.Status == (int)Enums.BetStatus.Accepted);

                foreach (var bet in drawBets)
                {
                    transactionBusiness.Refund(bet.UserId, bet.Amount, matchId);

                    bet.Status = (int)Enums.BetStatus.Draw;
                    dbContext.Entry(bet).State = EntityState.Modified;

                    dbContext.ActivityLogs.Add(new ActivityLog()
                    {
                        MatchId = matchId,
                        UserId = bet.UserId,
                        Created = DateTime.Now,
                        Content = string.Format(Constants.StringFormat.UnderOverBetDrawRefund, match.Team1Name + " - " + match.Team2Name, bet.Amount.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                        BetType = (int)Enums.BetTypes.UnderOverBet
                    });
                }
                dbContext.SaveChanges();

                return Constants.ReturnMessages.Successful;
            }

            uoBet.Result = winSide;
            dbContext.Entry(uoBet).State = EntityState.Modified;
            dbContext.SaveChanges();

            TransactionBusiness business = new TransactionBusiness();
            var winBets = dbContext.Bets.Where(x => x.MatchId == matchId && x.BetType == (int)Enums.BetTypes.UnderOverBet
                                            && x.Status == (int)Enums.BetStatus.Accepted && x.BetTeam == winSide);
            foreach (var bet in winBets)
            {
                int refundAmout = 0;
                if (winSide == 1)
                {
                    refundAmout = (int)(bet.Amount + bet.Amount * uoBet.PaidRate1 * paidMultiple);
                }
                else if (winSide == 2)
                {
                    refundAmout = (int)(bet.Amount + bet.Amount * uoBet.PaidRate2 * paidMultiple);
                }
                business.Refund(bet.UserId, refundAmout, matchId);

                bet.Status = (int)Enums.BetStatus.Paid;
                dbContext.Entry(bet).State = EntityState.Modified;

                dbContext.ActivityLogs.Add(new ActivityLog()
                {
                    MatchId = matchId,
                    UserId = bet.UserId,
                    Created = DateTime.Now,
                    Content = string.Format(Constants.StringFormat.UnderOverBetWinRefund, match.Team1Name + " - " + match.Team2Name, refundAmout.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                    BetType = (int)Enums.BetTypes.UnderOverBet
                });
            }

            var loseBets = dbContext.Bets.Where(x => x.MatchId == matchId && x.BetType == (int)Enums.BetTypes.UnderOverBet
                                            && x.Status == (int)Enums.BetStatus.Accepted && x.BetTeam != winSide);
            foreach (var bet in loseBets)
            {
                if (payHalf)
                {
                    int refundAmout = (int)(bet.Amount * paidMultiple);
                    business.Refund(bet.UserId, refundAmout, matchId);

                    dbContext.ActivityLogs.Add(new ActivityLog()
                    {
                        MatchId = matchId,
                        UserId = bet.UserId,
                        Created = DateTime.Now,
                        Content = string.Format(Constants.StringFormat.UnderOverBetLoseRefund, match.Team1Name + " - " + match.Team2Name, refundAmout.ToString("N0", System.Globalization.CultureInfo.CreateSpecificCulture("vi-VN"))),
                        BetType = (int)Enums.BetTypes.UnderOverBet
                    });
                }
                else
                {
                    dbContext.ActivityLogs.Add(new ActivityLog()
                    {
                        MatchId = matchId,
                        UserId = bet.UserId,
                        Created = DateTime.Now,
                        Content = string.Format(Constants.StringFormat.UnderOverBetLose, match.Team1Name + " - " + match.Team2Name),
                        BetType = (int)Enums.BetTypes.UnderOverBet
                    });
                }
                bet.Status = (int)Enums.BetStatus.Lose;
                dbContext.Entry(bet).State = EntityState.Modified;
            }

            dbContext.SaveChanges();

            return Constants.ReturnMessages.Successful;
        }

        public List<Team> GetAliveTeams()
        {
            return dbContext.Teams.Where(x => !x.IsOut).ToList();
        }

        public string ChampionBet(string teamCode)
        {
            var user = Utilities.GetCache<CurrentUser>(Constants.CacheKeys.CurrentUser);
            if (user == null)
            {
                return Constants.ReturnMessages.UserNotLogin;
            }
            if (dbContext.ChampionBets.Any(x => x.UserId == user.UserId))
            {
                return Constants.ReturnMessages.AlreadyBet;
            }
            if (user.Balance < 30000)
            {
                return Constants.ReturnMessages.NotEnoughMoney;
            }
            var team = dbContext.Teams.FirstOrDefault(x => x.TeamCode.Equals(teamCode));

            if (team == null)
            {
                return Constants.ReturnMessages.DataNotValid;
            }

            dbContext.ChampionBets.Add(new ChampionBet
            {
                UserId = user.UserId,
                TeamCode = teamCode,
                Created = DateTime.Now
            });

            var account = dbContext.UserAccounts.FirstOrDefault(x => x.UserId == user.UserId);
            account.Balance -= 30000;
            dbContext.Entry(account).State = EntityState.Modified;

            dbContext.ActivityLogs.Add(new ActivityLog
            {
                BetType = (int)Enums.BetTypes.ChampionBet,
                Content = string.Format("Đặt cược đội vô địch thành công, cược đội <b>{0}</b> vô địch.", team.TeamName),
                UserId = user.UserId,
                Created = DateTime.Now
            });
            dbContext.SaveChanges();

            return Constants.ReturnMessages.Successful;
        }
        #endregion

        #region private method
        private void LockBet()
        {
            var lockTime = DateTime.UtcNow.AddHours(7).AddMinutes(15);
            var lockMatches = dbContext.Matches.Where(x => !x.IsStarted && x.MatchTime <= lockTime);
            if (lockMatches.Count() > 0)
            {
                foreach (var match in lockMatches)
                {
                    match.IsStarted = true;
                    dbContext.Entry(match).State = EntityState.Modified;

                    var teamBet = dbContext.TeamBets.FirstOrDefault(x => x.MatchId == match.MatchId);
                    teamBet.IsLocked = true;
                    dbContext.Entry(teamBet).State = EntityState.Modified;

                    var underOverBet = dbContext.UnderOverBets.FirstOrDefault(x => x.MatchId == match.MatchId);
                    underOverBet.IsLocked = true;
                    dbContext.Entry(underOverBet).State = EntityState.Modified;

                    //var scoreBets = dbContext.ScoreBets.Where(x => x.MatchId == match.MatchId);
                    //foreach (var scoreBet in scoreBets)
                    //{
                    //    scoreBet.IsLocked = true;
                    //    dbContext.Entry(scoreBet).State = EntityState.Modified;
                    //}
                }
                dbContext.SaveChanges();
            }
        }

        private bool CheckLockedBet(int matchId)
        {
            var checkMatch = (from m in dbContext.Matches
                              join tb in dbContext.TeamBets
                              on m.MatchId equals tb.MatchId
                              where m.MatchId == matchId
                              select new
                              {
                                  isStarted = m.IsStarted,
                                  isFinished = m.IsFinished,
                                  isLocked = tb.IsLocked
                              }).FirstOrDefault();

            if (checkMatch.isStarted || checkMatch.isFinished || checkMatch.isLocked)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private bool CheckValidTeamBet(TeamBetViewModel model)
        {
            if ((model.BetTeam != 1 && model.BetTeam != 2) || model.BetAmount < Constants.BetAmout.TeamBet_MinAmount || model.BetAmount > Constants.BetAmout.TeamBet_MaxAmount)
            {
                return false;
            }
            return true;
        }

        private bool CheckValidUnderOverBet(UnderOverBetViewModel model)
        {
            if ((model.BetSide != 1 && model.BetSide != 2) || model.BetAmount < Constants.BetAmout.UnderOverBet_MinAmount || model.BetAmount > Constants.BetAmout.UnderOverBet_MaxAmount)
            {
                return false;
            }
            return true;
        }
        #endregion
    }
}

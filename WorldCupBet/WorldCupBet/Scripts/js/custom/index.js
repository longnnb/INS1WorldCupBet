$(() => {
    $(".sidenav").sidenav();
    $('.carousel.carousel-slider').carousel({
        fullWidth: true,
        indicators: true
    });

    $('.modal').modal();
    $('select').formSelect();

    $("#teamBet_betAmount").on('keyup', function () {
        var n = parseInt($(this).val().replace(/\D/g, ''), 10);
        if (!!n) {
            $(this).val(n.toLocaleString("it-IT"));
        }
        else {
            $(this).val("");
        }
    });

    $("#underOverBet_betAmount").on('keyup', function () {
        var n = parseInt($(this).val().replace(/\D/g, ''), 10);
        if (!!n) {
            $(this).val(n.toLocaleString("it-IT"));
        }
        else {
            $(this).val("");
        }
    });

    $("#teamBet_betBtn").click(function (event) {
        event.preventDefault();
        teamBet();
    })

    $("#underOverBet_betBtn").click(function (event) {
        event.preventDefault();
        underOverBet();
    })
});

//$(document).ready(function () {
//    $('.tooltipped').tooltip();
//});

function showTeambetModal(matchId) {

    var match = matches.find(x => x.MatchId == matchId);

    var teamBet_teamInfo = match.Team1Name + '&nbsp;<img src="/Content/images/flags/' + match.Team1Code + '.png" class="teamBet_teamFlag">'
        + ' &nbsp; vs. &nbsp; <img src="/Content/images/flags/' + match.Team2Code + '.png" class="teamBet_teamFlag">&nbsp;' + match.Team2Name;
    $('#teamBet_teamInfo').html(teamBet_teamInfo);
    $('#teamBet_team1').text(match.Team1Name);
    $('#teamBet_team2').text(match.Team2Name);
    $('#teamBet_matchId').val(match.MatchId);
    $('#teamBet_Odds').text(match.Odds1 + ' : ' + match.Odds2);
    var oddsExplain = '';
    if (match.Odds1 > match.Odds2) {
        oddsExplain = '(' + match.Team2Name + ' chấp ' + match.Team1Name + ' <b>' + match.Odds1 + '</b> trái.)';
    }
    else if (match.Odds2 > match.Odds1) {
        oddsExplain = '(' + match.Team1Name + ' chấp ' + match.Team2Name + ' <b>' + match.Odds2 + '</b> trái.)';
    }
    else {
        oddsExplain = '(Đồng banh. Không chấp.)';
    }
    $('#teamBet_explainOdds').html(oddsExplain);
    $('#teamBet_paidRate1').text('(1 ăn ' + match.PaidRate1 + ')');
    $('#teamBet_paidRate2').text('(1 ăn ' + match.PaidRate2 + ')');

    $.ajax({
        url: "/Bet/GetTeamBetInfo",
        type: "POST",
        data: {
            matchId: match.MatchId
        },
        success: function (data) {
            setTeambetArea(data);
        }
    });
}

function showUnderOverBetModal(matchId) {
    var match = matches.find(x => x.MatchId == matchId);
    var underOverBet_teamInfo = match.Team1Name + '&nbsp;<img src="/Content/images/flags/' + match.Team1Code + '.png" class="teamBet_teamFlag">'
        + ' &nbsp; vs. &nbsp; <img src="/Content/images/flags/' + match.Team2Code + '.png" class="teamBet_teamFlag">&nbsp;' + match.Team2Name;
    $('#underOverBet_teamInfo').html(underOverBet_teamInfo);
    $('#underOverBet_matchId').val(match.MatchId);
    $('[push-data="underOverBet_BetGoals"]').text(match.UnderOverGoals);
    $('#underOverBet_paidRate1').text('(1 ăn ' + match.UnderOverPaidRate1 + ')');
    $('#underOverBet_paidRate2').text('(1 ăn ' + match.UnderOverPaidRate2 + ')');
    $.ajax({
        url: "/Bet/GetUnderOverBetInfo",
        type: "POST",
        data: {
            matchId: match.MatchId
        },
        success: function (data) {
            setUnderOverBetArea(data);
        }
    });
}

function teamBet() {
    if ($('#userId').val() == 0) {
        var lgConfirm = confirm("Vui lòng đăng nhập!");
        if (lgConfirm) {
            window.location.href = "/Home/Login";
        }
        return false;
    }

    var betStatus = $('#teamBet_betStatus').val();
    if (betStatus == 0) {
        teamBet_firstBet();
    }
    else if (betStatus == 1) {
        teamBet_addMoney();
    }
}

function teamBet_firstBet() {
    var MatchId = $('#teamBet_matchId').val();
    var BetAmount = parseInt($('#teamBet_betAmount').val().replace(/\D/g, ''), 10);
    var BetTeam = $('input[name=BetTeam]:checked').val();
    if (!BetTeam) {
        alert("Chọn đội bóng muốn đặt cược!");
        return false;
    }
    else if (!BetAmount) {
        $('#teamBet_betAmount').val("");
        $('#teamBet_betAmount').focus();
        alert("Nhập số tiền cược (10.000 - 300.000 đ)");
        return false;
    }
    else if (BetAmount < 10000 || BetAmount > 300000) {
        $('#teamBet_betAmount').val(BetAmount);
        $('#teamBet_betAmount').focus();
        alert("Chỉ đặt cược từ 10.000 - 300.000 đ");
        return false;
    }

    var match = matches.find(x => x.MatchId == MatchId);
    var teamName = (BetTeam == 1) ? match.Team1Name : match.Team2Name;
    var confirmMessage = "Bạn muốn đặt cược cho đội " + teamName + " với số tiền " + $('#teamBet_betAmount').val() + " đ?";
    var cfResult = confirm(confirmMessage);

    if (!cfResult) {
        return false;
    }

    $.ajax({
        url: "/Bet/TeamBet",
        type: "POST",
        data: {
            MatchId: MatchId,
            BetAmount: BetAmount,
            BetTeam: BetTeam
        },
        success: function (data) {
            if (data.result == 'Successful') {
                setTeambetArea(data);
                alert("Đặt kèo thành công!");
            }
            else if (data.result == 'LockedMatch') {
                setTeambetArea(data);
                alert("Đã hết thời gian đặt kèo");
            }
            else if (data.result == 'DataNotValid') {
                alert("Data không hợp lệ. Vui lòng không chỉnh sửa data!");
            }
            else if (data.result == 'UserNotLogin') {
                var lgConfirm1 = confirm("Vui lòng đăng nhập!");
                if (lgConfirm1) {
                    window.location.href = "/Home/Login";
                }
            }
            else {
                alert("Something went wrong. Vui lòng thử lại.");
            }

        }
    });
}

function teamBet_addMoney() {
    var MatchId = $('#teamBet_matchId').val();
    var BetAmount = parseInt($('#teamBet_betAmount').val().replace(/\D/g, ''), 10);
    var BetTeam = $('input[name=BetTeam]:checked').val();

    if ($('#userBalance').val() < BetAmount) {
        alert("Bạn không có đủ tiền trong tài khoản. Vui lòng liên hệ nạp thêm!");
        return false;
    }

    $.ajax({
        url: "/Bet/TeamBet",
        type: "POST",
        data: {
            MatchId: MatchId,
            BetAmount: BetAmount,
            BetTeam: BetTeam
        },
        success: function (data) {
            if (data.result == 'Successful') {
                setTeambetArea(data);
                alert("Nhập tiền thành công!");
            }
            else if (data.result == 'LockedMatch') {
                $('#teamBetModal').find('input').prop('disabled', true);
                $("#teamBet_betBtn").prop('disabled', true);
                $("#teamBet_betBtn").html('Kết thúc đặt kèo<i class="material-icons right">lock</i>');
                alert("Đã hết thời gian đặt kèo");
            }
            else if (data.result == 'NotEnoughMoney') {
                alert("Bạn không có đủ tiền trong tài khoản. Vui lòng liên hệ nạp thêm!");
            }
            else {
                alert("Something went wrong. Vui lòng thử lại.");
            }
        }
    });
}

function underOverBet() {
    if ($('#userId').val() == 0) {
        var lgConfirm = confirm("Vui lòng đăng nhập!");
        if (lgConfirm) {
            window.location.href = "/Home/Login";
        }
        return false;
    }

    var betStatus = $('#underOverBet_betStatus').val();
    if (betStatus == 0) {
        underOverBet_firstBet();
    }
    else if (betStatus == 1) {
        underOverBet_addMoney();
    }
}

function underOverBet_firstBet() {
    var MatchId = $('#underOverBet_matchId').val();
    var BetAmount = parseInt($('#underOverBet_betAmount').val().replace(/\D/g, ''), 10);
    var BetSide = $('input[name=BetSide]:checked').val();
    if (!BetSide) {
        alert("Chọn cược TÀI hoặc XỈU!");
        return false;
    }
    else if (!BetAmount) {
        $('#underOverBet_betAmount').val("");
        $('#underOverBet_betAmount').focus();
        alert("Nhập số tiền cược (10.000 - 300.000 đ)");
        return false;
    }
    else if (BetAmount < 10000 || BetAmount > 300000) {
        $('#underOverBet_betAmount').val(BetAmount);
        $('#underOverBet_betAmount').focus();
        alert("Chỉ đặt cược từ 10.000 - 300.000 đ");
        return false;
    }

    var side = (BetSide == 1) ? "XỈU" : "TÀI";
    var confirmMessage = "Bạn muốn đặt cược " + side + " với số tiền " + $('#underOverBet_betAmount').val() + " đ?";
    var cfResult = confirm(confirmMessage);

    if (!cfResult) {
        return false;
    }

    $.ajax({
        url: "/Bet/UnderOverBet",
        type: "POST",
        data: {
            MatchId: MatchId,
            BetAmount: BetAmount,
            BetSide: BetSide
        },
        success: function (data) {
            if (data.result == 'Successful') {
                setUnderOverBetArea(data);
                alert("Đặt kèo thành công!");
            }
            else if (data.result == 'LockedMatch') {
                setUnderOverBetArea(data);
                alert("Đã hết thời gian đặt kèo");
            }
            else if (data.result == 'DataNotValid') {
                alert("Data không hợp lệ. Vui lòng không chỉnh sửa data!");
            }
            else if (data.result == 'UserNotLogin') {
                var lgConfirm1 = confirm("Vui lòng đăng nhập!");
                if (lgConfirm1) {
                    window.location.href = "/Home/Login";
                }
            }
            else {
                alert("Something went wrong. Vui lòng thử lại.");
            }

        }
    });
}

function underOverBet_addMoney() {
    var MatchId = $('#underOverBet_matchId').val();
    var BetAmount = parseInt($('#underOverBet_betAmount').val().replace(/\D/g, ''), 10);
    var BetSide = $('input[name=BetSide]:checked').val();

    if ($('#userBalance').val() < BetAmount) {
        alert("Bạn không có đủ tiền trong tài khoản. Vui lòng liên hệ nạp thêm!");
        return false;
    }

    $.ajax({
        url: "/Bet/UnderOverBet",
        type: "POST",
        data: {
            MatchId: MatchId,
            BetAmount: BetAmount,
            BetSide: BetSide
        },
        success: function (data) {
            if (data.result == 'Successful') {
                setUnderOverBetArea(data);
                alert("Nhập tiền thành công!");
            }
            else if (data.result == 'LockedMatch') {
                $('#underOverBetModal').find('input').prop('disabled', true);
                $("#underOverBet_betBtn").prop('disabled', true);
                $("#underOverBet_betBtn").html('Kết thúc đặt kèo<i class="material-icons right">lock</i>');
                alert("Đã hết thời gian đặt kèo");
            }
            else if (data.result == 'NotEnoughMoney') {
                alert("Bạn không có đủ tiền trong tài khoản. Vui lòng liên hệ nạp thêm!");
            }
            else {
                alert("Something went wrong. Vui lòng thử lại.");
            }
        }
    });
}

function setTeambetArea(data) {
    var modal = $('#teamBetModal');

    $('#userBalance').val(data.userBalance);
    $('#teamBet_userBalance').val(parseInt(data.userBalance).toLocaleString("it-IT") + " đ");
    $('#teamBet_betStatus').val(data.betStatus);

    if (data.betStatus == 0) {
        $('input[name=BetTeam]').prop('checked', false);
        $('#teamBet_betAmount').val("");
        $('label[for="teamBet_betAmount"]').removeClass("active");
        $('#teamBet_statusIcon').text("access_time");
        $('#teamBet_betStatusMessage').text("Chưa đặt kèo");
        if (!data.isLocked) {
            modal.find('input').prop('disabled', false);
            $('#teamBet_userBalance').prop('disabled', true);
            $("#teamBet_betBtn").prop('disabled', false);
            $("#teamBet_betBtn").html('Đặt kèo<i class="material-icons right">send</i>');
        }
    }
    else if (data.betStatus == 1) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetTeam][value=' + data.betTeam + ']';
        $(teamSelector).prop('checked', true);
        $('#teamBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="teamBet_betAmount"]').addClass("active");
        $('#teamBet_statusIcon').text("send");
        $('#teamBet_betStatusMessage').text("Đã đặt kèo, chờ nhập tiền");
        if (!data.isLocked) {
            $("#teamBet_betBtn").prop('disabled', false);
            $("#teamBet_betBtn").html('Nhập tiền<i class="material-icons right">attach_money</i>');
        }
    }
    else if (data.betStatus == 2) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetTeam][value=' + data.betTeam + ']';
        $(teamSelector).prop('checked', true);
        $('input#teamBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="teamBet_betAmount"]').addClass("active");
        $('#teamBet_statusIcon').text("check");
        $('#teamBet_betStatusMessage').text("Đặt kèo thành công!");
        $("#teamBet_betBtn").prop('disabled', true);
        $("#teamBet_betBtn").text('Đã đặt kèo');
    }
    else if (data.betStatus == 3) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetTeam][value=' + data.betTeam + ']';
        $(teamSelector).prop('checked', true);
        $('input#teamBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="teamBet_betAmount"]').addClass("active");
        $('#teamBet_statusIcon').text("sentiment_satisfied");
        $('#teamBet_betStatusMessage').text("Hòa cả làng nhé :D.");
    }
    else if (data.betStatus == 4) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetTeam][value=' + data.betTeam + ']';
        $(teamSelector).prop('checked', true);
        $('input#teamBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="teamBet_betAmount"]').addClass("active");
        $('#teamBet_statusIcon').text("sentiment_very_dissatisfied");
        $('#teamBet_betStatusMessage').text("Thua mất rồi! Xin cảm ơn và chúc bạn may mắn lần sau!");
    }
    else if (data.betStatus == 5) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetTeam][value=' + data.betTeam + ']';
        $(teamSelector).prop('checked', true);
        $('input#teamBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="teamBet_betAmount"]').addClass("active");
        $('#teamBet_statusIcon').text("sentiment_very_satisfied");
        $('#teamBet_betStatusMessage').text("Thắng rồiiii! Chúc mừng bạn!");
    }

    if (data.isLocked) {
        modal.find('input').prop('disabled', true);
        $("#teamBet_betBtn").prop('disabled', true);
        $("#teamBet_betBtn").html('Kết thúc đặt kèo<i class="material-icons right">lock</i>');
    }
}

function setUnderOverBetArea(data) {
    var modal = $('#underOverBetModal');

    $('#userBalance').val(data.userBalance);
    $('#underOverBet_userBalance').val(parseInt(data.userBalance).toLocaleString("it-IT") + " đ");
    $('#underOverBet_betStatus').val(data.betStatus);

    if (data.betStatus == 0) {
        $('input[name=BetSide]').prop('checked', false);
        $('#underOverBet_betAmount').val("");
        $('label[for="underOverBet_betAmount"]').removeClass("active");
        $('#underOverBet_statusIcon').text("access_time");
        $('#underOverBet_betStatusMessage').text("Chưa đặt kèo");
        if (!data.isLocked) {
            modal.find('input').prop('disabled', false);
            $('#underOverBet_userBalance').prop('disabled', true);
            $("#underOverBet_betBtn").prop('disabled', false);
            $("#underOverBet_betBtn").html('Đặt kèo<i class="material-icons right">send</i>');
        }
    }
    else if (data.betStatus == 1) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetSide][value=' + data.betSide + ']';
        $(teamSelector).prop('checked', true);
        $('#underOverBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="underOverBet_betAmount"]').addClass("active");
        $('#underOverBet_statusIcon').text("send");
        $('#underOverBet_betStatusMessage').text("Đã đặt kèo, chờ nhập tiền");
        if (!data.isLocked) {
            $("#underOverBet_betBtn").prop('disabled', false);
            $("#underOverBet_betBtn").html('Nhập tiền<i class="material-icons right">attach_money</i>');
        }
    }
    else if (data.betStatus == 2) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetSide][value=' + data.betSide + ']';
        $(teamSelector).prop('checked', true);
        $('#underOverBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="underOverBet_betAmount"]').addClass("active");
        $('#underOverBet_statusIcon').text("check");
        $('#underOverBet_betStatusMessage').text("Đặt kèo thành công!");
        $("#underOverBet_betBtn").prop('disabled', true);
        $("#underOverBet_betBtn").text('Đã đặt kèo');
    }
    else if (data.betStatus == 3) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetSide][value=' + data.betSide + ']';
        $(teamSelector).prop('checked', true);
        $('input#underOverBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="underOverBet_betAmount"]').addClass("active");
        $('#underOverBet_statusIcon').text("sentiment_satisfied");
        $('#underOverBet_betStatusMessage').text("Hòa cả làng nhé :D.");
    }
    else if (data.betStatus == 4) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetSide][value=' + data.betSide + ']';
        $(teamSelector).prop('checked', true);
        $('input#underOverBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="underOverBet_betAmount"]').addClass("active");
        $('#underOverBet_statusIcon').text("sentiment_very_dissatisfied");
        $('#underOverBet_betStatusMessage').text("Thua mất rồi! Xin cảm ơn và chúc bạn may mắn lần sau!");
    }
    else if (data.betStatus == 5) {
        modal.find('input').prop('disabled', true);
        var teamSelector = 'input[name=BetSide][value=' + data.betSide + ']';
        $(teamSelector).prop('checked', true);
        $('input#underOverBet_betAmount').val(parseInt(data.betAmount).toLocaleString("it-IT") + " đ");
        $('label[for="underOverBet_betAmount"]').addClass("active");
        $('#underOverBet_statusIcon').text("sentiment_very_satisfied");
        $('#underOverBet_betStatusMessage').text("Thắng rồiiii! Chúc mừng bạn!");
    }

    if (data.isLocked) {
        modal.find('input').prop('disabled', true);
        $("#underOverBet_betBtn").prop('disabled', true);
        $("#underOverBet_betBtn").html('Kết thúc đặt kèo<i class="material-icons right">lock</i>');
    }
}


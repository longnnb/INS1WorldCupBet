$(() => {
    $("#username").focus();

    function login() {
        var username = $('#username').val();
        var password = $('#password').val();
        if (!username || !password) {
            alert("Nhập tên đăng nhập và mật khẩu!");
        }
        else {
            $.ajax({
                url: "/Home/Login",
                type: "POST",
                data: {
                    username: username,
                    password: password
                },
                success: function (data) {
                    if (data.result == 'Successful') {
                        window.location.href = "/Home/Index";
                    }
                    else {
                        alert("Sai tên đăng nhập hoặc mật khẩu!");
                    }
                }
            });
        }
    }

    $('input').keypress(function (e) {
        if (e.which == 13) {
            login();
        }
    });

    $('#login-btn').click(function (e) {
        login();
    });
});
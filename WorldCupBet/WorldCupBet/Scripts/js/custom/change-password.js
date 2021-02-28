$(() => {
    $("#oldPassword").focus();

    $('#submit-btn').click(function (event) {
        event.preventDefault();
        var oldPassword = $('#oldPassword').val();
        var newPassword = $('#newPassword').val();
        var confirmPassword = $('#confirmPassword').val();
        var isFirstLogin = $('#isFirstLogin').val();
        if (!oldPassword || !newPassword || !confirmPassword) {
            alert("Nhập tất cả các trường!");
            return false;
        }
        else if (oldPassword == newPassword) {
            alert("Mật khẩu mới phải khác mật khẩu cũ!");
            return false;
        }
        else if (newPassword != confirmPassword) {
            alert("Xác nhận mật khẩu không khớp!");
            return false;
        }
        else {
            $.ajax({
                url: "/User/ChangePassword",
                type: "POST",
                data: {
                    oldPassword: oldPassword,
                    newPassword: newPassword,
                    confirmPassword: confirmPassword
                },
                success: function (data) {
                    if (data.message == 'Successful') {
                        alert("Đổi mật khẩu thành công");
                        if (isFirstLogin) {
                            window.location.href = "/Home/Index";
                        }
                        else {
                            window.location.href = "/User/UserProfile";
                        }
                    }
                    else {
                        alert("Sai mật khẩu cũ!");
                    }
                }
            });
        }
    });
});
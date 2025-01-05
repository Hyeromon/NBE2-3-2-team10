<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
        }

        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
        }

        .center-text {
            font-size: 12px;
            font-weight: bold;
            text-align: center;
        }
    </style>
    </style>
</head>
<body>
<div class="center-text">
    <img style = "width: 150px;" src = "./upload/logo.svg">
    <p>잠시만 기다려 주세요...!</p>
</div>
<script>
    const token = sessionStorage.getItem("accessToken");
    const url = 'http://localhost:8080';
    const pgToken = "${pg_token}";

    function checkAccessToken() {
        axios.post(url + '/api/user/check-login', {
            headers: {
                Authorization: 'Bearer ' + token
            }
        }).then(res => {
            sessionStorage.setItem("accessToken", res.data.accessToken);
            approvePayment();
        }).catch(error => {
            alert("로그인이 만료되었습니다. 다시 로그인해주세요.");
            location.href = '/';
        });
    }

    // 카카오페이 결제 approve
    function approvePayment() {
        axios.post(url + '/api/orders/kakaopay/approve',
            { token: pgToken },
            {
                headers: {
                    Authorization: 'Bearer ' + token
                }
            }
        ).then(res => {
            const aid = res.data.aid;
            const approvedAt = res.data.approvedAt;

            location.href = "/order/success?aid=" + aid + "&approvedAt=" + approvedAt;
        }).catch(error => {
            alert("결제가 실패했습니다. 다시 시도해주세요.");
            location.href = '/main';
        });
    }

    window.onload = () => {
        checkAccessToken();
    };
</script>
</div>
</body>
</html>
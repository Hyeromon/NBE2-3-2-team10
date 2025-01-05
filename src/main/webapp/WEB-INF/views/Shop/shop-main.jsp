<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>워시팡 사장님 페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
        }

        .background-banner {
            background-image: url('https://source.unsplash.com/featured/?laundry');
            background-size: cover;
            background-position: center;
            height: 200px;
        }
    </style>
</head>
<body class="bg-gray-100">
<!-- 상단 배너 -->
<div class="background-banner flex items-center justify-center">
    <h1 class="text-white text-3xl font-bold">워시팡 사장님 페이지</h1>
</div>

<!-- 메뉴 카드 -->
<div class="max-w-md mx-auto mt-4 space-y-4 px-4">

    <div class="flex justify-between space-x-4">
        <!-- 수거 요청 버튼 -->
        <button type="button" onclick="location.href='/pickup-check'"
                class="flex-1 bg-white rounded-2xl shadow-md p-4 hover:bg-gray-100 active:bg-gray-200 focus:outline-none flex items-center justify-between">
            <span class="text-xl font-bold">수거 요청</span>
            <img src="https://img.icons8.com/ios-filled/50/00bcd4/iron.png" alt="수거 요청" class="h-10 w-10">
        </button>
        <!-- 배달 요청 버튼 -->
        <button type="button" onclick="location.href='/pickup-delivery'"
                class="flex-1 bg-white rounded-2xl shadow-md p-4 hover:bg-gray-100 active:bg-gray-200 focus:outline-none flex items-center justify-between">
            <span class="text-xl font-bold">배달 요청</span>
            <img src="https://img.icons8.com/ios-filled/50/00bcd4/delivery.png" alt="배달 요청" class="h-10 w-10">
        </button>
    </div>

    <!-- 매출 관리 버튼 -->
    <button type="button" onclick="location.href='/sales-summary'"
            class="flex items-center justify-between w-full bg-white rounded-2xl shadow-md p-4 hover:bg-gray-100 active:bg-gray-200 focus:outline-none">
        <span class="text-xl font-bold">매출 관리</span>
        <img src="https://img.icons8.com/ios-filled/50/00bcd4/combo-chart.png" alt="매출 관리" class="h-10 w-10">
    </button>

    <!-- 리뷰 관리 버튼 -->
    <button type="button" onclick="location.href='/shop-review'"
            class="flex items-center justify-between w-full bg-white rounded-2xl shadow-md p-4 hover:bg-gray-100 active:bg-gray-200 focus:outline-none">
        <span class="text-xl font-bold">리뷰 관리</span>
        <img src="https://img.icons8.com/ios-filled/50/00bcd4/comments.png" alt="리뷰 관리" class="h-10 w-10">
    </button>
</div>

<footer class="fixed bottom-0 left-0 right-0 bg-white shadow p-4 flex justify-around overflow-x-auto mx-auto max-w-[448px] rounded-t-lg">
    <button class="flex flex-col items-center text-blue-500" onclick="location.href='/shop-main'">
        <img id = "home" src = "https://havebin.s3.ap-northeast-2.amazonaws.com/washpang/footer/Home_2.svg" class = "h-6 w-6"/>
        <span class="text-black text-[10pt] mt-1">홈</span>
    </button>
    <%--    <button class="flex flex-col items-center text-gray-500" onclick="location.href='/pickup-list'" >--%>
    <%--        <img src = "./footer/Bag.svg" class = "h-6 w-6"/>--%>
    <%--        <span class="text-black text-[10pt] mt-1">주문내역</span>--%>
    <%--    </button>--%>
    <button class="flex flex-col items-center text-gray-500" onclick="location.href='/shop/mypage'">
        <img id = "star" src = "./footer/Star.svg" class = "h-6 w-6"/>
        <span class="text-black text-[10pt] mt-1">내 정보</span>
    </button>
</footer>

<script>
    const url = "http://localhost:8080/api/user"
    const token = sessionStorage.getItem("accessToken");

    function checkAccessToken() {
        axios.post(url + '/api/user/check-login', {
            headers: {
                Authorization: 'Bearer ' + token
            }
        }).then(res => {
            if (res.data === false) {
                alert("로그인이 필요합니다.");
                location.href = '/';
            }
        }).catch(error => {
            alert(error.response.data);
        });
    }

    function getShopRole() {
        axios.get(url + '/role', {
            headers: {
                Authorization: 'Bearer ' + token
            }
        }).then(function (response) {
            document.getElementById('role').innerHTML = response.data.role == 'USER' ? '일반회원' : '세탁소'
            document.getElementById('name').innerHTML = response.data.name + " 님";
        }).catch(function (error) {
            console.error(error);
        });
    }

    function changeSvg() {
        const svgUrl = "https://havebin.s3.ap-northeast-2.amazonaws.com/washpang/footer"
        const path = window.location.pathname;
        // alert(path);

        const homeArray = ["/shop-main", "/pickup-check", "/pickup-delivery", "shop-review"];
        const starArray = ["/shop/mypage", "/shop/myInfoModify", "/shop/myInfo", "/shop/mypage"];

        if (homeArray.includes(path)) {
            document.getElementById('home').src = svgUrl + "/Home_2.svg";
        } else {
            document.getElementById('home').src = svgUrl + "/Home.svg";
        }

        if (starArray.includes(path)) {
            document.getElementById('star').src = svgUrl + "/Star_2.svg";
        } else {
            document.getElementById('star').src = svgUrl + "/Star.svg";
        }
    }

    window.onload = () => {
        changeSvg();
        checkAccessToken();
        getShopRole();
    };
</script>
</body>
</html>

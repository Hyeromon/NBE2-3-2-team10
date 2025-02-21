<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>패딩 페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
        }

        .scrollbar-thin::-webkit-scrollbar {
            height: 6px; /* 스크롤바 높이 (수평) */
            width: 2px;  /* 스크롤바 너비 (수직, 필요시) */
        }

        .scrollbar-thin::-webkit-scrollbar-thumb {
            background-color: #C6C6C6; /* 스크롤바 색상 */
            border-radius: 9999px; /* 스크롤바 둥글게 */
        }

        .scrollbar-thin::-webkit-scrollbar-track {
            background-color: #EDF2F7; /* 스크롤 트랙 색상 */
        }

        /* 기본 버튼 스타일 */
        .category-btn {
            background-color: #FFFFFF;
            border: 1px solid #E6E6E6;
            color: black;
            padding: 5px 10px;
            border-radius: 8px;
        }

        /* 선택된 버튼 스타일 */
        .category-btn.selected {
            background-color: #E5E5E5;
            border-color: #8E8E93;
        }

    </style>
    <script type="text/javascript">
        const token = sessionStorage.getItem("accessToken");
        const url = 'http://localhost:8080';

        function checkAccessToken() {
            axios.post(url + '/api/user/check-login', {
                headers: {
                    Authorization: 'Bearer ' + token
                }
            }).then(res => {
                sessionStorage.setItem("accessToken", res.data.accessToken);
            }).catch(error => {
                alert("로그인이 만료되었습니다. 다시 로그인해주세요.");
                location.href = '/';
            });
        }

        window.onload = function () {
            changeSvg();
            checkAccessToken();

            fetch(`/api/laundry/category/${category}`)
                .then(response => response.json())
                .then(data => {
                    console.log(data);  // 디버깅용: 데이터 확인

                    let result = '';
                    data.forEach(item => {
                       // var message = `<div style="padding:5px;">\${shop.shop_name}</div>`;

                        const shop = item.shop; // 세탁소 정보
                        const cheapestItem = item.cheapestItem; // 가장 저렴한 항목 정보

                        result += `<div class="bg-white p-4 rounded-lg shadow shop-item" data-id="\${shop.id}">
                                        <div class="flex justify-between items-center">
                                            <div>
                                                <h2 class="text-lg font-bold">\${shop.shop_name}</h2>
                                                <p class="text-gray-500">\${shop.address}</p>
                                            </div>
                                            <img src="https://source.unsplash.com/random/100x100?blanket" alt="Product" class="w-16 h-16 object-cover rounded-lg">
                                        </div>
                                        <div class="mt-2">
                                            <span class="text-xl font-bold">\${cheapestItem.price.toLocaleString()}원</span>
                                            <span class="text-gray-500">/\${cheapestItem.item_name}</span>
                                        </div>
                                    </div>`;
                    });
                    document.getElementById('laundryList').innerHTML = result;

                    document.querySelectorAll('.shop-item').forEach(item => {
                        item.addEventListener('click', function() {
                            const shopId = this.getAttribute('data-id');
                            window.location.href = `/laundryshop-detail/\${shopId}`;
                        });
                    });
                })
                .catch(error => console.error('Error fetching data:', error));
        }

        document.addEventListener("DOMContentLoaded", () => {
            // 현재 URL 경로
            const currentPath = window.location.pathname;

            // URL별 버튼 ID 매핑
            const pathToButtonId = {
                "/laundryshop-by-category/PADDING": "paddingBtn",
                "/laundryshop-by-category/SHOES": "shoesBtn",
                "/laundryshop-by-category/PREMIUM_FABRIC": "fabricBtn",
                "/laundryshop-by-category/COTTON_LAUNDRY": "cottonBtn",
                "/laundryshop-by-category/BEDDING": "beddingBtn",
                "/laundryshop-by-category/STORAGE_SERVICE": "storageBtn",
            };

            // 현재 경로에 해당하는 버튼 ID 가져오기
            const buttonId = pathToButtonId[currentPath];
            if (buttonId) {
                // 버튼에 'selected' 클래스 추가
                const selectedButton = document.getElementById(buttonId);
                selectedButton.classList.add("selected");
            }
        });

        function changeSvg() {
            const svgUrl = "https://havebin.s3.ap-northeast-2.amazonaws.com/washpang/footer"
            const path = window.location.pathname;
            // alert(currentPath);

            const homeArray = ["/main", "/laundryshop-by-map", "/laundryshop-by-category"];
            const orderArray = ["/orderHistory"];
            const starArray = ["/mypage", "/myInfo", "/myInfoModify"];

            if (homeArray.includes(path)) {
                document.getElementById('home').src = svgUrl + "/Home_2.svg";
            } else {
                document.getElementById('home').src = svgUrl + "/Home.svg";
            }

            if (orderArray.includes(path)) {
                document.getElementById('bag').src = svgUrl + "/Bag_2.svg";
            } else {
                document.getElementById('bag').src = svgUrl + "/Bag.svg";
            }

            if (starArray.includes(path)) {
                document.getElementById('star').src = svgUrl + "/Star_2.svg";
            } else {
                document.getElementById('star').src = svgUrl + "/Star.svg";
            }
        }
    </script>
</head>
<body class="bg-gray-100">
<div class="max-w-md mx-auto bg-white shadow-lg rounded-lg overflow-hidden">
    <div class="flex items-center justify-between p-4">
        <button class="text-gray-500" onclick="window.location.href='/main'">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
        </button>
        <h1 class="text-lg font-bold">${categoryName}</h1>
        <button class="text-gray-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h18M3 12h18m-9 9h9" />
            </svg>
        </button>
    </div>
    <div class="overflow-x-auto whitespace-nowrap px-4 scrollbar-thin scrollbar-thumb-gray-400 scrollbar-track-gray-200">
        <div class="inline-flex space-x-2 pb-2">
            <button id="paddingBtn" class="category-btn" onclick="window.location.href='/laundryshop-by-category/PADDING'">패딩</button>
            <button id="shoesBtn" class="category-btn" onclick="window.location.href='/laundryshop-by-category/SHOES'">신발세탁</button>
            <button id="fabricBtn" class="category-btn" onclick="window.location.href='/laundryshop-by-category/PREMIUM_FABRIC'">프리미엄 패브릭</button>
            <button id="cottonBtn" class="category-btn" onclick="window.location.href='/laundryshop-by-category/COTTON_LAUNDRY'">면 세탁물</button>
            <button id="beddingBtn" class="category-btn" onclick="window.location.href='/laundryshop-by-category/BEDDING'">침구</button>
            <button id="storageBtn" class="category-btn" onclick="window.location.href='/laundryshop-by-category/STORAGE_SERVICE'">보관서비스</button>
        </div>
    </div>
    <div class="p-4">
        <img src="/images/${category}.jpg" alt="Jacket" class="w-full h-48 object-cover rounded-lg">
    </div>
    <div class="p-4 space-y-4" id="laundryList">


    </div>
    <footer class="fixed bottom-0 left-0 right-0 bg-white shadow p-4 flex justify-around overflow-x-auto mx-auto max-w-[448px] rounded-t-lg">
        <button class="flex flex-col items-center text-blue-500" onclick="location.href='/main'">
            <img src = "/footer/Home.svg" class = "h-6 w-6"/>
            <span class="text-black text-[10pt] mt-1">홈</span>
        </button>
        <button class="flex flex-col items-center text-gray-500" onclick="location.href='/orderHistory'" >
            <img src = "/footer/Bag.svg" class = "h-6 w-6"/>
            <span class="text-black text-[10pt] mt-1">주문내역</span>
        </button>
        <button class="flex flex-col items-center text-gray-500" onclick="location.href='/mypage'">
            <img src = "/footer/Star.svg" class = "h-6 w-6"/>
            <span class="text-black text-[10pt] mt-1">내 정보</span>
        </button>
    </footer>
</div>

<footer class="fixed bottom-0 left-0 right-0 bg-white shadow p-4 flex justify-around overflow-x-auto mx-auto max-w-[448px] rounded-t-lg">
    <button class="flex flex-col items-center text-blue-500" onclick="location.href='/main'">
        <img id = "home" src = "./footer/Home.svg" class = "h-6 w-6"/>
        <span class="text-black text-[10pt] mt-1">홈</span>
    </button>
    <button class="flex flex-col items-center text-gray-500" onclick="location.href='/orderHistory'" >
        <img id = "bag" src = "./footer/Bag.svg" class = "h-6 w-6"/>
        <span class="text-black text-[10pt] mt-1">주문내역</span>
    </button>
    <button class="flex flex-col items-center text-gray-500" onclick="location.href='/mypage'">
        <img id = "star" src = "./footer/Star.svg" class = "h-6 w-6"/>
        <span class="text-black text-[10pt] mt-1">내 정보</span>
    </button>
</footer>
</body>
</html>
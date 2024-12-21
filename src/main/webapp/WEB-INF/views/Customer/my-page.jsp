<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Prototype</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body class="bg-gray-100">
<div class="max-w-md mx-auto bg-white shadow-md rounded-lg mt-0">
  <div class="p-4">
    <div class="text-sm text-blue-500 font-bold" id = 'role'></div>
    <div class="text-xl font-bold mt-2" id = 'name'></div>
    <div class="text-gray-600 mt-1">깨끗한 하루 되세요!</div>
  </div>
  <div class="flex justify-around mt-4">
    <button class="text-center focus:outline-none">
      <svg class="w-8 h-8 mx-auto text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-6 4h6m-6 0a2 2 0 00-2 2v10a2 2 0 002 2h6a2 2 0 002-2V9a2 2 0 00-2-2H8z"></path>
      </svg>
      <div class="text-sm mt-1">위시팡 내역</div>
    </button>
    <button class="text-center focus:outline-none" onclick="location.href='/myInfo'">
      <svg class="w-8 h-8 mx-auto text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
      </svg>
      <div class="text-sm mt-1">내정보</div>
    </button>
  </div>
  <div class="mt-4 border-t">
    <button class="flex justify-between items-center p-4 border-b w-full focus:outline-none">
      <div>공지사항</div>
      <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
      </svg>
    </button>
    <button class="flex justify-between items-center p-4 border-b w-full focus:outline-none">
      <div>고객센터</div>
      <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
      </svg>
    </button>
    <button class="flex justify-between items-center p-4 w-full focus:outline-none">
      <div>세탁소 등록</div>
      <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
      </svg>
    </button>
  </div>
</div>
<div>
  <button class="text-gray-400 text-center w-full p-4 focus:outline-none" onclick="logout()">
    로그아웃
  </button>
</div>
<!-- Footer -->
<footer class="fixed bottom-0 left-0 right-0 bg-white shadow p-4 flex justify-around max-w-[600px] overflow-x-auto mx-auto ">
  <button class="flex flex-col items-center text-blue-500" onclick="location.href='/main'">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12h18m-9 9h9" />
    </svg>
    <span>홈</span>
  </button>
  <button class="flex flex-col items-center text-gray-500" onclick="location.href='/orderHistory'" >
    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h18M3 12h18m-9 9h9" />
    </svg>
    <span>주문내역</span>
  </button>
  <button class="flex flex-col items-center text-gray-500" onclick="location.href='/mypage'">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h18M3 12h18m-9 9h9" />
    </svg>
    <span>마이</span>
  </button>
</footer>

  <script>
    const url = "http://localhost:8080"
    window.onload = () => {
      axios.get(url + '/api/user/role')
              .then(function(response) {
                document.getElementById('role').innerHTML = response.data.role == 'USER' ? '일반회원' : '세탁소'
                document.getElementById('name').innerHTML = response.data.name + " 님";
              }).catch(function(error) {
                console.error(error);
              });
    };
  </script>
</div>
</body>
</html>
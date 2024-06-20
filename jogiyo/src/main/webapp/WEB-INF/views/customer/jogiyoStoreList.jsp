
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
 <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }

        header {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            background-color: #f8f8f8;
            border-bottom: 1px solid #ddd;
        }

        header input {
            width: 200px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        nav a {
            margin: 0 10px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }

        nav a.active {
            color: #fa0050;
        }

        main {
            padding: 20px;
        }

        .sorting {
            text-align: right;
            margin-bottom: 20px;
        }

        .listings {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .listing {
            display: flex;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
        }

        .listing img {
            width: 100px;
            height: 100px;
            margin-right: 20px;
        }

        .details {
            flex: 1;
            position: relative;
        }

        .details h2 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }

        .details .rating {
            font-size: 16px;
            color: #f39c12;
        }

        .details .reviews,
        .details .min_order,
        .details .discount,
        .details .time {
            margin-top: 5px;
            font-size: 14px;
            color: #666;
        }
        .details .time {
            position: absolute;
            top: 0px;
            right: 0px;
            margin-top: 0;
        }   
        .details .discount {
            color: #fa0050;
            font-weight: bold;
        }

        .sorting select {
            padding: 10px 30px 10px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            font-size: 16px;
            color: #333;
            appearance: none;
            /* Removes default arrow */
            background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICA8cGF0aCBmaWxsPSIjMDAwIiBkPSJNMTMuNTc1IDUuNjgybC01LjUgNS41YTEuMDAxIDEuMDAxIDAgMCAxLTEuNDE4IDBsLTUuNS01LjVhMS4wMDEgMS4wMDEgMCAxIDEgMS40MTgtMS40MTdsNC41OTIgNC41OTNMMTEuOTY4IDQuMjZhMS4wMDEgMS4wMDEgMCAwIDEgMS40MTggMS40MTh6Ii8+Cjwvc3ZnPg==');
            /* Custom arrow */
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 12px;
        }
    </style>

    <div class="container">
    
    
        <div class="order-header">
            <h2>Store List</h2>
        </div>
        
       <div class="sorting">
       
        <label for="cateid">Choose a category:</label>
        <select name="cateid" id="select" >
            <c:forEach items="${cateList}" var="cate">
                <option value="${cate.cateid}" >${cate.catename}</option>
            </c:forEach>
        </select>
        <input type="button" name="searchBtn" id="searchBtn" value="선택" onclick="cateList()">
        </div>
        
        <div class="listings" id="storeList" >
            <c:if test="${not empty storeList}" >
            <c:forEach items="${storeList}" var="store">
                  <div class="listing">
                        <img src="${pageContext.request.contextPath}/resources/img/${store.img}" width="80" height="80">
                        <div class="details">
                            <h2><a onclick="viewStore(${store.storeid})" href="#"> ${store.storename} </a></h2>
                            <div class="rating">4.8 ★</div>
                            <div class="reviews">리뷰 3537 | 사장님댓글 2694</div>
                            <div class="min_order">가게설명 | ${store.storecontent}</div>
                            <div class="discount">쿠폰 | ${store.couponid}</div>
                            <div class="time">22-37분</div>
                        </div>
                    </div>
      
            </c:forEach>
            </c:if>
       </div>
          <a onclick="viewStore(${store.storeid})" href="#"></a>
    </div>
   
    
     <script type="text/javascript">
     var contextPath = "${pageContext.request.contextPath}";
  // 선택한 역할에 따라 계정 목록을 가져와서 표시하는 함수
     function cateList(){
        let sel = $("select").val();  // 드롭다운에서 선택한 역할 값을 가져옴
        var csrfToken = $("meta[name='_csrf']").attr("content");  // CSRF 토큰 값을 가져옴
         var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // CSRF 헤더 이름을 가져옴

         // 계정 목록을 가져오기 위해 AJAX POST 요청을 보냄
        $.ajax({
           url : "listCate.ajax",  // 요청을 보낼 URL
           type : "post",  // HTTP 메서드
           data: {
                    "sel": sel,  // 서버로 전송할 데이터 (선택한 역할)
                    "_csrf": csrfToken  // CSRF 토큰을 데이터에 포함
                },
                beforeSend: function(xhr) {
                     // AJAX 요청 헤더에 CSRF 토큰을 추가
                     xhr.setRequestHeader(csrfHeader, csrfToken);
                 },
           success : function(res) {
              // 요청이 성공하면 JSON 응답을 파싱
                 var data = JSON.parse(res);
                 // 기존 테이블 내용을 초기화
                 $("#storeList").empty();
                 
                 // 데이터 각 항목을 테이블에 추가
                 $.each(data, function(index, item) {
                    var div =
                       "<div class='listing'>" +
                        "<img src='" + contextPath + "/resources/img/" + item.img + "' width='80' height='80'>" +
                        "<div class='details'>" +
                            "<h2><a onclick='viewStore(" + item.storeid + ")' href='#'>" + item.storename + "</a></h2>" +
                            "<div class='rating'>4.8 ★</div>" +
                            "<div class='reviews'>리뷰 3537 | 사장님댓글 2694</div>" +
                            "<div class='min_order'>가게설명 | " + item.storecontent + "</div>" +
                            "<div class='discount'>쿠폰 | " + item.couponid + "</div>" +
                            "<div class='time'>22-37분</div>" +
                        "</div>" +
                      "</div>";
   
                     $("#storeList").append(div);
                 
                 });
           },
           error : function(err) {
              // 오류가 발생하면 콘솔에 오류를 출력
              console.log(err);
           }
        })
     }
  
     
     
     
function viewStore(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/customer/viewStore.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'storeid';
    idInput.value = id;
    form.appendChild(idInput);
    
    var csrfToken = $("meta[name='_csrf']").attr("content");
    
    var idInput2 = document.createElement('input');
    idInput2.type = 'hidden';
    idInput2.name = '_csrf';
    idInput2.value = csrfToken;
    form.appendChild(idInput2);

    document.body.appendChild(form);
    form.submit();
}


</script>
   
</body>
</html>

<jsp:include page="../footer.jsp"/>


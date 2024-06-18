<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
            <h2>카테고리별 가게</h2>
        </div>
        
		<div class="sorting">
    	
        <label for="cateid">Choose a category:</label>
        <select name="cateid" id="sortOptions" onchange="CateList(this.value)">
            <c:forEach items="${cateList}" var="cate">
                <option value="${cate.cateid}" >${cate.catename}</option>
            </c:forEach>
        </select>
        <input type="submit" value="선택">
    	 </div>
        
        <div class="listings">

               
        <c:forEach items="${cateStoreList}" var="cateS"> 
                <div class="listing">
                <img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="80" height="80"> 
                 <div class="details">  
                   <h2><a onclick="viewStore(${cateS.storeid})" href="#"> ${cateS.storename} </a></h2>
						<div class="rating">4.8 ★</div>
						<div class="reviews">리뷰 3537 | 사장님댓글 2694</div>
						<div class="min_order">가게설명 | ${cateS.storecontent}</div>
                        <div class="discount">쿠폰 | ${cateS.couponid}</div>
                        <div class="time">22-37분</div>
                    </div>
                </div>
      </c:forEach>

                 
           
     
    </div>
    <a onclick="viewStore(${cateS.storeid})" href="#"></a>
   
    
     <script type="text/javascript">
function viewStore(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/customer/viewStore.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'storeid';
    idInput.value = id;
    form.appendChild(idInput);

    document.body.appendChild(form);
    form.submit();
}

function CateList(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/customer/cateList.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'cateid';
    idInput.value = id;
    form.appendChild(idInput);

    document.body.appendChild(form);
    form.submit();
}
</script>
   
</body>
</html>

<jsp:include page="../footer.jsp"/>


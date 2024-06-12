<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
 <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .order-table-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 1200px;
            margin: auto;
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .order-table th, .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #dddddd;
            text-align: center;
        }
        .order-table th {
            background-color: #f2f2f2;
        }
        .actions button {
            padding: 8px 10px;
            background-color: #fa006c;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 90px;
        }
        .actions button:disabled {
            background-color: #cccccc;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .order-header h2 {
            margin: 0;
            font-size: 20px;
        }
        .order-header span {
            font-size: 14px;
            color: #777;
        }
    </style>
    
    <div class="order-table-container">
        <div class="order-header">
            <h2>Cart</h2>
            
        </div>
        <table class="order-table">
            <thead>
                <tr>
                    <th></th>
                    <th>Date</th>
                    <th>Order Details</th>
                    <th>Total</th>
                    <th>Actions</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
               
                <c:forEach items="${porder}" var="order">
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td class="actions">
                        <button onclick="order()">주문</button>
                    </td>
                    <td class="actions">
                    	<button onclick="deleteOrder()">삭제</button>
                    </td>
                </tr>
                
                     </c:forEach>
                 
            </tbody>
        </table>
    </div>
      <script>
      
        function order() {
            alert('주문 기능을 구현하세요.');
        }

        function deleteOrder() {
            alert('삭제 기능을 구현하세요.');
        }
    </script>

   
</body>
</html>

<jsp:include page="../footer.jsp"/>


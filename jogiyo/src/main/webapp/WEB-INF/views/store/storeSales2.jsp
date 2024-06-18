<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 가게 매출관리 페이지 -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type ="text/javascript">

	function indateSales(){
		let date1=$("#date1").val();
		let date2=$("#date2").val();
		let storeid=$("#storeid").val();
		var csrfToken = $("meta[name='_csrf']").attr("content");
	    var csrfHeader = $("meta[name='_csrf_header']").attr("content"); 
		$.ajax({
			url:"indateSales.ajax",
			type:"post",
			data:{
				"date1": date1,
				"date2": date2,
				"storeid": storeid,
				"_csrf": csrfToken
			},	
			beforeSend: function(xhr) {
                // AJAX 요청 헤더에 CSRF 토큰 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
			success:function(res){
				$("#logNameChart").remove();
				$("#logNameChart2").remove();
				$("#canvasDiv").append('<canvas id="logNameChart" style="width: 600px; height: 500px;"></canvas>');
				$("#canvasDiv").append('<canvas id="logNameChart2" style="width: 600px; height: 500px;"></canvas>');
				var jsonObject = res;
				var jData = JSON.parse(jsonObject);

				var labelList = new Array();
				var valueList = new Array();
				var colorList = new Array();
				var labelList2 = new Array();
				var valueList2 = new Array();
		

				for (var i = 0; i < jData.length; i++) {
					var d = jData[i];
					valueList.push(d.daily_total);
					labelList.push(d.daily);
					colorList.push(colorize());
					labelList2.push(d.month);
					valueList2.push(d.monthly_total);	
				}
			
				var data1 ={
							labels : labelList,
							datasets :[{
								data:valueList,
								label:"일별 판매량",
								backgroundColor : colorList,
								borderColor:'rgba(85,85,85)',
								fill:false,
								showLine:true,
								spanGaps:true
							}]
				};
				var data2 ={
						labels : labelList2,
						datasets :[{
							data:valueList2,
							label:"월별 판매량",
							backgroundColor : colorList,
							borderColor:'rgba(85,85,85)',
							fill:false,
							showLine:true,
							spanGaps:true
							
						}]
			};
				var ctx1 = document.getElementById('logNameChart').getContext(
				'2d');
				var ctx2 = document.getElementById('logNameChart2').getContext(
				'2d');
				var myChart = new Chart(ctx1,{
					type:'line',
					data:data1,
					options :{
						responsive:false,
						scales:{
							x:{
								beginAtZero:true
							},
							y:{
								
								beginAtZero:true
							},
						},
						elements:{
							line:{
								tension:0.6
							}
						}
					}
					
				});
				var myChart2 = new Chart(ctx2,{
					type:'line',
					data:data2,
					options :{
						responsive:false,
						scales:{
							x:{
								beginAtZero:true
							},
							y:{
								
								beginAtZero:true
							},
						},
						elements:{
							line:{
								tension:0.6
							}
						}
					}
					
				});
			},
			error : function(err) {
				console.log(err);
			}		
		})
	}
	function colorize() {
		var r = Math.floor(Math.random()*200);
		var g = Math.floor(Math.random()*200);
		var b = Math.floor(Math.random()*200);
		var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
		return color;
	}
	
</script>

<div align="center" style="background-color: #fa0050; padding: 10px;">
	<span style="color: white;">시작날짜 : </span><input type="text" name="date1" id="date1" style="margin-right: 10px;"> 
	<span style="color: white;">종료날짜 : </span><input type="text" name="date2" id="date2" style="margin-right: 10px;"><br> 
		<input type="hidden" name="storeid" id="storeid" value="${storeid}">
	<input type="button" name="searchBtn" id="searchBtn" value="검색" onclick="indateSales()" style="background-color: white; color: #fa0050; border: none; padding: 5px 10px; margin-top: 10px; margin-right: 10px;"> 
	<input type="button" name="canBtn" id="canBtn" value="취소" style="background-color: white; color: #fa0050; border: none; padding: 5px 10px; margin-top: 10px;">
</div>
 <div id="canvasDiv" style="display: flex; justify-content: center;">
<!--<canvas id="logNameChart" style="width:400px;height:400px;"></canvas>-->

</div>
<script>
	$(document).ready(function() {
		$('#date1').datepicker();
		$('#date2').datepicker();
	});
	$.datepicker.setDefaults({
		dateFormat : 'yy-mm-dd', // Input Display Format 변경
		showOtherMonths : true, // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
		showMonthAfterYear : true, // 년도 먼저 나오고, 뒤에 월 표시
		changeYear : true, // 콤보박스에서 년 선택 가능
		changeMonth : true, // 콤보박스에서 월 선택 가능
		//,showOn: "both" // button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
		//,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" // 버튼 이미지 경로       ,buttonImageOnly: true // 기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		buttonText : "선택", // 버튼에 마우스 갖다 댔을 때 표시되는 텍스트
		yearSuffix : "년", // 달력의 년도 부분 뒤에 붙는 텍스트
		monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ], // 달력의 월 부분 텍스트
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ], // 달력의 월 부분 Tooltip 텍스트
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ], // 달력의 요일 부분 텍스트
		dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ], // 달력의 요일 부분 Tooltip 텍스트
		minDate : "-3Y", // 최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		maxDate : "+3Y" // 최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
	});

	$('#date1').datepicker('setDate', '-1D');
	//(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

	$('#date2').datepicker('setDate', 'today');
	//(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
</script>
</body>
</html>
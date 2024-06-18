<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">
	function dateList() {
		let cal1 = $("#cal1").val();
		let cal2 = $("#cal2").val();
		var csrfToken = $("meta[name='_csrf']").attr("content");
	    var csrfHeader = $("meta[name='_csrf_header']").attr("content");  
		$.ajax({
			url : "dateOrder.ajax",
			type : "post",
			data : {
				"cal1" : cal1,
				"cal2" : cal2,
				"_csrf": csrfToken
			},
			beforeSend: function(xhr) {
                // AJAX 요청 헤더에 CSRF 토큰 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
			success : function(res) {
				$("#logNameChart").remove();
				$("#logNameChart2").remove();
				$("#canvasDiv").append('<canvas id="logNameChart" style="width: 600px; height: 600px;"></canvas>');
				$("#canvasDiv").append('<canvas id="logNameChart2" style="width: 600px; height: 600px;"></canvas>');
				var jsonObject = res;
				var jData = JSON.parse(jsonObject);

				var labelList = new Array();
				var valueList = new Array();
				var colorList = new Array();
				var cntList = new Array();

				for (var i = 0; i < jData.length; i++) {
					var d = jData[i];
					labelList.push(d.Storename);
					valueList.push(d.Totprice);
					colorList.push(colorize());
					cntList.push(d.Cnt);
				}
				var data = {
					labels : labelList,
					datasets : [ {
						label : '금액',
						backgroundColor : '#FF7DA8',
						data : valueList
					} ]
				};
				var data2 = {
						labels : labelList,
						datasets : [ {
							label : '건수',
							backgroundColor : '#00C7E2',
							data : cntList
						} ]
					};
				var ctx1 = document.getElementById('logNameChart').getContext(
						'2d');
				var ctx2 = document.getElementById('logNameChart2').getContext(
				'2d');

				var myChart = new Chart(ctx1, {
					type : 'bar',
					data : data,
					options : {
						title : {
							display : true,
							text : '기간 별 매출(가격)'
						},
						responsive : false, // 반응형 여부 (기본값 true)
						maintainAspectRatio : false, // 크기 고정
						scales : { // x축과 y축에 대한 설정
							yAxes : [ {
								ticks : {
									beginAtZero : true,
									callback : function(value, index) {
										if (value.toString().length > 8)
											return (Math
													.floor(value / 100000000))
													.toLocaleString("ko-KR")
													+ "억";
										else if (value.toString().length > 4)
											return (Math.floor(value / 10000))
													.toLocaleString("ko-KR")
													+ "만";
										else
											return value
													.toLocaleString("ko-KR");
									}
								},
							} ]
						},
					}
				});
				var myChart2 = new Chart(ctx2, {
					type : 'bar',
					data : data2,
					options : {
						title : {
							display : true,
							text : '기간 별 매출(주문건수)'
						},
						responsive : false, // 반응형 여부 (기본값 true)
						maintainAspectRatio : false, // 크기 고정
						scales : { // x축과 y축에 대한 설정
							yAxes : [ {
								ticks : {
									beginAtZero : true,
									callback : function(value, index) {
											return value
													.toLocaleString("ko-KR");
									}
								},
							} ]
						},
					}
				});
			},
			error : function(err) {
				console.log(err);
			}
		})
	}
	function colorize() {
		var r = Math.floor(Math.random() * 200);
		var g = Math.floor(Math.random() * 200);
		var b = Math.floor(Math.random() * 200);
		var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
		return color;
	}
</script>
<div align="center" style="background-color: #DDD; padding: 10px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); margin-bottom: 20px;">
	<span style="color: black;">시작날짜 : </span><input type="text" name="cal1" id="cal1" style="margin-right: 10px;"> 
	<span style="color: black;">종료날짜 : </span><input type="text" name="cal2" id="cal2" style="margin-right: 10px;"><br> 
	<input type="button" name="searchBtn" id="searchBtn" value="검색" onclick="dateList()" style="background-color: #fa0050; color: #white; border: none; padding: 5px 10px; margin-top: 10px; border-radius: 5px; margin-right: 10px;"> 
	<input type="button" name="canBtn" id="canBtn" value="취소" style="background-color: #fa0050; color: #white; border: none; padding: 5px 10px; margin-top: 10px;border-radius: 5px; cursor: pointer;">
</div>
<div id="canvasDiv" style="display: flex; justify-content: center;">
<%--     <canvas id="logNameChart" style="width: 600px; height: 600px;"></canvas>
    <canvas id="logNameChart2" style="width: 600px; height: 600px;"></canvas> --%>
</div>
<script>
	$(document).ready(function() {
		$('#cal1').datepicker();
		$('#cal2').datepicker();
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

	$('#cal1').datepicker('setDate', '-1D');
	//(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

	$('#cal2').datepicker('setDate', 'today');
	//(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
</script>
<jsp:include page="../footer.jsp" />
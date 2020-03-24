<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>


 <link rel="stylesheet" href="https://unpkg.com/leaflet@1.6.0/dist/leaflet.css"
   integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ=="
   crossorigin=""/>


<!-- Make sure you put this AFTER Leaflet's CSS -->
 <script src="https://unpkg.com/leaflet@1.6.0/dist/leaflet.js"
   integrity="sha512-gZwIG9x3wUXg2hdXF6+rVkLF/0Vi9U8D2Ntg4Ga5I5BZpVkVxlJWbSQtXPSiUTtC0TjtGOmxa1AJPuV0CPthew=="
   crossorigin=""></script>



 



<%@ include file = "/WEB-INF/views/include/include_header_nav.jsp"%>



<style>

.contentBox{

	width:100%;

}

.nameBox{
	
	    /* width: 100%; */
    padding: 5%;
    margin-top: 5%;
    margin-bottom: 5%;
    text-align: center;
    font-size: xx-large;
    border-bottom: 1px solid black;
    border-top: 1px solid black;
        font-weight: bold;
	
}

.infoBoxinfoBox{


	border:1px solid black;

}

.picBox{
	
	display:inline-block;
	
	width:40%;
	height:40%;

}

.infoDetailBox{

	display:inline-block;
	position: absolute;
	width: 50%;
    margin-left: 5%;
}





.imgModal{

	display:none;
	position: fixed;
	z-index: 10;
	padding-top: 100px;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0,0,0);
	background-color: rgba(0,0,0,0.9);
}




.imgModalContent{

	margin:auto;
	display: auto;
	width: 80%;
	max-width: 700px;

}




#imgModalCaption{

	margin:auto;
	display: block;
	width: 80%;
	max-width: 700px;
	text-align: center;
	color:#ccc;
	padding: 10px 0;
	height: 150px;
	
}



.imgModalContent{

	-webkit-animation-name:zoom;
	-webkit-animation-duration:0.6s;
	animation-name:zoom;
	animation-duration:0.6s;


}


@-webkit-keyframes zoom{

	from{-webkit-transform:scale(0)}
	to{-webkit-transform:scale(1)}
}



@keyframes zoom{

	from{transform:scale(0)}
	to{transform:scale(1)}
}


.imgModalClose{

	position:absolute;
	top: 15px;
	right: 35px;
	color: #f1f1f1;
	font-size: 40px;
	font-weight: bold;
	transition:0.3s;

}


.imgModalClose:hover, imgModalClose:focus {

	color: #bbb;
	text-decoration: none;
	cursor: pointer;	
}


@media only screen and (max-width:700px){
	
	..imgModalContent{
		width: 100%;
	}
}


.fImg:hover{

	cursor: zoom-in;
	

}

.noteBox{


	border-top: 1px solid black;
    margin-top: 5%;

}


.noteBoxDetail{

	
	display: block;
    width: 90%;
    margin-top: 10%;
    font-size: large;
  
}

.commentBox{

	
	border-top: 1px solid black;
    margin-top: 10%;

}

.commentBoxDetail{

	display: block;
    width: 90%;
    margin-top: 3%;
    background-color: rgba(147, 112, 219, 0.2);

}



.nicknameBox{


	display: inline-block;
    width: 30%;
    height: 5%;
   


}


.commentLinear{

	width: 100%;
    height: 3px;
    margin-top: 5%;
    background-color: mediumpurple;
    opacity: 0.4;

}


.insertButton {
    color: #fff;
    font-size: medium;
    background-color: mediumpurple;
    border-color: mediumpurple;
    }

.insertButton:hover {
    color: #fff;
    background-color: rgba(147, 112, 219, 0.5);
	border-color:rgba(147, 112, 219, 0.5);
	}
</style>





<script>

function init(){

	
var longitude = document.getElementById('longitude').value
var latitude = document.getElementById('latitude').value
var name = document.getElementById('name').text



// マップライブラリー：leaflet
// タイル：国土地理院
var mymap = L.map('mapcontainer')

mymap.setView([latitude, longitude], 18)
L.tileLayer('https://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png', {
	attribution: '地理院タイル'}).addTo(mymap)
L.marker([latitude,longitude],{title:name}).addTo(mymap)

}




</script>








<script>


$(function(){


	$('.insertButton').click(function(){


		var c_text = $('#c_text').val()
		var c_f_id = $('#c_f_id').val()

		

		
	
		
		
		$.ajax({


			url:"${rootPath}/comment/insert", data:{c_text, c_f_id}, type:'post',
			success:function(result){

				$('.cmtEntranceDiv').html(result)

				}, error:function(){


					alert("サーバーエラー")
					
					}


			
			})

		
		
		})





		


	
	
})


</script>





<body onload="init()">



<div class="contentBox">


<c:if test="${!empty FACILITY}">
	
	<c:forEach items="${FACILITY}" var="F">
	<input id="c_f_id" type="hidden" value="${F.id }">
	<div class="nameBox">
		<a id="name">${F.name}</a>
	</div>
	
	<div class="infoBox">
		
		<c:choose>
		<c:when test="${!empty F.pic}">
		<div class="picBox"><img id="fImg" class="fImg" width="100%" height="100%" src="https://data.city.kyoto.lg.jp/sites/default/files/resource-files/${F.pic}" alt="${F.name}"></div>
		
		
		<div id="imgModal" class="imgModal" align="center">
			
				<span class="imgModalClose">&times;</span>
				<img class="imgModalContent" id="imgModalContent">
				<div id="imgModalCaption"></div>			
		</div>
			
			
		</c:when>
		<c:otherwise>
		<div class="picBox"><img width="100%" height="100%" src="${rootPath}/resources/img/no-image.png"></div>
		</c:otherwise>
		</c:choose>
		
		<div class="infoDetailBox">
		
			<div style="display: inline-block; width:15%; background-color:rgba(147, 112, 219, 0.2); text-align: center;">所在地</div><div style="display: inline-block; vertical-align: top; width:80%; background-color:rgba(147, 112, 219, 0.1);">${F.address}</div>
			<div style="display: inline-block; width:15%; background-color:rgba(147, 112, 219, 0.2); text-align: center;">開館時間</div><div style="display: inline-block; vertical-align: top; width:80%; background-color:rgba(147, 112, 219, 0.1);">${F.optime}</div>
			<div style="display: inline-block; width:15%; background-color:rgba(147, 112, 219, 0.2); text-align: center;">休館日</div><div style="display: inline-block; vertical-align: top; width:80%; background-color:rgba(147, 112, 219, 0.1);">${F.holiday}</div>
			<div style="display: inline-block; width:15%; background-color:rgba(147, 112, 219, 0.2); text-align: center;">利用料</div><div style="display: inline-block; vertical-align: top; width:80%; background-color:rgba(147, 112, 219, 0.1);">${F.fee}</div>
			<div style="display: inline-block; width:15%; background-color:rgba(147, 112, 219, 0.2); text-align: center;">電話番号</div><div style="display: inline-block; vertical-align: top; width:80%; background-color:rgba(147, 112, 219, 0.1);">${F.tel}</div>
			<div style="display: inline-block; width:15%; background-color:rgba(147, 112, 219, 0.2); text-align: center;">URL</div><div style="display: inline-block; vertical-align: top; word-break: break-all; width:80%; background-color:rgba(147, 112, 219, 0.1);">${F.url}</div>
		
		</div>
	</div>






<div class="noteBox">

	<div style="margin-top: 4%; font-size: x-large;">*施設のご案内（利用目的・実施内容等)</div>

	<div class="noteBoxDetail">
	
	
	
		<a>${F.note}</a>
	
	
	</div>


	<div style="margin-top: 5%;">*所管局-${F.department}</div>
	
</div>





 <div  id="mapcontainer" style="margin-top: 5%;height: 200px;">
 
 <input type="hidden" id="longitude" value="${F.longitude }">
 <input type="hidden" id="latitude" value="${F.latitude }">
 </div>





	</c:forEach>
	
	
	
	
	<div class="commentBox">
	
		<div style="margin-top: 4%; font-size: x-large; font-weight: bold;">コメント</div>
	
	
			
		<div class="commentBoxDetail">
		
		
			
			
			<div class="cmtEntranceDiv">
			
			<c:if test="${!empty COMMENTLIST }">
			
			
			<%@ include file="/WEB-INF/views/commentpiece.jsp" %>
			
			</c:if>
			
			</div>
			
			<c:if test="${!empty USERSESSION }">
			
			<div style="text-align: center;">
			<textarea id="c_text" style="width: 70%; height: 10%;" placeholder="1000字以内で作成してくだたい" maxlength="1000"></textarea>
			<button class="insertButton" type="button">送信</button>
			</div>
			
			</c:if>
			
			<c:if test="${empty USERSESSION }">
				<div style="text-align: center;font-size: small;line-height: 5;opacity: 0.8;"><a href="${rootPath}/member/login" style="text-decoration: none;">ログイン</a>後作成できます</div>
			</c:if>
			
		</div>
	
	</div>
	
	
	
</c:if>


</div>


<script>




$(function(){




	var span = $('.imgModalClose')
	var imgModal = $('#imgModal');

	span.click(function(){

		imgModal.css('display', 'none')
		
		})

	

	$('.fImg').click(function(){


			//var $imgSW = "on"

			
			//var imgTd = $(this);
			var image = $(this);
			var imgModalContent = $('#imgModalContent')
			var imgModalCaption = $('#imgModalCaption')

			imgModal.css('display', 'block')
			imgModalContent.attr('src', image.attr('src')) 
			imgModalCaption.html(image.attr('alt'))

			
		})



	

	
})

</script>



</body>
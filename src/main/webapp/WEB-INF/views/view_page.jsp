<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>


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


button {
    color: #fff;
    font-size: medium;
    background-color: mediumpurple;
    border-color: mediumpurple;
    }

button:hover {
    color: #fff;
    background-color: rgba(147, 112, 219, 0.5);
	border-color:rgba(147, 112, 219, 0.5);
	}
</style>


<body>



<div class="contentBox">


<c:if test="${!empty FACILITY}">
	
	<c:forEach items="${FACILITY}" var="F">

	<div class="nameBox">
		<a>${F.name}</a>
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

	</c:forEach>
	
	
	
	
	<div class="commentBox">
	
		<div style="margin-top: 4%; font-size: x-large; font-weight: bold;">コメント</div>
	
	
			
		<div class="commentBoxDetail">
			
			<div style="padding: 3%;">
			
			<div class="nicknameBox">nicknameさん</div><div class="dateBox" style="display: inline-block; float:right;">2020-02-02</div>
			<div class="textBox" style="word-break:break-all; margin:10;">aewfaefaefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffefnewfffffffffffffffffffffaefaffffffffffffffawe</div>
			<div class="commentLinear"></div>
			
			</div>
			
			<div style="text-align: center;">
			<textarea style="width: 70%; height: 10%;" placeholder="コメントを書く"></textarea>
			<button type="button">送信</button>
			</div>
			
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
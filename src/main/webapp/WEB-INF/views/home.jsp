<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>







<html>




<style>

*{

margin:0 auto;
padding:0;

}

body{

width:978px;
height:100%;


}

header{
	color:purple;
	text-align:center; 
	font-size: xx-large;
	    font-weight: bold;
	    text-shadow: -1px 0 yellow, 0 1px yellow, 1px 0 yellow, 0 -1px yellow;
}


.navMenuBox{

	display: block;
    width: 100%;
    height: 50px;
    background-color: mediumpurple;
	

}


.navMenu{
	
	list-style: none;
	
}

li{
	  
   
    font-weight: bold;
    padding: 14px 16px;
    
}



li a{
	 color: white;
	text-decoration: none;
}



.mainTable{

	border-collapse: collapse;
	width:90%;
	border: 1px solid mediumpurple;
	table-layout: fixed;

}


th{

	background-color: rgba(147, 112, 219, 0.5);
    padding: 10px 10px;
        border: 1px solid mediumpurple;
    text-align: center;

}


.trClass:hover{

	cursor: pointer;
	background-color: rgba(147, 112, 219, 0.2);

}



td{


	  
	  
	  
 border: 1px solid mediumpurple;
	padding: 10px 10px;
	
	
	text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
}


.searchBox{

	
    margin-left: 49;
}


.btn-primary {
    color: #fff;
    background-color: mediumpurple;
    border-color: mediumpurple;
    }

.btn-primary:hover {
    color: #fff;
    background-color: rgba(147, 112, 219, 0.5);
	border-color:rgba(147, 112, 219, 0.5);
	}
	
	
.inputClass{

	height: 40px;
}	


.container{
	position: relative;
	
}


.image{

	opacity: 1;
	display: block;
	transition: .5s ease;
	backface-visibility: hidden;

}


.middle{

	transition: .5s ease;
	opacity: 0;
	position: absolute;
	top:50%;
	left:50%;
	transform:translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	
}


.imgTd:hover .image{
	opacity: 0.3;
}


.imgTd:hover .middle {
  opacity: 1;
}

.imgText{
	
	  
    font-size: 20px;
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


.paginationBox{

	display: table;
}

.paginationBox a{

	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
}


.paginationBox a.pagiActive{

	
	background-color: mediumpurple;
	color: white;

}


.paginationBox a:hover:not(.pagiActive){

	background-color: rgba(147, 112, 219, 0.2);
	
}

</style>





<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>





<script>

$(function(){



	$('.clickTdClass').click(function(){

		var id = $(this).siblings('.hiddenId').val()


		document.location.href="${rootPath}/kyoto/view?id="+id
		
		})
	
})


</script>



<head>
<meta charset="utf-8"/>
	<title>Home</title>
</head>


<body>



<%@ include file = "/WEB-INF/views/include/include_header_nav.jsp"%>



<br><br><br><br>



<form action="${rootPath}/kyoto/search">
<div class="searchBox">
	
	
	
	<input id="searchVal" class="inputClass" name="searchVal" maxlength="20" placeholder="施設名で探す（2０字以内）">
	<button class="btn btn-primary" style="padding: 8px;">検索</button>
	
</div>
</form>



<div class="tableBox">

	<table class="mainTable">
	
		<tr>
		
			<th style="width: 30%">施設名</th>
			<th style="width: 15%">所管局</th>
			<th style="width: 35%">所在地</th>
			<th style="width: 30%">写真</th>
		
		</tr>
		
		
		
		<c:if test="${empty KYOTOLIST }">
		<tr>
			<td colspan="4" style="text-align: center;">情報がありません</td>
		
		</tr>
		</c:if>
		
		
		
		
		<c:if test="${!empty KYOTOLIST }">
			<c:forEach items="${KYOTOLIST}" var="kyoL">
		<tr class="trClass">
			
			<input class="hiddenId" type="hidden" value="${kyoL.id}">
			<td style="display:none;" >${kyoL.id}</td>
			<td class="clickTdClass">${kyoL.name}</td>
			<td class="clickTdClass">${kyoL.department}</td>
			<td class="clickTdClass">${kyoL.address}</td>
			
			
			<c:choose>
			
			<c:when test="${!empty kyoL.pic}">
			
			<td id="imgTd" class="imgTd" align="center">
			<div class="container">
			<img id="image"  class="image" width="180" height="100" src="https://data.city.kyoto.lg.jp/sites/default/files/resource-files/${kyoL.pic}" alt="${kyoL.name}">
			<div class="middle">
			<div class="imgText">拡大</div>
			</div>
			</div>
			</td>
			
			
			
			<div id="imgModal" class="imgModal" align="center">
			
				<span class="imgModalClose">&times;</span>
				<img class="imgModalContent" id="imgModalContent">
				<div id="imgModalCaption"></div>			
			</div>
			
			
			</c:when>
			
			<c:otherwise>
			<td align="center"><img width="100" height="100" src="${rootPath}/resources/img/no-image.png"></td>
			</c:otherwise>
			
			</c:choose>
		
		</tr>
			</c:forEach>
		</c:if>
	
	</table>


</div>


<br>

<div class="paginationBox">





<c:choose>


<c:when test="${PAGINATIONBAR == 'ALL'}">

<a href="${rootPath}/?curPage=1">&laquo;</a>
<c:if test="${curPage-3 >= 1}">
<a href="${rootPath}/?curPage=${curPage-3}">${curPage-3}</a>
</c:if>
<c:if test="${curPage-2 >= 1}">
<a href="${rootPath}/?curPage=${curPage-2}">${curPage-2}</a>
</c:if>
<c:if test="${curPage-1 >= 1}">
<a href="${rootPath}/?curPage=${curPage-1}">${curPage-1}</a>
</c:if>
<a class="pagiActive" href="${rootPath}/?curPage=${curPage}">${curPage}</a>
<c:if test="${curPage+1 <= endPage}">
<a href="${rootPath}/?curPage=${curPage+1}">${curPage+1}</a>
</c:if>
<c:if test="${curPage+2 <= endPage}">
<a href="${rootPath}/?curPage=${curPage+2}">${curPage+2}</a>
</c:if>
<c:if test="${curPage+3 <= endPage}">
<a href="${rootPath}/?curPage=${curPage+3}">${curPage+3}</a>
</c:if>
<a href="${rootPath}/?curPage=${endPage}">&raquo;</a>

</c:when>

<c:otherwise>


<a href="${rootPath}/kyoto/search?curPage=1&searchVal=${searchVal}">&laquo;</a>
<c:if test="${curPage-3 >= 1}">
<a href="${rootPath}/kyoto/search?curPage=${curPage-3}&searchVal=${searchVal}">${curPage-3}</a>
</c:if>
<c:if test="${curPage-2 >= 1}">
<a href="${rootPath}/kyoto/search?curPage=${curPage-2}&searchVal=${searchVal}">${curPage-2}</a>
</c:if>
<c:if test="${curPage-1 >= 1}">
<a href="${rootPath}/kyoto/search?curPage=${curPage-1}&searchVal=${searchVal}">${curPage-1}</a>
</c:if>
<a class="pagiActive" href="${rootPath}/kyoto/search?curPage=${curPage}&searchVal=${searchVal}">${curPage}</a>
<c:if test="${curPage+1 <= endPage}">
<a href="${rootPath}/kyoto/search?curPage=${curPage+1}&searchVal=${searchVal}">${curPage+1}</a>
</c:if>
<c:if test="${curPage+2 <= endPage}">
<a href="${rootPath}/kyoto/search?curPage=${curPage+2}&searchVal=${searchVal}">${curPage+2}</a>
</c:if>
<c:if test="${curPage+3 <= endPage}">
<a href="${rootPath}/kyoto/search?curPage=${curPage+3}&searchVal=${searchVal}">${curPage+3}</a>
</c:if>
<a href="${rootPath}/kyoto/search?curPage=${endPage}&searchVal=${searchVal}">&raquo;</a>

</c:otherwise>
</c:choose>


</div>









<script>




$(function(){




	var span = $('.imgModalClose')
	var imgModal = $('#imgModal');

	span.click(function(){

		imgModal.css('display', 'none')
		
		})

	

	$('.imgTd').click(function(){


			var $imgSW = "on"

			
			var imgTd = $(this);
			var image = $(this).find('.image');
			var imgModalContent = $('#imgModalContent')
			var imgModalCaption = $('#imgModalCaption')

			imgModal.css('display', 'block')
			imgModalContent.attr('src', image.attr('src')) 
			imgModalCaption.html(image.attr('alt'))

			
		})



	

	
})






/*
 var imgModal = document.getElementById('imgModal');
 var imgTd = document.getElementById("imgTd");
 var image = document.getElementById('image');
 var imgModalContent = document.getElementById('imgModalContent');
 var imgModalCaption = document.getElementById('imgModalCaption');

 
 imgTd.onclick = function(){


	 var image = document.getElementById('image');
	 
	 

	 imgModal.style.display = 'block';
	 imgModalContent.src = image.src;
	 imgModalCaption.innerHTML = image.alt;
	 
	 }

 

 var span = document.getElementsByClassName('imgModalClose')[0];

 		span.onclick = function(){

	 imgModal.style.display = 'none';	
	 
	 }

		 */
</script>


</body>
</html>

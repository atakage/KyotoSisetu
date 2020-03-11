<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


<style>



.commentBox{

	
	border-top: 1px solid black;
    margin-top: 10%;

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

</style>


<c:forEach items="${COMMENTLIST}" var="cmtList" >


<div style="padding: 3%;">
			
			<div class="nicknameBox"><b>${cmtList.u_nickname}</b>さん</div><div class="dateBox" style="display: inline-block; float:right;">${cmtList.c_date}</div>
			<div class="textBox" style="word-break:break-all; margin:10; white-space: pre;">${cmtList.c_text}</div>
			<div class="commentLinear"></div>
			
</div>


</c:forEach>
			
			
			
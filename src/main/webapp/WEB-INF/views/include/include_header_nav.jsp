<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


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


</style>



<header><img src="${rootPath}/resources/img/kyomon.gif" width="150" height="150"><div>京都市の公共施設</div></header>



<div class="navMenuBox">

<ul class="navMenu">
	<li style="float:left;"><a href="${rootPath}/">一覧</a></li>
	<li style="float:right;"><a href="${rootPath}/member/join">会員登録</a></li>
	<li style="float:right;"><a href="#">ログイン</a></li>
	
</ul>

</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>


<%@ include file = "/WEB-INF/views/include/include_header_nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>


.joinTitle{
	
	width: 70%;
    line-height: 3;
    font-size: larger;
    font-weight: bold;
    text-align: center;
    margin-top: 10%;
    background-color: rgba(147, 112, 219, 0.5);


}



.joinBox{
	margin-top: 20%;
	
   
    height: 70%;
    width: 50%;
	    text-align: center;

}


.joinInnerBox{

	width: 90%;
    margin: 130 auto;
   

}

.joinButton:hover {
	cursor: pointer;
}

</style>





<script>


$(function(){



	



	

	$('#loginButton').click(function(){

		$('#u_id').val($('#u_id').val().replace(/\s/g,""))
		$('#u_password').val($('#u_password').val().replace(/\s/g,"")) 
		var formData = $('form').serialize()
		



		$.ajax({


			url:"${rootPath}/member/login", data:formData, type:'post',
			success:function(result){

				if(result == 'ログイン成功'){
				document.location.href="${rootPath}/"
				}else{

					alert(result)
					return false;

					}

				}, error:function(){

					alert('サーバーエラー')

					}



			
			})
		
		})

})



</script>



<body>





<div class="joinBox">
	<form>
	<div>
	<div><input id="u_id" name="u_id" placeholder="ID" maxlength="50" style="font-size: large;"></div>
	<div><input id="u_password" name="u_password" type="password" maxlength="20" placeholder="パスワード" style="font-size: large;"></div>
	<button id="loginButton" type="button" style="font-weight: bold;width: 40%;height: 7%;background: lightslategray;color: white; cursor: pointer;">ログイン</button><br>
	<button onclick="document.location.href='${rootPath}/member/join'" type="button" style="font-weight: bold;width: 40%;height: 7%;background: lightslategray;color: white; cursor: pointer;">会員登録</button>
	</div>
	</form>
</div>





</body>
</html>
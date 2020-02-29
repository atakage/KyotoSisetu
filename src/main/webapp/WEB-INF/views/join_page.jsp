<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
	
	border-bottom: 1px solid;
    border-right: 1px solid;
    border-left: 1px solid;
    border-color: purple;
    height: 70%;
    width: 69.6%;
        display: grid;
	

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

	var mail
	var u_id

	$('#mailCheck').click(function(){


			mail = $('.mailSelect option:selected').val()	
			// remove all whitespace(+middleWS) 
			u_id = $('#mailInput').val().replace(/\s+/g,'')

			 
			if(u_id.length < 1){

				alert('メールアドレスを入力してください')
				return false;

			}


			u_id += mail

			alert(u_id)


			$.ajax({


				url:'${rootPath}/member/mailcheck', data:u_id, type:'post',
				success:function(result){

					alert(result)
					
					},error:function(){

						alert('サーバーエラー')
						
						}

				
				})

			

		
		})

	
})



</script>



<body>



<div class="joinTitle"><a>会員登録</a></div>

<div class="joinBox">

	<div class="joinInnerBox">
	
		<div class="idBox" style="display: flex;float: left; width: 100%;">
			<div style="width: 20%; margin: 0; text-align: center;background-color: whitesmoke;">メールアドレス</div>
			<input id="mailInput" maxlength="３0" style="margin:0;" placeholder="３0文字以内">
			<select class="mailSelect" style="margin: 0;">
				<option value="@yahoo.co.jp">@yahoo.co.jp</option>
				<option value="@gmail.com">@gmail.com</option>
			</select>
			<button id="mailCheck" type="button" style="margin: 0;">チェック</button>
		</div>
	
		<div class="passwordBox" style="display: flex;float: left; width: 100%;">
			<div style="width: 20%; margin: 0; text-align: center;background-color: whitesmoke;">パスワード</div>
			<input  type="password" maxlength="20" style="margin:0;" placeholder="8文字以上ー20文字以内">
			
		</div>
		
		<div class="passwordReBox" style="display: flex;float: left; width: 100%;">
			<div style="width: 20%; margin: 0; text-align: center;background-color: whitesmoke;">パスワード確認</div>
			<input type="password" maxlength="20" style="margin:0;" placeholder="パスワード確認">
			<div style="visibility:hidden; font-size: 14px; color: red; margin:0;">*パスワードが違います</div>
		</div>
		
		
	
		<div class="nicknameBox" style="display: flex;float: left; width: 100%;">
			<div style="width: 20%; margin: 0; text-align: center;background-color: whitesmoke;">ニックネーム</div>
			<input maxlength="8" style="margin:0;" placeholder="8文字以内">
			<button type="button" style="margin: 0;">チェック</button>
		</div>
		
		
		
		<div style="width:100%; text-align: center; font-size: x-large;    margin-top: 24%;">
		<button class="joinButton" type="button" style="font-size: x-large;background: white;color: white;padding: 1% 2%;background: lightslategray;">新規登録する</button>
		</div>
	
	</div>

</div>



</body>
</html>
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


	var checkMailVal = 0
	var checkNickVal = 0
	
	var mail
	var u_id

	var u_nickname







	// 正規表現英語＋数字
	$('#mailInput').keyup(function(event){


		if(!(event.keyCode >= 37 && event.keyCode <= 40)){

			var inputVal = $(this).val()
			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''))

			}

		
		})
	



	



	// input valueの変わり感知
	$('#mailInput').on('propertychange change keyup paste input', function(){

		u_id = ""
		checkMailVal = 0
		$('.mailCheckMSG').css('color', 'red')
		$('.mailCheckMSG').text('*メールチェック必要')
		
		})
		
		
		
	$('.mailSelect').change(function(){

			u_id = ""
			checkMailVal = 0
			$('.mailCheckMSG').css('color', 'red')
			$('.mailCheckMSG').text('*メールチェック必要')
		
		
		
		})
		

	
	$('#nickInput').on('propertychange change keyup paste input', function(){

		u_nickname =""
		checkNickVal = 0
		$('.nickCheckMSG').css('color', 'red')
		$('.nickCheckMSG').text('*ニックネームチェック必要')
		
		})



	

	$('#mailCheck').click(function(){

		


			mail = $('.mailSelect option:selected').val()	
			// remove all whitespace(+middleWS) 
			u_id = $('#mailInput').val().replace(/\s+/g,'')

			 
			if(u_id.length < 1 || u_id.length > 30){

				alert('メールアドレスを正しく入力してください')
				return false;

			}


			u_id += mail

			//alert(u_id)


			$.ajax({


				url:'${rootPath}/member/mailcheck', data:{u_id}, type:'post',
				success:function(result){



					if(result == 'FAIL'){


						alert('既に使用されているメールです')
						return false;
						
						}
					

					
					alert(result)
					checkMailVal = 1;

					$('.mailCheckMSG').text('チェック完了')
					$('.mailCheckMSG').css('color', 'green')
					
					},error:function(){

						alert('サーバーエラー')
						
						}

				
				})

			

		
		})




	$('#nickCheck').click(function(){

	


			
			// remove all whitespace(+middleWS) 
			u_nickname = $('#nickInput').val().replace(/\s+/g,'')

			 
			if(u_nickname.length < 1 || u_nickname.length > 8){

				alert('ニックネームを正しく入力してください')
				return false;

			}


			

			//alert(u_nickname)


			$.ajax({


				url:'${rootPath}/member/nickcheck', data:{u_nickname}, type:'post',
				success:function(result){


					if(result == 'FAIL'){


						alert('既に使用されているニックネームです')
						return false;
						
						}

					
					alert(result)
					checkNickVal = 1;

					$('.nickCheckMSG').text('チェック完了')
					$('.nickCheckMSG').css('color', 'green')
					
					},error:function(){

						alert('サーバーエラー')
						
						}

				
				})

			

		
		})





	$('.joinButton').click(function(){



			if(checkMailVal == 0){

					alert('メールチェックが必要です')
					$('#mailInput').focus()
					return false

				}


			if($('#passwordInput').val().length < 8 || $('#passwordInput').val().length > 20){

					alert('パスワードを正しく入力してください')
					$('#passwordInput').focus()
					return false;

				}

			if($('#passwordReInput').val() != $('#passwordInput').val()){

				alert('パスワードが違います')
				$('#passwordReInput').focus()
				return false;

			}




			if(checkNickVal == 0){

				alert('ニックネームチェックが必要です')
				$('#nickInput').focus()
				return false

			}


			var u_password  = $('#passwordInput').val()

			


			$.ajax({



				url:"${rootPath}/member/insert", data:{u_id, u_password, u_nickname}, type:"post",
				success:function(result){

						alert(result)
						document.location.href="${rootPath}/member/login"
					
					}, error:function(){


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
			<div style="width: 20%; margin: 0; text-align: center;background-color: silver;">メールアドレス</div>
			<input id="mailInput" maxlength=３0 style="margin:0;" placeholder="３0文字以内">
			<select class="mailSelect" style="margin: 0;">
				<option value="@yahoo.co.jp">@yahoo.co.jp</option>
				<option value="@gmail.com">@gmail.com</option>
			</select>
			<button id="mailCheck" type="button" style="margin: 0;">チェック</button>
			<div class="mailCheckMSG" style="visibility:visible; font-size: 14px; color: red; margin:0;">*メールチェック必要</div>
		</div>
	
		<div class="passwordBox" style="display: flex;float: left; width: 100%;">
			<div style="width: 20%; margin: 0; text-align: center;background-color: silver;">パスワード</div>
			<input id="passwordInput" type="password" maxlength=20 style="margin:0;" placeholder="8文字以上ー20文字以内">
			
		</div>
		
		<div class="passwordReBox" style="display: flex;float: left; width: 100%;">
			<div style="width: 20%; margin: 0; text-align: center;background-color: silver;">パスワード確認</div>
			<input id="passwordReInput" type="password" maxlength=20 style="margin:0;" placeholder="パスワード確認">
			<div style="visibility:hidden; font-size: 14px; color: red; margin:0;">*パスワードが違います</div>
		</div>
		
		
	
		<div class="nicknameBox" style="display: flex;float: left; width: 100%;">
			<div style="width: 20%; margin: 0; text-align: center;background-color: silver;">ニックネーム</div>
			<input id="nickInput" maxlength=8 style="margin:0;" placeholder="8文字以内">
			<button id="nickCheck" type="button" style="margin: 0;">チェック</button>
			<div class="nickCheckMSG" style="visibility:visible; font-size: 14px; color: red; margin:0;">*ニックネームチェック必要</div>
		</div>
		
		
		
		<div style="width:100%; text-align: center; font-size: x-large;    margin-top: 24%;">
		<button class="joinButton" type="button" style="font-size: x-large;background: white;color: white;padding: 1% 2%;background: lightslategray;">新規登録する</button>
		</div>
	
	</div>

</div>



</body>
</html>
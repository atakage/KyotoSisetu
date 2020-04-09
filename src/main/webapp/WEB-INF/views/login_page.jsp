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






<script type="text/javascript">
window.yconnectInit = function() {
    YAHOO.JP.yconnect.Authorization.init({
        button: {    // ボタンに関しては下記URLを参考に設定してください
                     // https://developer.yahoo.co.jp/yconnect/loginbuttons.html
            format: "image",
            type: "d",
            textType:"a",
            width: 196,
            height: 38,
            className: "yconnectLogin"
        },
        authorization: {
            clientId: "dj00aiZpPXdKZzJNc1VVWmZoTSZzPWNvbnN1bWVyc2VjcmV0Jng9YjY-",    // 登録したClient IDを入力してください
            redirectUri: "http://localhost:8084/kyoto/member/yahootoken", // 本スクリプトを埋め込むページのURLを入力してください
            scope: "openid email profile address",
            // Authorization Codeフローの場合はresponseType, state, nonceパラメーターは必須です,
            responseType: "code",
            state: "123",
            nonce: "123",
            windowWidth: "500",
            windowHeight: "400"
        },
        onError: function(res) {
            // エラー発生時のコールバック関数
            alert(res)
        },
        onCancel: function(res) {
            // 同意キャンセルされた時のコールバック関数
            alert(res)
        }
    });
};
(function(){

	document.cookie = "crossCookie=bar; SameSite=none; Secure"
var fs = document.getElementsByTagName("script")[0], s = document.createElement("script");
s.setAttribute("src", "http://s.yimg.jp/images/login/yconnect/auth/2.0.3/auth-min.js");
fs.parentNode.insertBefore(s, fs);
})();
</script>




<script>






$(function(){


	var yahooLogMSG = $('#yahooLogMSG').val()


	if(yahooLogMSG == 'findnick'){

		alert('本アカウントの名前はこのサイトで既に使用されています\nYAHOO名前を変更した後再ログインしてください')

	}else if(yahooLogMSG == 'nicklength'){

		alert('本サイトの名前（ニックネーム）は8文字以内に制限しています\nYAHOO名前を変更した後再ログインしてください')
		}




	

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


<input id="yahooLogMSG" type="hidden" value="${yahooLogMSG}">


<div class="joinBox">
	<form>
	<div>
	<div><input id="u_id" name="u_id" placeholder="ID" maxlength="50" style="font-size: large;"></div>
	<div><input id="u_password" name="u_password" type="password" maxlength="20" placeholder="パスワード" style="font-size: large;"></div>
	
	
	<button id="loginButton" type="button" style="font-weight: bold;width: 40%;height: 7%;background: lightslategray;color: white; cursor: pointer;">ログイン</button><br>
	<button onclick="document.location.href='${rootPath}/member/join'" type="button" style="font-weight: bold;width: 40%;height: 7%;background: lightslategray;color: white; cursor: pointer;">会員登録</button><br>
	<span class="yconnectLogin"></span>
	</div>
	</form>
</div>





</body>
</html>
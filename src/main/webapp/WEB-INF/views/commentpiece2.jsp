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
    margin-top: 1%;
    background-color: mediumpurple;
    opacity: 0.4;
    display: inline-block;

}




.deleteButton2:hover{


	cursor: pointer;

}



.insertHensinButton {
    color: #fff;
    font-size: medium;
    background-color: mediumpurple;
    border-color: mediumpurple;
    }

.insertHensinButton:hover {
    color: #fff;
    background-color: rgba(147, 112, 219, 0.5);
	border-color:rgba(147, 112, 219, 0.5);
	}

</style>


<script>

$(function(){

		// ajaxでロードしたページのscriptが動作しない状況に備える
		
		
		
		
	$(document).on('click','.deleteButton2',function(){

		if(!confirm('削除しますか？'))return false
			
			var c_number = $(this).siblings('#c_number2').val()
			var c_f_id = $('#c_f_id').val()
			

			$.ajax({

				/* 
				hidden valueに重要な情報は入れない
				パラメータをhtmlで操作してサーバーに送ることができるからとても危険！
				情報チェックは必ずサーバーで！
				
				 */

				url:"${rootPath}/comment/deletehensin", data:{c_number, c_f_id}, type:'post',
				success:function(result){

					if(result == '削除成功'){
					alert(result)
					document.location.reload()
					}else{

						alert(result)
						}

					},error:function(){

						alert('サーバーエラー')

						}

				
				})


	
	})







	$(document).off().on('click','.insertHensinButton',function(){


		var c_text = $(this).siblings('#c_text2').val()	
		var c_f_id = $('#c_f_id').val()
		var c_p_number = ${c_p_number}

		

		var divAddr = 'commenthenSinEntrance'
			divAddr += c_p_number
		
		
		$.ajax({


			url:"${rootPath}/comment/hensininsert", data:{c_text, c_f_id, c_p_number}, type:'post',
			success:function(result){

				$('.'+divAddr).html(result)

				}, error:function(){


					alert("サーバーエラー")
					
					}


			
			})

		
		
		})
	
	
	
})


</script>



<div class="comment2Box">



<c:if test="${!empty COMMENTLIST2 }">

<c:forEach items="${COMMENTLIST2}" var="cmtList2" >


<div style="padding: 3%; padding-left:10%">
			
			
			<div class="nicknameBox"><b>${cmtList2.u_nickname}</b>さん</div><div class="dateBox" style="display: inline-block; float:right;">${cmtList2.c_date}</div>
			<div class="textBox" style="word-break:break-all; margin:10; white-space: pre;">${cmtList2.c_text}</div>
			<div style="width: 100%;float: right; margin-top: 3%">
			<div>
			<input id="c_number2" type="hidden" value="${cmtList2.c_number}">
			<button class="deleteButton2" style="border: 0;background: 0;font-size: larger; float:right;">&times;</button>
			</div>
			<input id="c_number2" type="hidden" value="${cmtList2.c_number}">
			</div>

			<div class="commentLinear"></div>
			
	
</div>

</c:forEach>	

</c:if>
	
			<c:if test="${!empty USERSESSION }">
			
			<div style="text-align: center;">
			<textarea id="c_text2" style="width: 70%; height: 10%;" placeholder="1000字以内で作成してくだたい" maxlength="1000"></textarea>
			<button class="insertHensinButton" type="button">送信</button>
			
			</div>
			<div class="commentLinear"></div>
			</c:if>
			
			<c:if test="${empty USERSESSION }">
				<div style="text-align: center;font-size: small;line-height: 5;opacity: 0.8;"><a href="${rootPath}/member/login" style="text-decoration: none;">ログイン</a>後作成できます</div>
				<div class="commentLinear"></div>
			</c:if>


</div>
			
			
			
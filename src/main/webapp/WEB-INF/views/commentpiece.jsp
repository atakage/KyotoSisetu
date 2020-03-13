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




.deleteButton:hover{


	cursor: pointer;

}

</style>


<script>

$(function(){


	$('.deleteButton').click(function(){

		if(!confirm('削除しますか？'))return false
			
			var c_number = $(this).siblings('#c_number').val()
			var c_f_id = $('#c_f_id').val()
			

			$.ajax({

				/* 
				hidden valueに重要な情報は入れない
				htmlで操作してサーバーに送ることができるからとても危険！
				情報チェックは必ずサーバーで！
				
				 */

				url:"${rootPath}/comment/delete", data:{c_number, c_f_id}, type:'post',
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
	
	
})


</script>



<c:forEach items="${COMMENTLIST}" var="cmtList" >


<div style="padding: 3%;">
			
			
			<div class="nicknameBox"><b>${cmtList.u_nickname}</b>さん</div><div class="dateBox" style="display: inline-block; float:right;">${cmtList.c_date}</div>
			<div class="textBox" style="word-break:break-all; margin:10; white-space: pre;">${cmtList.c_text}</div>
			<div style="float: right; margin-top: 3%">
			<button class="deleteButton" style="border: 0;background: 0;font-size: larger;">&times;</button>
			<input id="c_number" type="hidden" value="${cmtList.c_number}">
			</div>
			<div class="commentLinear"></div>
			
</div>


</c:forEach>
			
			
			
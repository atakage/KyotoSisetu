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


	
	
		var hensinSW = 'off'


			
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
		
		
		
		
		
		
		$('.hensinButton').click(function(){
//$(document).on('click','.hensinButton',function(){
			
			
			var hensinDDSW = $(this).siblings('#hensinSW').val()
			var createCmt2SW = $(this).siblings('#createCmt2SW').val()
			
			
			if(hensinDDSW == 'off' && createCmt2SW == 'on'){ 
				
			
			var c_p_number = $(this).siblings('#c_number').val()
			var divAddr = 'commenthenSinEntrance'
				divAddr += c_p_number  // divのはてにそれぞれナンバーをつけて
									// 重複適用を防ぐ
				$.ajax({		
					url:"${rootPath}/comment/hensinList", data:{c_p_number}, type:"post",
					success:function(result){
						
						// use variable in jqeury selector 
						$('.'+divAddr).html(result)
							
						
				
						},error:function(){
							alert("サーバーエラー")
							}
					
					})
					
					$(this).siblings('#hensinSW').attr('value', 'on')
					$(this).text('返信▼')
					$(this).siblings('#createCmt2SW').attr('value', 'off')

					
			
				}else if(hensinDDSW == 'on' && createCmt2SW == 'off'){
					var divAddr = 'commenthenSinEntrance'
					var c_p_number = $(this).siblings('#c_number').val()
						divAddr += c_p_number  // divのはてにそれぞれナンバーをつけて
											// 重複適用を防ぐ
											
					
										
											
					$('.'+divAddr).children('.comment2Box').css('display','none')
					$(this).siblings('#hensinSW').attr('value', 'off')
					$(this).text('返信▲')
				}else if(hensinDDSW == 'off' && createCmt2SW == 'off'){
					var divAddr = 'commenthenSinEntrance'
					var c_p_number = $(this).siblings('#c_number').val()
						divAddr += c_p_number  // divのはてにそれぞれナンバーをつけて
												// 重複適用を防ぐ
					
					
					
					$.ajax({		
					url:"${rootPath}/comment/hensinList", data:{c_p_number}, type:"post",
					success:function(result){
						
						
						// html():上書きされる
						// appendTo(): 追加される
						$('.'+divAddr).html(result)
					
						},error:function(){
							alert("サーバーエラー")
							}
					
					})
					
					
												
					$('.'+divAddr).children('.comment2Box').css('display','block')
					$(this).siblings('#hensinSW').attr('value', 'on')
					$(this).text('返信▼')
					}
			
			})
		
		
	})



</script>



<c:forEach items="${COMMENTLIST}" var="cmtList" >


<div class="commentBoxDiv" style="padding: 3%;">
			
			
			<div class="nicknameBox"><b>${cmtList.u_nickname}</b>さん</div><div class="dateBox" style="display: inline-block; float:right;">${cmtList.c_date}</div>
			<div class="textBox" style="word-break:break-all; margin:10; white-space: pre;">${cmtList.c_text}</div>
			<div class="btnBoxDiv" style="width: 100%;float: right; margin-top: 3%">
			
			
			<button class="hensinButton" style="float:left;">返信▲</button>
			<button class="deleteButton" style="border: 0;background: 0;font-size: larger; float:right;">&times;</button>
			
			<input id="c_number" type="hidden" value="${cmtList.c_number}">
			<input id="hensinSW" type="hidden" value="off">
			<input id="createCmt2SW" type="hidden" value="on">
			</div>
			
			<div class="commentLinear"></div>
			
			<div class="commenthenSinEntrance${cmtList.c_number} commenthenSinEntranceEX">
			

			
			</div>
			
			
			
			
			
			
</div>


</c:forEach>
			
			
			
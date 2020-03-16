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







	$(document).on('click','.insertHensinButton',function(){


		var c_text = $(this).siblings('#c_text2').val()	
		var c_f_id = $('#c_f_id').val()
		var c_p_number = $(this).siblings('.c_p_number').val()	

		

		var divAddr = 'commenthenSinEntrance'
			divAddr += c_p_number
		
		alert(divAddr)
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
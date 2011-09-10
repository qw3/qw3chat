window.onbeforeunload = onCloseFechaAtendimento;

function onCloseFechaAtendimento() {
	$.ajax({
		   type: 'post',
		   url: '/fechar_chat',
		   data: { 'id': $('#chat_id').val() },
		   dataType: "json",
		   async: false,
		   success: function(data){
		   }
		});
}

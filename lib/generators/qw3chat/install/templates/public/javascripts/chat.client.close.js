window.onbeforeunload = onCloseFechaAtendimento;

function onCloseFechaAtendimento() {
	$jq.ajax({
		   type: 'post',
		   url: '/fechar_chat',
		   data: { 'id': $jq('#chat_id').val() },
		   dataType: "json",
		   async: false,
		   success: function(data){
				var a = 1;
		   }
		});
}

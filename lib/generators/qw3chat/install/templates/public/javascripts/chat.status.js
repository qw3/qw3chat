$(function() {
	$('select#departamento_id').live('change', function() {
		if($(this).val() != '')
			$.ajax({
				url: "/chat_sessions/verificar_status",
				type: "post",
				data: {
					'departamento_id': $(this).val() 
				}
			});
	});
});


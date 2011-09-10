$(function() {
	setInterval(notificaNovosChats, 2000)
});

function notificaNovosChats() {
	
	// atualiza se estiver na página de chats
	var last_chat = $('#last_chat');
	if( last_chat != null ) $.cookie('last_chat', last_chat.val());

	last_chat = $.cookie('last_chat');

	$.ajax({
		url: "/administrator/novas_notificacoes",
		type: "get",
		data: {
			'last_chat': last_chat 
		},
		success: function(data) {
			data = $.parseJSON(data);
			atualiza = data.atualiza;
			if( atualiza === '1' ) {
				
				$('#chat-notificacao').css('display','block');
				if( $('#chats-form') != null ) $('#chats-form').submit();
				
				// notificações de browser
				if($.browser.mozilla) {
					notificaFirefox('Cliente solicitou atendimento');
				}
				else if($.browser.webkit) {
					showNotification(null, 'Cliente solicitou atendimento', 'Um cliente solicitou atendimento online pelo site.');
				}
				else {
					alert( 'Novo atendimento solicitado' );
				}
			}
			
		}
	});
}
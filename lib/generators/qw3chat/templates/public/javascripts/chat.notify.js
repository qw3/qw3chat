document.observe("dom:loaded", function() {
	setInterval(notificaNovosChats, 5000)
});

function notificaNovosChats() {
	
	var cookies = new CookieJar({
		expires:3600,   // seconds
		path: '/'
	});

	// atualiza se estiver na página de chats
	var last_chat = $('last_chat');
	if( last_chat != null ) cookies.put('last_chat', last_chat.value);

	last_chat = cookies.get('last_chat');

	new Ajax.Request("/administrator/novas_notificacoes", {
		method: "get",
		parameters: {
			last_chat: last_chat 
		},
		onSuccess: function(data) {
			
			resposta = data.responseText.evalJSON();
			if( resposta.atualiza == 1 ) {
				$('chat-notificacao').setStyle({display:'block'});
				if( $('chats-form') != null ) {
					$('chats-form-submit').click();
				}
			}
		}
	});
}
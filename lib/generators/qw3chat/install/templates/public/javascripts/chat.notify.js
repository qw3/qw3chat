var notificado = false;

$(function() {
	setInterval(notificaNovosChats, 2000);
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

				if( $('#chats-form') != null ) $('#chats-form').submit();
				// notificações de browser
				if($.browser.mozilla) {
					showNotificationFirefox('Cliente solicitou atendimento');
				}
				else if($.browser.webkit) {
					showNotification(null, 'Cliente solicitou atendimento', 'Um cliente solicitou atendimento online pelo site.');
				}
				else {
					alert( 'Novo atendimento solicitado' );
				}
				// cria a caixa de notificações
				if($('#chat-notificacao').length > 0)
					$('#chat-notificacao').css('display', 'block');
				else
					$('body').append('<div id="chat-notificacao"><div class="notificacao"><h1>Novo atendimento</h1><div class="inside">Um novo cliente solicitou atendimento.</div><a href="/administrator/chats?status=0"><span>Ver os atendimentos</span></a></div></div>');
			}
			
		}
	});
}

function createNotificationInstance(options) {
  if (options.notificationType == 'simple') {
    return window.webkitNotifications.createNotification(
        'icon.png', 'Notification Title', 'Notification content...');
  } else if (options.notificationType == 'html') {
    return window.webkitNotifications.createHTMLNotification('http://someurl.com');
  }
}

function showNotification(icon, title, description) {
	if( !notificado ) {
	  if(window.webkitNotifications.checkPermission() == 0)
      	window.webkitNotifications.createNotification(icon, title, description).show();
      else
      	alert(title);
      notificado = true;
    }
}

function showNotificationFirefox(title) {
	if(!notificado) {
		java.awt.Toolkit.getDefaultToolkit().beep();
		alert( title );
		notificado = true;
	}
	
}

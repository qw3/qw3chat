var notificado = 0;

//requestPermission(in Function callback)
function setAllowNotification() {
	window.webkitNotifications.requestPermission(permissionGranted);
}

function permissionGranted() {
	if (window.webkitNotifications.checkPermission() == 0) {
		window.webkitNotifications.createNotification('/images/qw3chat/atendimento/atender.png', 'Agora você pode receber notificações de atendimento.');
		$('#welcome .ponto .aberto form').submit();
	}
}

function showNotification(chat_id, icon, title, description) {
	if(notificado != chat_id) {
		if (window.webkitNotifications.checkPermission() != 0) {
			alert(title);
		}
		else {
			n = window.webkitNotifications.createNotification(icon, title, description);
			n.show();
		}
		notificado = chat_id;
	}
}

function notificaFirefox(chat_id, title) {
	if(notificado != chat_id) {
		java.awt.Toolkit.getDefaultToolkit().beep();
		alert( title );
		notificado = chat_id;
	}
}

$(function() {
	if($.browser.webkit) {
		$('#welcome .ponto .aberto form input[type="submit"]').live('click', function() {
			if (window.webkitNotifications.checkPermission() != 0) {
				setAllowNotification();
				return false;
			}
		});
	}
});
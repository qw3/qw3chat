var notificado = false;

$('div.ponto .aberto form input[type="submit"]').live('click', function() {
	if (window.webkitNotifications.checkPermission() > 0) {
      window.webkitNotifications.requestPermission();
   }	
});

function showNotification(icon, title, description) {
	if( !notificado ) {
      window.webkitNotifications.createNotification(icon, title, description).show();
      notificado = true;
    }
}

function notificaFirefox(title) {
	if(!notificado) {
		java.awt.Toolkit.getDefaultToolkit().beep();
		alert( title );
		notificado = true;
	}
	
}

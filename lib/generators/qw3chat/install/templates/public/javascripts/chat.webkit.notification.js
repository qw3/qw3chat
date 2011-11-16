var notificado = false;

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

function notificaFirefox(title) {
	if(!notificado) {
		java.awt.Toolkit.getDefaultToolkit().beep();
		alert( title );
		notificado = true;
	}
	
}

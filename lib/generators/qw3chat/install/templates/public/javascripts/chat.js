var instanse = false;
var last_id;
var chat_id;
var client;
var token;

function Chat () {
    this.update		= updateChat;
    this.send 		= sendChat;
	this.setID 		= setID;
	this.setClient 	= setClient;
	this.setToken  	= setToken;
}

function setID(id) {
	chat_id = id;
}

function setClient(_client) {
	client = _client;
}

function setToken(_token) {
	token = _token;
}

// Atualiza a tela
function updateChat() {
	
	if(last_id == null)
		last_id = 0;
		
	if(client == null || client == 1) update_url = '/atualiza_mensagens';
	else update_url = '/administrator/atualiza_mensagens';
		
	 if(!instanse){
		 instanse = true;
	     $.ajax({
			   type: "post",
		   	   url: update_url,
			   data: {  
					'last_id': last_id, 
					'chat_id':chat_id, 
					'client':client
			    },
			   dataType: "json",
			   success: function(data){
			   	
					if( data.finalizado != null && data.finalizado == "1") {
						if( client != null && client == "1") url = "/chat_clientes/new";
						else url = "/administrator/chats";
						
						window.location = url + "?finalizado=1";
					}
				   	if(data.length > 0) {						
						for(var i=0; i < data.length; i++) {
							mensagem = data[i];
							$('#chat-area').append($('<p><span>' + mensagem.autor + '</span>' + mensagem.texto +'</p>'));
							last_id = mensagem.id;
						}
					}
				   	document.getElementById('chat-area').scrollTop = document.getElementById('chat-area').scrollHeight;
				   	instanse = false;
			   }
			});
	 }
	 else {
		 setTimeout(updateChat, 10000);
	 }
}

// Envia a mensagem
function sendChat(message, nickname, id)
{
	
	if(client == null || client == 1) {
		send_url = '/mensagens';
	}
	else {
		send_url = '/administrator/nova-mensagem';
	}
	
    updateChat();
     $.ajax({
		   type: 'post',
		   url: send_url,
		   data: { 
					'mensagem[texto]': message,
					'mensagem[autor]': nickname,
					'mensagem[chat_id]': chat_id,
					'client':client
				 },
		   dataType: "json",
		   success: function(data){
			   updateChat();
		   },
		});
}

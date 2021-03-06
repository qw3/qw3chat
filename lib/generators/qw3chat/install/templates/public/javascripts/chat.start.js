// kick off chat
var chat =  new Chat();
var nome;
var chat_id;
var client;
var token; 

$(function() {
	nome 		= $('#nome').val();
	chat_id 	= $('#chat_id').val();
	client		= $('#client').val();
	token		= $('#token').val();

	chat.setID(chat_id);
	chat.setClient(client);
	chat.setToken(token);
	
	$("#mensagem_texto").focus();
	 
    $("#mensagem_texto").keydown(function(event) {  
     
         var key = event.which;  
   
         //all keys including return.  
         if (key >= 33) {
           
             var maxLength = $(this).attr("maxlength");  
             var length = this.value.length;  
             
             // don't allow new content if length is maxed out
             if (length >= maxLength) {  
                 event.preventDefault();  
             }  
          }  
	 });

	 $('#mensagem_texto').keyup(function(e) {	
	 					 
		  if (e.keyCode == 13) { 
		  
            var text = $(this).val();
			var maxLength = $(this).attr("maxlength");  
            var length = text.length; 
             
            // send 
            if (length <= maxLength + 1) { 
		        chat.send(text, nome);	
		        $(this).val("");
            } else {
				$(this).val(text.substring(0, maxLength));
			}	
		  }
     });

	setInterval('chat.update()', 2000);
    
});


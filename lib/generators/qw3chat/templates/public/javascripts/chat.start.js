nome 		= $jq('#nome').val();
chat_id 	= $jq('#chat_id').val();
client		= $jq('#client').val();
token		= $jq('#token').val();

// kick off chat
var chat =  new Chat();
$jq(function() {

	chat.setID(chat_id);
	chat.setClient(client);
	chat.setToken(token);
	 
    $jq("#mensagem_texto").keydown(function(event) {  
     
         var key = event.which;  
   
         //all keys including return.  
         if (key >= 33) {
           
             var maxLength = $jq(this).attr("maxlength");  
             var length = this.value.length;  
             
             // don't allow new content if length is maxed out
             if (length >= maxLength) {  
                 event.preventDefault();  
             }  
          }  
	 });

	 $jq('#mensagem_texto').keyup(function(e) {	
	 					 
		  if (e.keyCode == 13) { 
		  
            var text = $jq(this).val();
			var maxLength = $jq(this).attr("maxlength");  
            var length = text.length; 
             
            // send 
            if (length <= maxLength + 1) { 
		        chat.send(text, nome);	
		        $jq(this).val("");
            } else {
				$jq(this).val(text.substring(0, maxLength));
			}	
		  }
     });
    
});

setInterval('chat.update()', 2000);
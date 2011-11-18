class ChatAtendente < Administrador
  
  belongs_to :chat_departamento
  attr_accessible :chat_departamento, :chat_departamento_id
  
end
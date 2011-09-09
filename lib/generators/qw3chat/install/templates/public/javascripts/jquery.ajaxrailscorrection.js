// pega o token do rails e coloca nas requisições POST
$jq.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', $jq('meta[name="csrf-token"]').attr('content'));
  }
});
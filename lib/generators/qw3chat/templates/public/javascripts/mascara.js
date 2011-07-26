function mascara(o, f) {
    v_obj = o;
    v_fun = f;
    setTimeout("execmascara()", 1);
}

function execmascara() {
    v_obj.value = v_fun(v_obj.value);
}

function checaCPF(v) {
    v = v.replace(/\D/g, "") //Remove tudo o que n?o ? d?gito
    v = v.replace(/(\d{3})(\d)/, "$1.$2");
    v = v.replace(/(\d{3})(\d)/, "$1.$2");
    v = v.replace(/(\d{3})(\d)/, "$1-$2");
    return v;
}

function checaCEP(v) {
    v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
    v = v.replace(/(\d{5})(\d)/, "$1-$2");
    return v;
}

function checaCNPJ(v) {
    v = v.replace(/\D/g, "");
    v = v.replace(/(\d{2})(\d)/, "$1.$2");
    v = v.replace(/(\d{3})(\d)/, "$1.$2");
    v = v.replace(/(\d{3})(\d)/, "$1/$2");
    v = v.replace(/(\d{4})(\d)/, "$1-$2");

    return v;
}

function checaData(v) {
    v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
    v = v.replace(/(\d{2})(\d)/, "$1/$2"); //Coloca um ponto entre o terceiro e o quarto d?gitos
    v = v.replace(/(\d{2})(\d)/, "$1/$2"); //Coloca um ponto entre o terceiro e o quarto d?gitos
    //de novo (para o segundo bloco de n?meros)
    return v;
}

function cepverif(v) {
    v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
    v = v.replace(/(\d{5})(\d)/, "$1-$2");//Coloca um tra?o entre o quinto e o sexto d?gitos
    return v;
}

function checaTelefone(v) {
    v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
    v = v.replace(/^(\d\d)(\d)/g, "($1) $2"); //Coloca par?nteses em volta dos dois primeiros d?gitos
    v = v.replace(/(\d{4})(\d)/, "$1-$2"); //Coloca h?fen entre o quarto e o quinto d?gitos
    return v;
}

function checaNumero(v) {
    v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
    return v;
}

function checaValor(v) {

    v = v.replace(/\D/g, ""); //permite digitar apenas números
    v = v.replace(/(\d{1})(\d{14})$/, "$1.$2");
    v = v.replace(/(\d{1})(\d{11})$/, "$1.$2");
    v = v.replace(/(\d{1})(\d{8})$/, "$1.$2"); //coloca ponto antes dos últimos 8 digitos
    v = v.replace(/(\d{1})(\d{5})$/, "$1.$2"); //coloca ponto antes dos últimos 5 digitos
    v = v.replace(/(\d{1})(\d{1,2})$/, "$1,$2"); //coloca virgula antes dos últimos 2 digitos

    return v;

}

function checaEmail( value ) {
    regex=/^[a-zA-Z0-9._-]+@([a-zA-Z0-9.-]+\.)+[a-zA-Z0-9.-]{2,4}$/;
    return regex.test( value );
}
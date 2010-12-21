if (Element.visible('form_form')) {
    $('form_form').visualEffect("blindUp");
    $('form_inout').innerHTML = "追加";
} else {
    $('form_form').visualEffect("blindDown");
    $('form_inout').innerHTML = "フォームを隠す";
}

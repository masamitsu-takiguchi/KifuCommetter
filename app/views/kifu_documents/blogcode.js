if (Element.visible('blogcode')) {
    $('blogcode').visualEffect("blindUp");
    $('blogcode_inout').innerHTML = "ブログに貼り付ける";
} else {
    $('blogcode').visualEffect("blindDown");
    $('blogcode_inout').innerHTML = "コードを隠す";
}

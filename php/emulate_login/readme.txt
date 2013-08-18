///////////// ok
// qq
curl -d "qq=123593090&pwd=xx&toQQchat=true&q_from=&modifySKey=0&loginType=1&aid=nLoginHandle" http://pt.3g.qq.com/handleLogin?aid=nLoginHandle&sid=ATAll43N7ZULRQ5V8zdfojol
// qq mail
curl -d "f=xhtmlmp&delegate_url=&f=xhtmlmp&action=&tfcont=&uin=123593090&aliastype=%40qq.com&pwd=wqf363wqf363&mss=1&mtk=&btlogin=%E7%99%BB%E5%BD%95" http://w.mail.qq.com/cgi-bin/login

//////////// error
// renren:  password 64位加密, 
curl -d "email=wqf363%40hotmail.com&icode=&origURL=http%3A%2F%2Fwww.renren.com%2Fhome&domain=renren.com&key_id=1&captcha_type=web_login&password=03591de8b206c3a0e749dcf69a11e5e07d6fc6c1696e4546714488f75834490d&rkey=d0cf42c2d3d337f9e5d14083f2d52cb2" http://www.renren.com/PLogin.do

// douban: captcha-id
curl -d "source=simple&redir=http%3A%2F%2Fwww.douban.com%2F&form_email=wuqifu%40gmail.com&form_password=x&captcha-solution=country&captcha-id=74pv81jsZhJ026Dw2BvMpP83&user_login=%E7%99%BB%E5%BD%95"" https://www.douban.com/accounts/login

// mediawiki: wpLoginToken
curl -d "wpName=dennycn&wpPassword=wqf363&wpLoginAttempt=Log+in&wpLoginToken=b0fb7ead82a9a930a9fcb7f9d2a121df" http://localhost/wiki/index.php?title=%E7%89%B9%E6%AE%8A:%E7%94%A8%E6%88%B7%E7%99%BB%E5%BD%95&returnto=%E9%A6%96%E9%A1%B5


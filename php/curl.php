<?php

class Curl
{
	static public function encodeURL($url)
	{
		$u = explode('/', $url);
		foreach ($u as $k => $one)
		{
			if ($k % 2 == 0 && $k > 2)
				$u[$k] = urlencode($one);
		}
		return implode('/', $u);
	}
	
	static public function makeParamStr($param, $encode='')
	{
		foreach ($param as $key => $value)
		{
			$encode && $value = urlencode(mb_convert_encoding($value,$encode,'utf-8'));
			$p[] = $key . '=' . $value;
		}
		return implode('&', $p);
	}


	static public function post($data)
	{
		if(!isset($data['url']))
			return '';

		while(true)
		{
			$ip = rand(1,255).".".rand(1,255).".".rand(1,255).".".rand(1,255);
			if(filter_var($ip,FILTER_VALIDATE_IP, FILTER_FLAG_IPV4 | FILTER_FLAG_NO_PRIV_RANGE))
				break;
		}
		$timeout = 10;

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $data['url']);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);

		if(isset($data['referer']))
			curl_setopt($ch, CURLOPT_REFERER ,$data['referer']);

		if(isset($data['ua']))
			curl_setopt($ch, CURLOPT_USERAGENT ,$data['ua']);

		if(isset($data['cookie'])){
			curl_setopt($ch, CURLOPT_COOKIEFILE, $data['cookie']);
		}

		if(isset($data['params']))
		{
			$params = self::makeParamStr($data['params']);
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
		}

		curl_setopt($ch,CURLOPT_HTTPHEADER,array("CLIENT-IP: $ip", "X_FORWARD_FOR:$ip", "X-FORWARDED-FOR: $ip"));
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

		$out = curl_exec($ch);
		curl_close($ch);

		echo "IP:$ip\n";
		return $out;
	}
}


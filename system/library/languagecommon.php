<?php

/**
 * Class Language
 *
 * @property Config config
 *
 */
final class LanguageCommon
{
	private $code = 'vn';
	private $data = array();

	public function __construct()
	{
		$this->config = Registry::get('config');
		$this->request = Registry::get('request');
		$this->session = Registry::get('session');

		$this->languages = array_map('trim', explode(',', $this->config->get('config_language')));

		if ($this->request->get['lang'] != "") {
			$this->set(trim($this->request->get['lang']));
		} elseif (@array_key_exists($this->session->data['lang_session'], $this->languages)) {
			$this->set($this->session->data['lang_session']);
		} else {
			$this->set($this->code);
		}

		//get language from json file
		$this->getDefaultDictionary();
	}

	public function set($language)
	{
		$this->code = $language;
		if ((!isset($this->session->data['lang_session'])) || ($this->session->data['lang_session'] != $this->code)) {
			$this->session->set('lang_session', $this->code);
		}
		/*
		if ((!isset($this->request->cookie['language'])) || ($this->request->cookie['language'] != $this->code)) {
		setcookie('language', $this->code, time() + 60 * 60 * 24 * 30, '/', $_SERVER['HTTP_HOST']);
		}
		*/
	}

	public function get($key)
	{
		return (isset($this->data[$key]) ? $this->data[$key] : $key);
	}

	public function getCode()
	{
		return $this->code;
	}

	public function getData()
	{
		return $this->data;
	}

	private function getDefaultDictionary()
	{
		$filename = DIR_USERLANGUAGE . "language.json";
		if (!file_exists($filename)) {
			$filename = DIR_LANGUAGE . "language.json";
			if (!is_file($filename)) {
				file_put_contents($filename, "");
			}
		} else {
			$contents = file_get_contents($filename);
			$obj = json_decode($contents);

			$_ = array();
			$defaultlanguageid = $this->getCode();

			if (count($obj)) {
				foreach ($obj as $item) {
					$_[$item->languagekey] = $item->$defaultlanguageid;
				}
			}
			$this->data = array_merge($this->data, $_);
		}
		return $this->data;
	}
}
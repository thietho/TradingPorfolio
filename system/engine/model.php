<?php

/**
 * Class Model
 *
 * @property DB db
 * @property Raw raw
 * @property Member member
 * @property User user
 *
 */
abstract class Model {
	public function __construct() {

	}

	public function __get($key) {
		return Registry::get($key);
	}

	public function __set($key, $value) {
		Registry::set($key, $value);
	}
}
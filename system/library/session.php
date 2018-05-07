<?php

class Session
{
    public $data = array();

    public function __construct()
    {
        if (!session_id()) {
            ini_set('session.use_only_cookies', 'Off');
            ini_set('session.use_cookies', 'On');
            ini_set('session.use_trans_sid', 'Off');
            ini_set('session.cookie_httponly', 'On');

            if (isset($_COOKIE[session_name()]) && !preg_match('/^[a-zA-Z0-9,\-]{22,40}$/', $_COOKIE[session_name()])) {
                exit();
            }

            session_set_cookie_params(0, '/');
            session_start();
        }

        $this->data = $_SESSION;
    }

    public function start()
    {
        return session_start();
    }

    public function destroy()
    {
        session_destroy();
        $this->data = null;
        unset($this->data);
    }

    public function set($key, $value)
    {
        $_SESSION[$key] = $value;
        $this->data[$key] = $value;
    }

    public function remove($key)
    {
        $_SESSION[$key] = null;
        $this->data[$key] = null;
        unset($_SESSION[$key]);
        unset($this->data[$key]);
    }
}

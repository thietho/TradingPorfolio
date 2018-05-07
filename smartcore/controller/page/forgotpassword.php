<?php

/**
 * Class ControllerPageHome
 *
 *
 */
class ControllerPageForgotPassword extends Controller
{
    public function index()
    {
        $this->template = "page/base_forgotpassword.tpl";
        $this->render(true);
    }


    public function checkLogin()
    {
        //login if has token
        if ('' != $_COOKIE['user_token'] && !$this->user->isLogged()) {
            if ($this->user->loginToken($this->request->cookie['user_token'], $this->request->cookie['user_password'])) {
                setcookie("user_token", $this->request->cookie['user_token'], time() + 3600 * 24 * 30, '/');
                setcookie("user_password", $this->request->cookie['user_password'], time() + 3600 * 24 * 30, '/');
            } else {
                setcookie("user_token", '', 1, '/');
                setcookie("user_password", '', 1, '/');
            }
        }


        if (!$this->user->isLogged()) {
            //$route = $this->getRoute();
            //$part = explode('/', $route);
            //$ignore = array('common/forgotpassword');
            return $this->forward('page/login/index');
        }

    }
}
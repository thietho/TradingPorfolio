<?php

/**
 * Class ControllerCommonFooter
 *
 *
 * @property User user
 * @property ModelCoreUser model_core_user
 */
class ControllerCommonForgotPassword extends Controller
{
    private $error;

    public function __construct() {
        //load language
        $this->language->load("common/forgotpassword");

        $this->load->model("core/user");
    }

    public function index()
    {
        $data = $this->request->post;

        if(isset($data['email'])) {
            if($this->validate($data)) {
                /*
                $this->load->helper('mail');
                //Send mail
                $to = $customer['email'];
                $subject = $this->language->get("lang_label_renew_password");
                $template = $this->language->get("lang_email_template_renew_password");
                $param = array(
                    '{customername}' => $customer['firstname'] . " " . $customer['lastname'],
                    '{sitename}' => $this->config->get('config_sitename'),
                    '{email}' => $customer['email'],
                    '{password}' => $newpass
                );


                $customer['newpassword'] = $newpass;
                $arr = array($customer);
                $forgotpasswordTemplate = $this->load->controller('common/forgotpassword','forgotpasswordTemplate', $arr);

                //HelperMail::sendEmail($this->config->get('config_contactemail'), $to, $this->config->get('config_sitename'), $subject, "", $message);
                HelperPHPMailer::sendEmail($this->config->get('config_contactemail'), $to, $this->config->get('config_sitename'), $subject, "", $forgotpasswordTemplate);
                */

                $user = $this->model_core_user->getItemByEmail($data['email']);
                $from = $this->config->get('config_contactemail');
                $to = $user['email'];


                $newpass = $this->string->generateRandStr(6);
                $this->model_core_user->changeNewPassword($user['userid'], $newpass);
                $user['newpass'] = $newpass;

                $this->data['ok'] = "true";

                //send email
                //********************************************************************************************************
                //SEND MAIL TO ADMIN NOTIFY HAVE NEW CONTACT
                $subject = "[" . $this->config->get('config_sitename') . "] Resset password";
                $arr = array($user);
                $emailTemplate = $this->load->controller('common/forgotpassword','forgotpasswordTemplate', $arr);

                //HelperMail::sendEmail($data['email'], $this->config->get('config_contactemail'), $this->config->get('config_sitename'), $subject, "", $message);
                HelperPHPMailer::sendEmail($from, $to, $this->config->get('config_sitename'), $subject, "", $emailTemplate);
                //END SEND MAIL TO ADMIN NOTIFY HAVE NEW CONTACT
                //********************************************************************************************************


            } else {
                $this->data['error'] = $this->error;
            }
        }


        $this->template = "common/forgotpassword.tpl";
        $this->layout = "page/forgotpassword";
        $this->render();
    }


    protected function validate($data)
    {
        $this->error = '';
        if ($data['email'] == "") {
            $this->error = "Please insert email";
        } else if (!$this->validation->checkEmail($data['email'])) {
            $this->error = "Please insert email";
        } else {
            //check email exists in system
            $user = $this->model_core_user->getItemByEmail($data['email']);
            if(count($user) == 0) {
                $this->error = "Email is invalid";
            }
        }

        if($this->error != '') {
            return false;
        }
        return true;
    }


    public function forgotpasswordTemplate($data)
    {
        $this->data['user'] = $data;

        $this->template = "email/forgotpassword.tpl";
        $this->render();
    }


}
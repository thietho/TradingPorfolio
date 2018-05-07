<?php

/**
 * Class ControllerCoreUser
 *
 * @property ModelCoreUser model_core_user
 * @property ModelCoreUsertype model_core_usertype
 *
 */
class ControllerCoreUser extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("core/user");
        $this->load->model("core/usertype");
        $this->language->load("core/user");
    }

    public function index()
    {
        $this->checkPermisson();
        $this->getList();
    }


    public function getList()
    {
        $this->template = "core/user_list.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if($type == 'popup')
            $this->layout = "";
        $this->render();
    }

    public function loadData()
    {
        $where = "";
        $datasearch = $this->request->get;
        if($datasearch['name'])
        {
            $where .= " AND `fullname` like '%".$datasearch['name']."%'";
        }
        if($datasearch['username'])
        {
            $where .= " AND `username` like '%".$datasearch['username']."%'";
        }
        if($datasearch['status'])
        {
            $where .= " AND `status` like '".$datasearch['status']."'";
        }

        $page = preg_replace('#[^0-9]#i', '', $this->request->get['page']);
        if($page == '')
            $page =1;
        $this->data['page'] = $page;
        $from = ($page - 1) * $this->itemsPerPage;
        $to = $this->itemsPerPage;
        $this->data['users'] = $this->model_core_user->getList($where,$from, $to);


        $data = $this->model_core_user->getList($where);
        $total = count($data);


        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'user-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();


        $this->template = "core/user_table.tpl";
        $this->render();
    }


    public function update()
    {
        $this->getForm();
    }

    public function insert()
    {
        $this->data['isInsert'] = true;
        $this->getForm();
    }

    private function getForm()
    {
        $this->checkPermisson();


        if(isset($this->request->get['userid'])) {
            $this->data['user'] = $this->model_core_user->getItem($this->request->get['userid']);
        }

        $this->data['usertypes'] = $this->model_core_usertype->getAllUsertype();


        $this->template = "core/user_form.tpl";
        $this->layout = "page/home";
        $this->render();
    }

    public function save() {
        $data = $this->request->post;
        $data['email'] = strtolower($data['email']);

        $data['siteid'] = SITEID;
        //validate
        $response = array();
        $response['status'] = 'failed';
        $response['title'] = $this->language->get("lang_text_notification");
        $response['message'] = $this->language->get("lang_text_save_failed");

        if (!$this->validate($data)) {
            $response['status'] = 'failed';
            $response['errors'] = $this->errors;

        } else {
            //update user
            if("" == $data['userid']) {
                $this->model_core_user->insertUser($data);
            } else {
                $this->model_core_user->updateUser($data);
            }
            $response['status'] = 'ok';
            $response['message'] = $this->language->get("lang_text_save_success");
        }

        $this->data['output'] = json_encode($response, true);
        $this->template = 'common/output.tpl';
        $this->render();
    }


    private function validate($data)
    {
        $this->errors = array();
        if ("" == $data['username']) {
            $this->errors['username'] = $this->language->get("lang_err_username_required");
        }
        if ("" == $data['fullname']) {
            $this->errors['fullname'] = $this->language->get("lang_err_fullname_required");
        }
        if ("" == $data['email']) {
            $this->errors['email-required'] = $this->language->get("lang_err_email_required");
        } else {
            //check email
            if(!$this->validation->checkEmail($data['email'])) {
                $this->errors['email-invalid'] = $this->language->get("lang_err_email_invalid");
            }
        }

        //validate password
        if("" == $data['userid']) {
            if("" !== $data['username']) {
                $user = $this->model_core_user->getItemByUserName($data['username']);
                if (count($user) > 0) {
                    $this->errors['username-used'] = $this->data['lang_err_username_used'];
                }
            }

            if("" == $data['password']) {
                $this->errors['password-required'] = $this->language->get("lang_err_password_required");
            } else if(strlen($data['password']) < 5) {
                $this->errors['password-length'] = $this->language->get("lang_err_password_length");
            }

            if("" == $data['confirmpassword']) {
                $this->errors['confirmpassword-required'] = $this->language->get("lang_err_password_required");
            }

            if(strlen($data['password']) >= 5 && strlen($data['confirmpassword']) >= 5) {
                if($data['confirmpassword'] != $data['password']) {
                    $this->errors['confirmpassword-match'] = $this->language->get("lang_err_password_match");
                }
            }
        }


        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }


    public function active()
    {
        $userid = $this->request->post['userid'];
        $user = $this->model_core_user->getItem($userid);

        $response = array();
        $response['status'] = 'failed';
        $response['title'] = $this->language->get("lang_text_notification");
        $response['message'] = $this->language->get("lang_text_save_failed");
        if (count($user) == 0) {
            $response['status'] = 'failed';
            $response['errors'] = $this->errors;

        } else {
            $data['userid'] = $userid;
            if ($user['status'] == "lock") {
                $data['status'] = "active";
            } else {
                $data['status'] = "lock";
            }
            $this->model_core_user->updatestatus($data);

            $response['status'] = 'ok';
            $response['message'] = $this->language->get("lang_text_save_success");
        }

        $this->data['output'] = json_encode($response, true);
        $this->template = "common/output.tpl";
        $this->render();
    }


    public function delete()
    {
        $userid = $this->request->post['userid'];
        $response = array();
        $response['status'] = 'failed';
        $response['title'] = $this->language->get("lang_text_notification");
        $response['message'] = $this->language->get("lang_text_save_failed");

        if ($userid) {
            $this->model_core_user->deleteUser($userid);
            $this->data['output'] = $this->data['announ_del'];

            $response['status'] = 'ok';
            $response['message'] = $this->language->get("lang_text_save_success");
        }


        $this->data['output'] = json_encode($response, true);
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function changepassword()
    {
        $this->data['item'] = $this->model_core_user->getItem($this->user->getId());
        $this->template = "core/user_changepassword.tpl";
        $this->layout = "page/home";
        $this->render();
    }
    public function actionchangepass()
    {
        $data = $this->request->post;
        if($this->validateChangePass($data))
        {
            $user['userid'] = $this->user->getId();
            $user['password'] = md5($data['password']);
            $user['updateddate'] = $this->date->getToday();
            $user['updatedby'] = $this->user->getId();
            $this->model_core_user->changePassword($user);
            $data['errors'] = array();
            $data['errorstext'] = '';

        }
        else
        {
            $data['errors'] = $this->errors;
            $data['errorstext'] = '';
            foreach($this->errors as $error)
            {
                $data['errorstext'] .= $error."<br>";
            }
        }
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }

    private function validateChangePass($data)
    {
        $this->errors = array();
        //validate password
        if("" == $data['oldpassword']) {
            $this->errors['oldpassword-required'] = $this->language->get("lang_err_oldpassword_required");
        } else {
            $user = $this->model_core_user->getItem($this->user->getId());
            if (md5($data['oldpassword']) != $user['password']) {
                $this->errors['oldpassword-invalid'] = $this->language->get("lang_err_oldpassword_invalid");
            }
        }


        if("" == $data['password']) {
            $this->errors['password-required'] = $this->language->get("lang_err_password_required");
        } else if(strlen($data['password']) < 6) {
            $this->errors['password-length'] = $this->language->get("lang_err_password_length");
        }

        if("" == $data['confirmpassword']) {
            $this->errors['confirmpassword-required'] = $this->language->get("lang_err_confirmpassword_required");
        }

        if($data['confirmpassword'] != $data['password']) {
            $this->errors['confirmpassword-match'] = $this->language->get("lang_err_password_match");
        }




        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }


    function resetPassword()
    {
        $response = array();
        $response['status'] = 'failed';
        $response['title'] = $this->language->get("lang_text_notification");
        $response['message'] = "Reset password failed";


        $userid = $this->request->post['userid'];

        $newPassword = $this->string->generateRandStr(6);
        //save new password
        $this->model_core_user->changeNewPassword($userid, $newPassword);

        //send email to account
        $user = $this->model_core_user->getItem($userid);
        if($user) {
            $user['newpass'] = $newPassword;
            $from = $this->config->get('config_contactemail');
            $to = $user['email'];

            //send email
            //********************************************************************************************************
            //SEND MAIL TO ADMIN NOTIFY HAVE NEW CONTACT
            $subject = "[" . $this->config->get('config_sitename') . "] Resset password";
            $arr = array($user);
            $emailTemplate = $this->load->controller('common/forgotpassword','forgotpasswordTemplate', $arr);


            $response['status'] = 'ok';
            $response['message'] = 'Password was reset';

            //HelperMail::sendEmail($data['email'], $this->config->get('config_contactemail'), $this->config->get('config_sitename'), $subject, "", $message);
            HelperPHPMailer::sendEmail($from, $to, $this->config->get('config_sitename'), $subject, "", $emailTemplate);
            //END SEND MAIL TO ADMIN NOTIFY HAVE NEW CONTACT
            //********************************************************************************************************

        }

        $this->data['output'] = json_encode($response, true);
        $this->template = "common/output.tpl";
        $this->render();

    }


}
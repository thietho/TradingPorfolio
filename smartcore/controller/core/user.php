<?php

/**
 * Class ControllerCoreUser
 * @property ModelCoreUser model_core_user
 * @property ModelCoreUserType model_core_usertype
 *
 */
class ControllerCoreUser extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->language->load('core/user');
        $this->load->model("core/user");
        $this->load->model("core/usertype");
        $this->data['usertypes'] = $this->model_core_usertype->getList();
    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "core/user_list.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();

    }

    public function loadData()
    {
        $where = " ";
        $datasearch = $this->request->get;
        if ($datasearch['userid']) {
			$where .= " AND `userid` like '%" . $datasearch['userid'] . "%'";
		}
		if ($datasearch['usertypeid']) {
			$where .= " AND `usertypeid` like '%" . $datasearch['usertypeid'] . "%'";
		}
		if ($datasearch['username']) {
			$where .= " AND `username` like '%" . $datasearch['username'] . "%'";
		}
		if ($datasearch['password']) {
			$where .= " AND `password` like '%" . $datasearch['password'] . "%'";
		}
		if ($datasearch['fullname']) {
			$where .= " AND `fullname` like '%" . $datasearch['fullname'] . "%'";
		}
		if ($datasearch['email']) {
			$where .= " AND `email` like '%" . $datasearch['email'] . "%'";
		}
		if ($datasearch['status']) {
			$where .= " AND `status` like '%" . $datasearch['status'] . "%'";
		}
		if ($datasearch['imagepath']) {
			$where .= " AND `imagepath` like '%" . $datasearch['imagepath'] . "%'";
		}
		if ($datasearch['phone']) {
			$where .= " AND `phone` like '%" . $datasearch['phone'] . "%'";
		}
		if ($datasearch['activedate']) {
			$where .= " AND `activedate` like '%" . $datasearch['activedate'] . "%'";
		}
		if ($datasearch['updateddate']) {
			$where .= " AND `updateddate` like '%" . $datasearch['updateddate'] . "%'";
		}
		if ($datasearch['deleteddate']) {
			$where .= " AND `deleteddate` like '%" . $datasearch['deleteddate'] . "%'";
		}
		if ($datasearch['activeby']) {
			$where .= " AND `activeby` like '%" . $datasearch['activeby'] . "%'";
		}
		if ($datasearch['updatedby']) {
			$where .= " AND `updatedby` like '%" . $datasearch['updatedby'] . "%'";
		}
		if ($datasearch['deletedby']) {
			$where .= " AND `deletedby` like '%" . $datasearch['deletedby'] . "%'";
		}
		if ($datasearch['userip']) {
			$where .= " AND `userip` like '%" . $datasearch['userip'] . "%'";
		}
		if ($datasearch['permission']) {
			$where .= " AND `permission` like '%" . $datasearch['permission'] . "%'";
		}
		


        $page = preg_replace('#[^0-9]#i', '', $this->request->get['page']);
        if ($page == '')
            $page = 1;
        $this->data['page'] = $page;


        $from = ($page - 1) * $this->itemsPerPage;
        $to = $this->itemsPerPage;
        $orderby = "";
        if($datasearch['sortcol']!="")
        {
            $orderby = " ORDER BY `".$datasearch['sortcol']."` ".$datasearch['sorttype'];
        }
        $this->data['users'] = $this->model_core_user->getList($where.$orderby, $from, $to);

        $total = $this->model_core_user->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'user-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "core/user_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_core_user->getItem($id);
        }

        $this->template = "core/user_form.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();
    }


    public function insert()
    {
        $this->getForm();
    }

    public function update()
    {
        $this->getForm();
    }

    public function delete()
    {
        $id = $this->request->get['id'];

        $this->model_core_user->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['userid'] = $data['username'];
            $data['id'] = $this->model_core_user->save($data);
            $data['errors'] = array();
            $data['errorstext'] = '';

        } else {
            $data['errors'] = $this->errors;
            $data['errorstext'] = '';
            foreach ($this->errors as $error) {
                $data['errorstext'] .= $error . "<br>";
            }
        }
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }

    private function validate($data)
    {
        $this->errors = array();


		if ("" == $data['usertypeid']) {
			$this->errors['usertypeid'] = "User Type Name not empty";
		}
		if ("" == $data['username']) {
			$this->errors['username'] = "User Name not empty";
		}
		if ("" == $data['password']) {
			$this->errors['password'] = "Password not empty";
		}
		if ("" == $data['fullname']) {
			$this->errors['fullname'] = "Full Name not empty";
		}
		if ("" == $data['email']) {
			$this->errors['email'] = "Email not empty";
		}

		

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
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
            $user = $this->model_core_user->getItemByUserName($this->user->getUserName());
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
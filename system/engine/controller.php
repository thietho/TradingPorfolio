<?php

/**
 * Class Controller
 *
 * @property Loader load
 * @property Smartweb smartweb
 * @property Language language
 * @property Config config
 * @property Request request
 * @property Response response
 * @property Document document
 * @property Url url
 * @property CacheHTML cachehtml
 * @property Session session
 * @property String string
 * @property Date date
 * @property Validation validation
 *
 * @property ModelCoreBaseMedia model_core_basemedia
 * @property ModelCoreSitemap model_core_sitemap
 * @property ModelCoreReceivedemail model_core_receivedemail
 * @property ModelCoreMessage model_core_message
 * @property ModelCoreProduct model_core_product
 * @property ModelCoreTag model_core_tag
 * @property ModelCoreCustomer model_core_customer
 * @property ModelModuleInformation model_module_information
 *
 * @property Common common
 * @property User user
 * @property Member member
 *
 */
abstract class Controller {
    public $data = array();
    public $template;
    public $layout;
    public $output = "";


	public function __construct() {
        $this->language->load("lang");
	}

	public function __get($key) {
		return Registry::get($key);
	}

	public function __set($key, $value) {
		Registry::set($key, $value);
	}

    public function addOG($type, $data) {
        //include_once("smartcore/model/common/opengraphfactory.php");
        //include_once("smartcore/model/common/aopengragh.php");
        //include_once("smartcore/model/common/sitemapog.php");
        //include_once("smartcore/model/common/mediaog.php");
        //include_once("smartcore/model/common/productog.php");
        //include_once("smartcore/model/common/smartproductog.php");
        //$openGraph = OpenGraphFactory::getInstance($type, $data);
        //$openGraph->addOpenGragh();
    }

    protected function render()
    {
        $this->output = $this->load->view($this->template, $this->data);

        //apply for cms
        if($this->layout) {
            $module = $this->layout;
            $file = DIR_CONTROLLER . $module . '.php';
            $class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $module);

            /*
            $isRewrite = false;
            $modFile = DIR_APPCONTROLLER . $module . '.php';
            if (file_exists($modFile)) {
                $userFile = DIR_APPCONTROLLER . $module . '.php';
                $userClass = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $module);
                $isRewrite = true;
            } else {
                $userFile = DIR_USERCONTROLLER . $module . '.php';
                $userClass = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $module) . SKINID;
            }



            $controller = null;
            if (file_exists($userFile)) {
                if (!$isRewrite && file_exists($file)) {
                    require_once($file);
                }
                require_once($userFile);
                if(class_exists($userClass)) {
                    $controller = new $userClass();
                } else if (class_exists($class)) {
                    $controller = new $class();
                }
            } else {
                if (file_exists($file)) {
                    require_once($file);
                    $controller = new $class();
                } else {
                    $this->log->write("ERROR: Not found module: [" . $module . "]");
                    $file = DIR_CONTROLLER . 'error/not_found_module.php';
                    $class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', "error/not_found_module");
                    require_once($file);
                    $controller = new $class();
                }
            }
            */

            $controller = null;
            if (file_exists($file)) {
                require_once($file);
                $controller = new $class();
            } else {
                $this->log->write("ERROR: Not found module: [" . $module . "]");
                $file = DIR_CONTROLLER . 'error/not_found_module.php';
                $class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', "error/not_found_module");
                require_once($file);
                $controller = new $class();
            }


            $controller->data = $this->data;
            if (is_callable(array($controller, 'index'))) {
                $controller->data['pagecontent'] = $this->output;
                call_user_func(array($controller, 'index'));
            }
            $this->output = $controller->output;
        }

        $this->response->setOutput($this->output);
    }


    protected function forward($route, $args = array())
    {
        return new Action($route, $args);
    }

    protected function redirect($url)
    {
        header('Location: ' . html_entity_decode($url));
        exit();
    }

    public function clearCache()
    {
        //clear cms cache
        $arr_sitemap_smart = glob(DIR_CACHE . 'cache.*');
        if(is_array($arr_sitemap_smart)) {
            foreach ($arr_sitemap_smart as $file) {
                unlink($file);
            }
        }

        $arr_cachehtml = glob(DIR_CACHE . 'cachehtml.*');
        if(is_array($arr_cachehtml)) {
            foreach ($arr_cachehtml as $file) {
                unlink($file);
            }
        }

        //clear web cache
        /*
        if(defined('DIR_WEB_CACHE')) {
            $arr_sitemap_smart = glob(DIR_WEB_CACHE . 'cache.*');
            if(is_array($arr_sitemap_smart)) {
                foreach ($arr_sitemap_smart as $file) {
                    unlink($file);
                }
            }

            $arr_cachehtml = glob(DIR_WEB_CACHE . 'cachehtml.*');
            if(is_array($arr_cachehtml)) {
                foreach ($arr_cachehtml as $file) {
                    unlink($file);
                }
            }
        }
        */
    }

    public function checkPermisson() {
        if($this->user->getUserTypeId() != 'admin') {
            $this->redirect(HTTP_WEB);
        }
    }
}
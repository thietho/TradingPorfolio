<?php

/**
 * Class Loader
 *
 * @property Config config
 * @property Language language
 * @property Log log
 *
 */
final class Loader
{
    public function __get($key) {
        return Registry::get($key);
    }

    public function __set($key, $value) {
        Registry::set($key, $value);
    }

    public function controller($module, $method = "index", $args = array()) {

        $file = DIR_CONTROLLER . $module . '.php';
        $class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $module);


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

        /*
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
                $file = DIR_CONTROLLER . 'error/not_found.php';
                $class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', "error/not_found");
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
            $file = DIR_CONTROLLER . 'error/not_found.php';
            $class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', "error/not_found");
            require_once($file);
            $controller = new $class();
        }


        // Stop any magical methods being called
        if (substr($method, 0, 2) == '__') {
            return false;
        }




        $output = '';
        if (is_callable(array($controller, $method))) {
            call_user_func_array(array($controller, $method), $args);
            $output = $controller->output;
        }

        return $output;
    }


    public function controllerInstance($module, $method = "index", $args = array()) {

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
                $file = DIR_CONTROLLER . 'error/not_found.php';
                $class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', "error/not_found");
                require_once($file);
                $controller = new $class();
            }
        }
        */
        if (file_exists($file)) {
            require_once($file);
            $controller = new $class();
        } else {
            $this->log->write("ERROR: Not found module: [" . $module . "]");
            $file = DIR_CONTROLLER . 'error/not_found.php';
            $class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', "error/not_found");
            require_once($file);
            $controller = new $class();
        }

        // Stop any magical methods being called
        if (substr($method, 0, 2) == '__') {
            return false;
        }


        if (is_callable(array($controller, $method))) {
            call_user_func_array(array($controller, $method), $args);
        }

        return $controller;
    }


    public function model($model)
    {
        $key = 'model_' . str_replace('/', '_', $model);
        if(Registry::has($key)) {
            return;
        }


        /*
        $isRewrite = false;
        $modFile = DIR_APPMODEL . $model . '.php';
        if (file_exists($modFile)) {
            $userFile = DIR_APPMODEL . $model . '.php';
            $userClass = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);
            $isRewrite = true;
        } else {
            $userFile = DIR_USERMODEL . $model . '.php';
            $userClass = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model) . SKINID;
        }

        $file = DIR_MODEL . $model . '.php';
        $class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);

        if (file_exists($userFile)) {
            if (!$isRewrite && file_exists($file)) {
                include_once($file);
            }
            include_once($userFile);
            if (class_exists($userClass)) {
                Registry::set('model_' . str_replace('/', '_', $model), new $userClass());
            } else if (class_exists($class)) {
                Registry::set('model_' . str_replace('/', '_', $model), new $class());
            } else {
                exit('Error: Could not load model ' . $model . '!');
            }
        } else {
            if (file_exists($file)) {
                include_once($file);
                Registry::set('model_' . str_replace('/', '_', $model), new $class());
            } else {
                exit('Error: Could not load model ' . $model . '!');
            }
        }
        */

        $file = DIR_MODEL . $model . '.php';
        $class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);
        if (file_exists($file)) {
            include_once($file);
            Registry::set('model_' . str_replace('/', '_', $model), new $class());
        } else {
            exit('Error: Could not load model ' . $model . '!');
        }
    }
    
	public function language($language) {
		return Registry::get('language')->load($language);
	}

    public function helper($helper)
    {
        $file = DIR_SYSTEM . 'helper/' . $helper . '.php';

        if (file_exists($file)) {
            include_once($file);
        } else {
            exit('Error: Could not load helper ' . $helper . '!');
        }
    }
    
	public function view($template, $data = array()) {
		// $this->event->trigger('pre.view.' . str_replace('/', '.', $template), $data);

        $output = "";
		/*
        if (file_exists(DIR_USERTEMPLATE . $template)) {
			$file = DIR_USERTEMPLATE . $template;
		} else {
			$file = DIR_TEMPLATE . $template;
		}
		*/
        $file = DIR_TEMPLATE . $template;


		if (file_exists($file)) {
            $data = array_merge($data, $this->language->all()); //add language
			extract($data);

			ob_start();

			require($file);

			$output = ob_get_contents();

			ob_end_clean();
		} else {
            //$this->log->write("ERROR: Not found template: [" . $template . "]");
			trigger_error('Error: Could not load template ' . $template . '!', E_USER_ERROR);
		}

		// $this->event->trigger('post.view.' . str_replace('/', '.', $template), $output);

		return $output;
	}
}
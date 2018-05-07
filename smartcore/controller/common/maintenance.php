<?php

/**
 * Class ControllerCommonMaintenance
 *
 *
 *
 */
class ControllerCommonMaintenance extends Controller {
	
	public function index() {
		if ($this->config->get('config_maintenance')) {
			$route = '';

			if (isset($this->request->get['route'])) {
				$part = explode('/', $this->request->get['route']);

				if (isset($part[0])) {
					$route .= $part[0];
				}
			}

			// Show site if logged in as admin
			//$this->user = new User($this->registry);

			//if (($route != 'payment' && $route != 'api') && !$this->user->isLogged()) {
			//	return new Action('common/maintenance/info');
			//}
			
			return new Action('common/maintenance/info');
		}
	}

	public function info() {
		
		$this->load->language('common/maintenance');
		$this->document->setTitle($this->language->get('lang_heading_title'));

		if ($this->request->server['SERVER_PROTOCOL'] == 'HTTP/1.1') {
			$this->response->addHeader('HTTP/1.1 503 Service Unavailable');
		} else {
			$this->response->addHeader('HTTP/1.0 503 Service Unavailable');
		}

		$this->response->addHeader('Retry-After: 3600');
		
		//$data['breadcrumbs'] = array();
		//$data['breadcrumbs'][] = array(
		//	'text' => $this->language->get('lang_text_maintenance'),
		//	'href' => $this->url->http('common/maintenance')
		//);
		
		$this->data['header'] = $this->load->controller('common/header');
		$this->data['footer'] = $this->load->controller('common/footer');
        $this->data['mainmenu'] = $this->load->controller('common/mainmenu');

        $this->template = "common/maintenance.tpl";
        $this->render();
	}
}

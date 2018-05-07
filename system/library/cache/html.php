<?php
namespace Cache;
class Html {
	private $expire;

	public function __construct($expire = 3600) {
		$this->expire = $expire;

        if (!is_dir(DIR_CACHE)) {
            if (!mkdir(DIR_CACHE, 0777, true)) {
                die('Failed to create folders: ' . DIR_CACHE);
            }
        }

		$files = glob(DIR_CACHE . 'cachehtml.*');
		if ($files) {
			foreach ($files as $file) {
				$time = substr(strrchr($file, '.'), 1);
				if ($time < time()) {
					if (file_exists($file)) {
						echo $file;
						unlink($file);
					}
				}
			}
		}
	}
	public function clear(){
		$files = glob(DIR_CACHE . 'cachehtml.*');
		if ($files) {
			foreach ($files as $file) {
				if (file_exists($file)) {
					unlink($file);
				}

			}
		}
	}
	public function get($key) {
		$files = glob(DIR_CACHE . 'cachehtml.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.*');

		if ($files && filesize($files[0])) {
			$handle = fopen($files[0], 'r');

            flock($handle, LOCK_SH);

            $data = fread($handle, filesize($files[0]));

            flock($handle, LOCK_UN);

            fclose($handle);

            return $data;

		}

		return false;
	}

	public function set($key, $value) {
		$this->delete($key);

		$file = DIR_CACHE . 'cachehtml.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.' . (time() + $this->expire);

		$handle = fopen($file, 'w');

		flock($handle, LOCK_EX);

		fwrite($handle, $value);

		fflush($handle);

		flock($handle, LOCK_UN);

		fclose($handle);
	}

	public function delete($key) {
		$files = glob(DIR_CACHE . 'cachehtml.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.*');

		if ($files) {
			foreach ($files as $file) {
				if (file_exists($file)) {
					unlink($file);
				}
			}
		}
	}

    public function deleteContainKey($key) {
        $files = glob(DIR_CACHE . 'cachehtml.*' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.*');

        if ($files) {
            foreach ($files as $file) {
                if (file_exists($file)) {
                    unlink($file);
                }
            }
        }
    }
}
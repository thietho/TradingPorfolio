<?php
class Pagination {
	public $total = 0;
	public $page = 1;
	public $limit = 20;
	public $num_links = 3;
	public $url = '';
    public $filter = '';
    public $eid = '';

    //default is fontawsome
	public $text_first = '<i class="fa fa-angle-double-left"></i>';
	public $text_last = '<i class="fa fa-angle-double-right"></i>';
	public $text_next = '<i class="fa fa-angle-right"></i>';
	public $text_prev = '<i class="fa fa-angle-left"></i>';

	public function render() {
		$total = $this->total;

		if ($this->page < 1) {
			$page = 1;
		} else {
			$page = $this->page;
		}

		if (!(int)$this->limit) {
			$limit = 10;
		} else {
			$limit = $this->limit;
		}

		$num_links = $this->num_links;
		$num_pages = ceil($total / $limit);


		$this->url = str_replace('%7Bpage%7D', '{page}', $this->url);

		$output = '<ul class="pagination pagination-lg pagination-sm">';

		if ($page > 1) {
			$output .= '<li><a href="' . str_replace('{page}', 1, $this->url) . '">' . $this->text_first . '</a></li>';
			$output .= '<li><a href="' . str_replace('{page}', $page - 1, $this->url) . '">' . $this->text_prev . '</a></li>';
		}

		if ($num_pages > 1) {
			if ($num_pages <= $num_links) {
				$start = 1;
				$end = $num_pages;
			} else {
				$start = $page - floor($num_links / 2);
				$end = $page + floor($num_links / 2);

				if ($start < 1) {
					$end += abs($start) + 1;
					$start = 1;
				}

				if ($end > $num_pages) {
					$start -= ($end - $num_pages);
					$end = $num_pages;
				}
			}

			for ($i = $start; $i <= $end; $i++) {
				if ($page == $i) {
					$output .= '<li class="active"><span>' . $i . '</span></li>';
				} else {
					$output .= '<li><a href="' . str_replace('{page}', $i, $this->url) . '">' . $i . '</a></li>';
				}
			}
		}

		if ($page < $num_pages) {
			$output .= '<li><a href="' . str_replace('{page}', $page + 1, $this->url) . '">' . $this->text_next . '</a></li>';
			$output .= '<li><a href="' . str_replace('{page}', $num_pages, $this->url) . '">' . $this->text_last . '</a></li>';
		}

		$output .= '</ul>';

		if ($num_pages > 1) {
			return $output;
		} else {
			return '';
		}
	}

    public function ajaxRender() {
        $total = $this->total;

        if ($this->page < 1) {
            $page = 1;
        } else {
            $page = $this->page;
        }

        if (!(int)$this->limit) {
            $limit = 10;
        } else {
            $limit = $this->limit;
        }

        $num_links = $this->num_links;
        $num_pages = ceil($total / $limit);


        $output = '<ul class="pagination">';

        if ($page > 1) {
            $output .= '<li><a onclick="goPage(1,\''. $this->filter .'\')" >' . $this->text_first . '</a></li>';
            $output .= '<li><a onclick="goPage('. ($page - 1) .',\''. $this->filter .'\')" >' . $this->text_prev . '</a></li>';
        }

        if ($num_pages > 1) {
            if ($num_pages <= $num_links) {
                $start = 1;
                $end = $num_pages;
            } else {
                $start = $page - floor($num_links / 2);
                $end = $page + floor($num_links / 2);

                if ($start < 1) {
                    $end += abs($start) + 1;
                    $start = 1;
                }

                if ($end > $num_pages) {
                    $start -= ($end - $num_pages);
                    $end = $num_pages;
                }
            }

            for ($i = $start; $i <= $end; $i++) {
                if ($page == $i) {
                    $output .= '<li class="active"><span>' . $i . '</span></li>';
                } else {
                    $output .= '<li><a onclick="goPage('. $i .',\''. $this->filter .'\')">' . $i . '</a></li>';
                }
            }
        }

        if ($page < $num_pages) {
            $output .= '<li><a onclick="goPage('. ($page + 1) .',\''. $this->filter .'\')">' . $this->text_next . '</a></li>';
            $output .= '<li><a onclick="goPage('. $num_pages .',\''. $this->filter .'\')">' . $this->text_last . '</a></li>';
        }

        $output .= '</ul>';

        if ($num_pages > 1) {
            return $output;
        } else {
            return '';
        }
    }
    public function ajaxRenderNewUrl($url) {
        $total = $this->total;

        if ($this->page < 1) {
            $page = 1;
        } else {
            $page = $this->page;
        }

        if (!(int)$this->limit) {
            $limit = 10;
        } else {
            $limit = $this->limit;
        }

        $num_links = $this->num_links;
        $num_pages = ceil($total / $limit);


        $output = '<ul class="pagination">';

        if ($page > 1) {
            $output .= '<li><a onclick="goPage(\''.$url.'&page=1'.'\',\''. $this->eid.'\')" >' . $this->text_first . '</a></li>';
            $output .= '<li><a onclick="goPage(\''.$url.'&page='. ($page - 1).'\',\''. $this->eid.'\')" " >' . $this->text_prev . '</a></li>';

        }

        if ($num_pages > 1) {
            if ($num_pages <= $num_links) {
                $start = 1;
                $end = $num_pages;
            } else {
                $start = $page - floor($num_links / 2);
                $end = $page + floor($num_links / 2);

                if ($start < 1) {
                    $end += abs($start) + 1;
                    $start = 1;
                }

                if ($end > $num_pages) {
                    $start -= ($end - $num_pages);
                    $end = $num_pages;
                }
            }

            for ($i = $start; $i <= $end; $i++) {
                if ($page == $i) {
                    $output .= '<li class="active"><span>' . $i . '</span></li>';
                } else {

                    $output .= '<li><a onclick="goPage(\''.$url.'&page='. $i .'\',\''. $this->eid.'\')">' . $i . '</a></li>';
                }
            }
        }

        if ($page < $num_pages) {

            $output .= '<li><a onclick="goPage(\''.$$url.'&page='. ($page + 1).'\',\''. $this->eid.'\')">' . $this->text_next . '</a></li>';

            $output .= '<li><a onclick="goPage(\''.$url.'&page='. $num_pages.'\',\''. $this->eid.'\')">' . $this->text_last . '</a></li>';
        }

        $output .= '</ul>';

        if ($num_pages > 1) {
            return $output;
        } else {
            return '';
        }
    }
    public function ajaxRenderNew() {
        $total = $this->total;

        if ($this->page < 1) {
            $page = 1;
        } else {
            $page = $this->page;
        }

        if (!(int)$this->limit) {
            $limit = 10;
        } else {
            $limit = $this->limit;
        }

        $num_links = $this->num_links;
        $num_pages = ceil($total / $limit);


        $output = '<ul class="pagination">';

        if ($page > 1) {
            $output .= '<li><a onclick="goPage(\''.$this->getURLQueryString('page', '1').'\',\''. $this->eid.'\')" >' . $this->text_first . '</a></li>';
            $output .= '<li><a onclick="goPage(\''.$this->getURLQueryString('page', $page - 1).'\',\''. $this->eid.'\')" " >' . $this->text_prev . '</a></li>';

        }

        if ($num_pages > 1) {
            if ($num_pages <= $num_links) {
                $start = 1;
                $end = $num_pages;
            } else {
                $start = $page - floor($num_links / 2);
                $end = $page + floor($num_links / 2);

                if ($start < 1) {
                    $end += abs($start) + 1;
                    $start = 1;
                }

                if ($end > $num_pages) {
                    $start -= ($end - $num_pages);
                    $end = $num_pages;
                }
            }

            for ($i = $start; $i <= $end; $i++) {
                if ($page == $i) {
                    $output .= '<li class="active"><span>' . $i . '</span></li>';
                } else {

                    $output .= '<li><a onclick="goPage(\''.$this->getURLQueryString('page', $i).'\',\''. $this->eid.'\')">' . $i . '</a></li>';
                }
            }
        }

        if ($page < $num_pages) {

            $output .= '<li><a onclick="goPage(\''.$this->getURLQueryString('page', $page + 1).'\',\''. $this->eid.'\')">' . $this->text_next . '</a></li>';

            $output .= '<li><a onclick="goPage(\''.$this->getURLQueryString('page', $num_pages).'\',\''. $this->eid.'\')">' . $this->text_last . '</a></li>';
        }

        $output .= '</ul>';

        if ($num_pages > 1) {
            return $output;
        } else {
            return '';
        }
    }
    function getURLQueryString($strkey, $setvalue)
    {
        $data = explode('&',$this->url);
        $data_para = array();
        foreach($data as $value)
        {
            if($value!="")
            {
                $arr = explode('=',$value);
                $data_para[$arr[0]] = $arr[1];
            }
        }

        $data_para[$strkey] = urlencode($setvalue);
        return $this->toUrlPara($data_para);
    }
    public function toUrlPara($data)
    {
        $str = '';
        foreach($data as $key => $val)
        {
            $str.="&$key=$val";
        }
        return "?".$str;
    }
}
<?php

class HelperEimagick
{
    static private function getExtension($filepath)
    {
        $info = pathinfo($filepath);
        return "." . strtolower($info['extension']);
    }

    static public function getDefaultCache($filepath, $width = 2560, $height = 1200)
    {
        if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
            $filepath = "default/default.png";
        }

        if ($filepath == "") {
            $filepath = "default/default.png";
        }

        $extension = HelperEimagick::getExtension($filepath);
        $old_image = $filepath;

        //$new_image = preg_replace('/[\/]/', '_', basename($filepath));
        $new_image = preg_replace('/[\/]/', '_', $filepath);
        $new_image = preg_replace('/\.([a-zA-Z]{3,4})/',  $extension, $new_image);
        $new_image = 'cache/' . $new_image;

        if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
            $eimagick = new EImagick(DIR_FILE . $old_image);

            if($eimagick->resize($width, 0, "transparent")) {
                $eimagick->save(DIR_FILE . $new_image);
            } else {
                $rootImage = new Imagick();
                $rootImage->readimage(DIR_FILE . $old_image);
                $rootImage->writeimage(DIR_FILE . $new_image);
            }
            unset($eimagick);

        }

        return $new_image;
    }

    static public function resize($filepath, $targetWidth, $targetHeight, $bgColor = "#FFFFFF")
    {

        if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
            $filepath = HelperEimagick::getDefaultCache($filepath);
        }

        if ($filepath == "") {
            $filepath = HelperEimagick::getDefaultCache($filepath);
        }

        $extension = HelperEimagick::getExtension($filepath);

        $old_image = $filepath;

        //$new_image = preg_replace('/[\/]/', '_', basename($filepath));
        $new_image = preg_replace('/[\/]/', '_', $filepath);
        $new_image = preg_replace('/\.([a-zA-Z]{3,4})/', '_' . $targetWidth . 'x' . $targetHeight . $extension, $new_image);
        $new_image = 'cache/' . $new_image;

        if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
            $old_image = HelperEimagick::getDefaultCache($filepath);
            $eimagick = new EImagick(DIR_FILE . $old_image);
            if($eimagick->resize($targetWidth, $targetHeight, $bgColor)) {
                $eimagick->save(DIR_FILE . $new_image);
            }
            unset($eimagick);
        } else {

        }

        if (@$_SERVER['HTTPS'] != 'on') {
            return $new_image;
        } else {
            return $new_image;
        }
    }

    static public function resizePNG($filepath, $targetWidth, $targetHeight)
    {
        if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
            $filepath = HelperEimagick::getDefaultCache($filepath);
        }

        if ($filepath == "") {
            $filepath = HelperEimagick::getDefaultCache($filepath);
        }

        $old_image = $filepath;


        //$new_image = preg_replace('/[\/]/', '_', basename($filepath));
        $new_image = preg_replace('/[\/]/', '_', $filepath);
        $new_image = preg_replace('/\.([a-zA-Z]{3,4})/', '_png_' . $targetWidth . 'x' . $targetHeight . ".png", $new_image);
        $new_image = 'cache/' . $new_image;


        if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
            $old_image = HelperEimagick::getDefaultCache($filepath);
            $eimagick = new EImagick(DIR_FILE . $old_image);
            if($eimagick->resize($targetWidth, $targetHeight, "transparent")) {
                $eimagick->save(DIR_FILE . $new_image);
            }
            unset($eimagick);
        }


        if (@$_SERVER['HTTPS'] != 'on') {
            return $new_image;
        } else {
            return $new_image;
        }
    }

    static public function fixsize($filepath, $width, $height)
    {
        if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
            $filepath = HelperEimagick::getDefaultCache($filepath);
        }

        if ($filepath == "") {
            $filepath = HelperEimagick::getDefaultCache($filepath);
        }

        $extension = HelperEimagick::getExtension($filepath);

        $old_image = $filepath;

        //$new_image = preg_replace('/[\/]/', '_', basename($filepath));
        $new_image = preg_replace('/[\/]/', '_', $filepath);
        $new_image = preg_replace('/\.([a-zA-Z]{3,4})/', '_fix_' . $width . 'x' . $height . $extension, $new_image);
        $new_image = 'cache/' . $new_image;

        if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
            $old_image = HelperEimagick::getDefaultCache($filepath);
            $eimagick = new EImagick(DIR_FILE . $old_image);
            if($eimagick->fixsize($width, $height)) {
                $eimagick->save(DIR_FILE . $new_image);
            }
            unset($eimagick);
        }

        if (@$_SERVER['HTTPS'] != 'on') {
            return $new_image;
        } else {
            return $new_image;
        }
    }

    static public function fixsizetop($filepath, $width, $height)
    {
        if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
            $filepath = HelperEimagick::getDefaultCache($filepath);
        }

        if ($filepath == "") {
            $filepath = HelperEimagick::getDefaultCache($filepath);
        }

        $extension = HelperEimagick::getExtension($filepath);

        $old_image = $filepath;

        //$new_image = preg_replace('/[\/]/', '_', basename($filepath));
        $new_image = preg_replace('/[\/]/', '_', $filepath);
        $new_image = preg_replace('/\.([a-zA-Z]{3,4})/', '_fixtop_' . $width . 'x' . $height . $extension, $new_image);
        $new_image = 'cache/' . $new_image;

        if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
            $old_image = HelperEimagick::getDefaultCache($filepath);
            $eimagick = new EImagick(DIR_FILE . $old_image);
            if($eimagick->fixsize($width, $height, 'top')) {
                $eimagick->save(DIR_FILE . $new_image);
            }
            unset($eimagick);
        }

        if (@$_SERVER['HTTPS'] != 'on') {
            return $new_image;
        } else {
            return $new_image;
        }
    }

    static public function getroot($filepath)
    {
        return $filepath;
    }
}



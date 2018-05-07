<?php

/**
 * Class EImagick
 *
 * @property Imagick image
 *
 */
final class EImagick
{
    private $file;
    private $image;
    private $info;

    //private $watermark;

    public function __construct($file)
    {
        if (file_exists($file)) {
            $this->file = $file;

            $info = getimagesize($file);
            $extension = $this->getExtension();
            $this->info = array(
                'width' => $info[0],
                'height' => $info[1],
                'bits' => $info['bits'],
                'mime' => $info['mime'],
                'type' => $info[2],
                'extension' => $extension
            );
        } else {
            throw new Exception('Error: Could not load image ' . $file . '!');
        }
    }

    public function __destruct()
    {
        if ($this->image != null) {
            $this->image->clear();
            $this->image->destroy();
        }

        if ($this->info != null && count($this->info) > 0) {
            unset($this->info);
        }
    }

    /**
     * Get extension of file
     * @return string
     */
    private function getExtension()
    {
        if ($this->file == null || $this->file == "") {
            return "";
        }
        $info = pathinfo($this->file);
        return strtolower($info['extension']);
    }

    public function save($fileOutputPath, $mashlogo = true, $quality = 100)
    {
        if ((float)$this->info['width'] > 120 && $mashlogo == true) {
            $this->drawMashLogo();
        }

        if (COMPRESSION) {

            if ($this->info['extension'] == "jpg" || $this->info['extension'] == "jpeg") {
                $this->image->setInterlaceScheme(Imagick::INTERLACE_PLANE);
                $this->image->setimagecompression(Imagick::COMPRESSION_LOSSLESSJPEG);
                $this->image->setimagecompressionquality($quality);
            }

            if ($this->info['extension'] == "png") {
                $this->image->setImageCompression(Imagick::COMPRESSION_UNDEFINED);
                $this->image->setImageCompressionQuality(0);
            }
        }

        $this->image->writeImage($fileOutputPath);


        //clear data
        $this->image->clear();
        $this->image->destroy();

        return true;
    }

    /**
     * @param int $targetWidth
     * @param int $targetHeight
     * @param string $color
     * @return false
     */
    public function resize($targetWidth = 0, $targetHeight = 0, $color = '#ffffff')
    {
        if ($this->info['width'] <= 0 || $this->info['height'] <= 0) {
            return false;
        }

        $scale = 1;
        if ($targetWidth > 0 && $targetHeight > 0) {
            $scale = min($targetWidth / $this->info['width'], $targetHeight / $this->info['height']);
        } else {
            if ($targetWidth > 0)
                $scale = $targetWidth / $this->info['width'];
            if ($targetHeight > 0)
                $scale = $targetHeight / $this->info['height'];
        }
        if ($scale >= 1) {
            $this->image = new Imagick();

            $rootImage = new Imagick();
            $rootImage->readimage($this->file);

            $this->image->newimage($this->info['width'], $this->info['height'], new ImagickPixel($color));
            $this->image->compositeimage($rootImage, Imagick::COMPOSITE_OVER, 0, 0);
            if ($color == 'transparent') {
                $this->image->setimageformat('png');
            } else {
                $this->image->setimageformat($this->info['extension']);
            }
            return true;
        }

        //scale image
        /*
        $new_width = (int)($this->info['width'] * $scale);
        $new_height = (int)($this->info['height'] * $scale);
        if ($new_width < $targetWidth) {
            $new_width = $targetWidth;
        }
        if ($new_height < $targetHeight) {
            $new_height = $targetHeight;
        }
        */

        //resize root image to new_width, new_height
        $rootImage = new Imagick();
        $rootImage->readimage($this->file);
        if($targetWidth == 0 || $targetHeight == 0) {
            $rootImage->resizeimage($targetWidth, $targetHeight, Imagick::FILTER_LANCZOS, 1, false);
        } else {
            $rootImage->resizeimage($targetWidth, $targetHeight, Imagick::FILTER_LANCZOS, 1, true);
        }

        //canculate positon in new image
        if($targetWidth == 0 || $targetHeight == 0) {
           $xpos = 0;
           $ypos = 0;
        } else {
            $new_width = $rootImage->getimagewidth();
            $new_height = $rootImage->getimageheight();
            $xpos = (int)((abs($targetWidth - $new_width)) / 2);
            $ypos = (int)((abs($targetHeight - $new_height)) / 2);
        }


        if ($targetWidth > 0 && $targetHeight > 0) {
            $this->image = new Imagick();
            if ($color == 'transparent') {
                $this->image->newimage($targetWidth, $targetHeight, "none");
            } else {
                $this->image->newimage($targetWidth, $targetHeight, new ImagickPixel($color));
            }
            $this->image->compositeimage($rootImage, Imagick::COMPOSITE_OVER, $xpos, $ypos);
            if ($color == 'transparent') {
                $this->image->setimageformat('png');
            } else {
                $this->image->setimageformat($this->info['extension']);
            }
            $rootImage->clear();
            $rootImage->destroy();

        } else {
            $this->image = $rootImage;
        }

        return true;
    }

    function fixsize($targetWidth = 0, $targetHeight = 0, $position = 'center')
    {
        if ($targetHeight <= 0 || $targetWidth <= 0) {
            return false;
        }

        if (!$this->info['width'] || !$this->info['height']) {
            return false;
        }

        $scale = max($targetWidth / $this->info['width'], $targetHeight / $this->info['height']);
        if ($scale >= 1) {
            //$this->image = new Imagick();
            //$this->image->readimage($this->file);
            //return true;
        }

        $final_width = (int)($this->info['width'] * $scale);
        $final_height = (int)($this->info['height'] * $scale);
        if ($final_width < $targetWidth) {
            $final_width = $targetWidth;
        }

        if ($position == 'top') {
            $xpos = 0;
            $ypos = 0;
        } else {
            $xpos = (int)((abs($final_width - $targetHeight)) / 2);
            $ypos = (int)((abs($final_height - $targetHeight)) / 2);
        }

        $this->image = new Imagick();
        $this->image->readimage($this->file);
        if ($position == 'top') {
            $this->image->scaleImage($final_width, 0, false);
            $this->image->cropimage($targetWidth, $targetHeight, $xpos, $ypos);
        } else {
            $this->image->cropThumbnailImage($targetWidth, $targetHeight);
        }
        $this->image->setimageformat($this->info['extension']);

        $this->info['width'] = $final_width;
        $this->info['height'] = $final_height;

        return true;
    }


    public function drawMashLogo()
    {
        //Duong dan hinh anh watermark
        $path_watermark = DIR_FILE . "upload/watermark.png";

        if (file_exists($path_watermark)) {
            $watermark = new Imagick();
            $watermark->readimage($path_watermark);
            $watermark->setimageformat("png");

            //new code
            //BottomRight
            if ($this->image->getimagewidth() > $watermark->getimagewidth() && $this->image->getimageheight() > $watermark->getimageheight()) {
                if (WATERLOGO_POSITION == 'TopRight') {
                    $startwidth = $this->image->getimagewidth() - $watermark->getimagewidth();
                    $startheight = 0;
                } else if (WATERLOGO_POSITION == 'TopLeft') {
                    $startwidth = 0;
                    $startheight = 0;
                } else if (WATERLOGO_POSITION == 'BottomRight') {
                    $startwidth = $this->image->getimagewidth() - $watermark->getimagewidth();
                    $startheight = $this->image->getimageheight() - $watermark->getimageheight();
                } else if (WATERLOGO_POSITION == 'BottomLeft') {
                    $startwidth = 0;
                    $startheight = $this->image->getimageheight() - $watermark->getimageheight();
                } else {
                    $startwidth = 0;
                    $startheight = 0;
                }
                //$this->image->setImageVirtualPixelMethod(Imagick::VIRTUALPIXELMETHOD_TRANSPARENT);
                //$this->image->setImageArtifact('compose:args', "1,0,-0.5,0.5");
                $this->image->compositeImage($watermark, Imagick::COMPOSITE_OVER, $startwidth, $startheight);
            }

            $watermark->clear();
            $watermark->destroy();
        }
    }
}
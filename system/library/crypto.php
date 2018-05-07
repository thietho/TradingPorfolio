<?php
final class Crypto
{
    private static $tripledes_key = "El1fEpArtnErsN0th!n9123D"; //23 bit Key
    private static $tripledes_iv = "SmartWeb";// 8 bit IV
    private static $tripledes_bit_check = 8;// bit amount for diff algor.

    private function __construct() {
    }

    //MCRYPT_TRIPLEDES
    static function encrypt_tripledes($text)
    {
        $text_num = str_split($text, Crypto::$tripledes_bit_check);
        $text_num = Crypto::$tripledes_bit_check - strlen($text_num[count($text_num) - 1]);
        for ($i = 0; $i < $text_num; $i++) {
            $text = $text . chr($text_num);
        }
        $cipher = mcrypt_module_open(MCRYPT_TRIPLEDES, '', 'cbc', '');
        mcrypt_generic_init($cipher, Crypto::$tripledes_key, Crypto::$tripledes_iv);
        $decrypted = mcrypt_generic($cipher, $text);
        mcrypt_generic_deinit($cipher);
        return base64_encode($decrypted);
    }

    static function decrypt_tripledes($encrypted_text)
    {
        $cipher = mcrypt_module_open(MCRYPT_TRIPLEDES, '', 'cbc', '');
        mcrypt_generic_init($cipher, Crypto::$tripledes_key, Crypto::$tripledes_iv);
        $decrypted = mdecrypt_generic($cipher, base64_decode($encrypted_text));
        mcrypt_generic_deinit($cipher);
        $last_char = substr($decrypted, -1);
        for ($i = 0; $i < Crypto::$tripledes_bit_check - 1; $i++) {
            if (chr($i) == $last_char) {
                $decrypted = substr($decrypted, 0, strlen($decrypted) - $i);
                break;
            }
        }
        return $decrypted;
    }

}
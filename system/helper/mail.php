<?php
require_once('class.phpmailer.php');
final class HelperMail {

	//Ham send mac dinh cho linux
	static public function send($to, $subject, $message, $headers, $servertype = "mail") {
		$mail = new Mail();
		
		$mail->IsHTML(true);
		
		if($servertype == "mail")
		{
			$mail->IsMail();
		}
		else
		{
			$mail->IsSMTP();
		}
		
		
		$mail->AddAddress($to, "");
		
		$mail->Subject = $subject;
		
		$mail->Body = $message;
		
		$mail->Headers = $headers;
		
		$mail->Send();
	}

	
	//Ham send ho tro tao header
	static public function sendmail($to, $subject, $message, $from_email, $servertype = "mail", $sender_name = "", $reply_email = ""  ) {
		$mail = new Mail();
		
		$mail->IsHTML(true);
		
		if($servertype == "mail")
		{
			$mail->IsMail();
		}
		else
		{
			$mail->IsSMTP();
		}
		
		if(is_array($to))
		{
			foreach($to as $item)
			{
				$mail->AddAddress($item[0], $item[1]);
			}
		}
		else
		{
			$mail->AddAddress($to, "");
		}
		
		if($from_email != "") 
		{
			$mail->From = $from_email;
		}
		else
		{
			$mail->From = "office@elifepartners.com";
		}
		
		
		
		if($sender_name != "") 
		{
			$mail->FromName = $sender_name;
		}
		else
		{
			$mail->FromName = "Elife Partners";
		}
			
		if($reply_email != "") 
			$mail->Sender = $reply_email;
		
		
		$mail->Subject = $subject;
		
		$mail->Body = $message;
		
		$mail->Headers = '';
		
		return $mail->Send();
	}
	
	static public function sendSMTPMail($from = 'elifepartners.com@gmail.com', $to, $name, $subject, $altBody = "", $body, $bcc = "") {
		$mail = new PHPMailer();
		$mail->CharSet = 'UTF-8';
		$mail->IsHTML(true);
		$mail->IsSMTP(); // telling the class to use SMTP
		$mail->SMTPDebug  = 0;                     // enables SMTP debug information (for testing)
												   // 1 = errors and messages
												   // 2 = messages only

        /*
		$mail->SMTPAuth   = true;                  // enable SMTP authentication
		$mail->SMTPSecure = "ssl";                 // sets the prefix to the servier
		$mail->Host       = "smtp.gmail.com";      // sets GMAIL as the SMTP server
		$mail->Port       = 465;                   // set the SMTP port for the GMAIL server
		$mail->Username   = "elifepartners.com@gmail.com";  // GMAIL username
		$mail->Password   = "12345678'";            // GMAIL password
        */

        $mail->SMTPAuth   = true;                  // enable SMTP authentication
        //$mail->SMTPSecure = "ssl";                 // sets the prefix to the servier
        /*
        $mail->Host       = "mail.taoemail.net";      // sets GMAIL as the SMTP server
        $mail->Port       = 25;                   // set the SMTP port for the GMAIL server
        $mail->Username   = "elifeboss@taoemail.net";  // GMAIL username
        $mail->Password   = "MN24P9Hbr0#8wcR5T";            // GMAIL password
        */
        $mail->Host       = "smtp.elasticemail.com";      			 // sets GMAIL as the SMTP server
        $mail->Port       = 587;                   					 // set the SMTP port for the GMAIL server
        $mail->Username   = "4b8b555d-533e-42d0-8cdb-5103aa9a1522";  // GMAIL username
        $mail->Password   = "4b8b555d-533e-42d0-8cdb-5103aa9a1522";  // GMAIL password


        $arrFrom = explode(";", $from);
        $mail->SetFrom(trim($arrFrom[0]), $name);
		
		$mail->AddReplyTo($from ,$name);
		
		$mail->Subject    = $subject;
		
		$mail->AltBody    = $altBody; // optional, comment out and test
		
		$mail->ContentType = 'text/html';
		
		$mail->MsgHTML($body);
	
		$array_receive = explode(";", $to);
		foreach($array_receive as $item) {
			if (trim($item) != "" ) {
				$mail->AddAddress(trim($item), trim($item));
			}
		}

        $array_bcc = explode(";", $bcc);
        foreach($array_bcc as $item) {
            if (trim($item) != "" ) {
                $mail->AddBCC(trim($item), trim($item));
            }
        }

		if(!$mail->Send()) {
			echo $mail->ErrorInfo;
		  	return false;
		} else {
		  	return true;
		}
	}
	
	static public function sendBasicMail($from = 'elifepartners.com@gmail.com', $to, $name, $subject, $altBody = "", $body) {
        $mail = new PHPMailer(); // defaults to using php "mail()"
		$mail->CharSet = 'UTF-8';
		$mail->IsHTML(true);
        $mail->IsMail();


        $arrFrom = explode(";", $from);
		$mail->SetFrom($arrFrom[0], $name);
		
		$mail->AddReplyTo($from,$name);
		
		//$mail->AddAddress($to, $to);
		$array_receive = explode(";", $to);
		foreach($array_receive as $item) {
			if (trim($item) != "" ) {
				$mail->AddAddress(trim($item), trim($item));
			}
		}
		
		$mail->Subject    = $subject;
		
		$mail->AltBody    = $altBody; // optional, comment out and test
		
		$mail->ContentType = 'text/html';
		
		$mail->MsgHTML($body);
		
		$mail->AddAttachment("images/phpmailer.gif");      // attachment
		$mail->AddAttachment("images/phpmailer_mini.gif"); // attachment
		
		if(!$mail->Send()) {
			return false;
		} else {
		  	return true;
		}	
	}

    /**
     * @param string $from
     * @param $to
     * @param $name
     * @param $subject
     * @param string $altBody
     * @param $body
     */
    static public function sendEmail($from = 'elifepartners.com@gmail.com', $to, $name, $subject, $altBody = "", $body) {
		if(!self::sendBasicMail($from, $to, $name, $subject, $altBody = "", $body))
			self::sendSMTPMail($from, $to, $name, $subject, $altBody = "", $body);
	}
	
}
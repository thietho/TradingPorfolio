<div align="center" style="margin:0; padding:0; font-family:'Arial',Helvetica,sans-serif; color: #333; font-size: 10pt;">
    <table align="center" bgcolor="#eee" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="center" bgcolor="#eee" valign="top" width="100%" style="padding: 20px 0">
                <table align="center" width="700" bgcolor="#fff" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="padding: 15px; font-size: 12px; font-weight: bold;">
                            Dear <?php echo $user['fullname'] ?>,
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px; font-size: 12px;">
                            Your account was reset password. Get your new password below:<br/><br/>
                            Username: <strong><?php echo $user['username'] ?></strong><br/>
                            Password: <strong><?php echo $user['newpass'] ?></strong><br/><br/>
                            Regard,<br/>Admin <?php echo $this->config->get('config_sitename') ?>.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>









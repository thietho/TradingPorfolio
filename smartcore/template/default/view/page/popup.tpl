<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title><?php echo $text_print?></title>

<style>
    table
    {
        width: 100%;
        border-spacing: 0;
        margin-bottom: 10px;

    }

    .data
    {
        border-top: #000 thin solid;
        border-left: #000 thin solid;
    }
    .data td,th
    {
        border-right: #000 thin solid;
        border-bottom: #000 thin solid;
        padding: 5px;
    }

</style>
</head>
<body>
    <?php echo $pagecontent?>
</body>
</html>

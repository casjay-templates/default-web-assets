<!DOCTYPE html>
<html>

<head>
  <?php include "$_SERVER['SERVER_NAME']/default-html/default-header.php";?>
  <?php include "$_SERVER['SERVER_NAME']/default-html/casjays-header.php";?>
    <meta name="robots" content="index, follow" />
  <link rel="icon" href="/default-icons/favicon.png"  type="image/icon png">
  <title>Domain Doesn't Exist</title>
</head>

<body>
  <br /><br />
  <div class="c1">
    <h2>UMMMMM<br />
      This site doesn't seem to exist<br />
    </h2>
    <img alt='error' src='/default-icons/errors/404.gif'>
    <br /><br /><br />
  </div>
  <div class="c5">
    <br />
    <?php echo "Server Name: " . $_SERVER['SERVER_NAME'] . "<br />"; ?>
    <?php echo "IP Address: " . $_SERVER['SERVER_ADDR'] . "<br />"; ?>
    <br /><br />
    Linux OsVer: <?php echo shell_exec('cat /etc/casjaysdev/updates/versions/osversion.txt'); ?><br />
    ConfigVer: <?php echo shell_exec('cat /etc/casjaysdev/updates/versions/configs.txt'); ?> <br />
    REPLACE_LAST_UPDATED_ON_MESSAGE
    <br /><br />
    Powered by a Redhat based system<br />
    <a href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg"> </a><br />
    <br /><br /><br /><br /><br />
  </div>
  <!-- Begin Casjays Developments Footer -->
  <center>
    <?php include "$_SERVER['SERVER_NAME']/default-html/casjays-footer.php";?>
  </center>
  <!-- End Casjays Developments Footer -->
</body>

</html>

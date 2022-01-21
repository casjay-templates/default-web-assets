<!DOCTYPE html>
<html>
<head>
  <?php include "/default-html/default-header.php";?>
  <?php include "/default-html/casjays-header.php";?>
  <meta name="generator" content="CasjaysDev">
  <link rel="stylesheet" href="https://bootswatch.com/4/darkly/bootstrap.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
  <link rel="stylesheet" href="/default-css/casjaysdev.css">
  <script src="/default-js/errorpages/isup.js"></script>
  <script src="/default-js/errorpages/homepage.js"></script>
  <script src="/default-js/errorpages/loaddomain.js"></script>
  <link rel="icon" href="/default-icons/favicon.png"  type="image/icon png">
  <title>Site Configured</title>
</head>
<body>
  <br /><br />

  <div class="c1">
    <h2>Welcome to your new site</h2>
  </div> <br />
  <h4>
    <center>The site you have visited has <br />
      just been setup and the user <br />
      hasn't created a site yet. <br /><br />
      Please come back soon as I'm sure the <br />
      site owner is working on it!
    </center>
  </h4>
  <br /><br /><br /><br />

  <div class="c3">
    Server Admin you can now upload your site to <br />
    <?php echo $_SERVER['DOCUMENT_ROOT']; ?> <br /><br /><br />
    <?php echo "Server Name: " . $_SERVER['SERVER_NAME'] . "<br />"; ?>
    <?php echo "IP Address: " . $_SERVER['SERVER_ADDR'] . "<br />"; ?> <br />
    Linux OsVer: <?php echo shell_exec('cat /etc/casjaysdev/updates/versions/osversion.txt'); ?> <br />
    ConfigVer: <?php echo shell_exec('cat /etc/casjaysdev/updates/versions/configs.txt'); ?> <br />
    REPLACE_LAST_UPDATED_ON_MESSAGE
    <br /><br /><br />
    Powered by a Redhat based system<br />
    <a href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux"
        src="/default-icons/powered_by_redhat.jpg"> </a><br /><br /><br /><br />
  </div>

  <center>
    <!-- Begin Casjays Developments Footer -->
    <?php include "/default-html/casjays-footer.php";?>
  </center>
  <!-- End Casjays Developments Footer -->
</body>
</html>

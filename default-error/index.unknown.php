<!DOCTYPE html>
<html lang=" en-US">
  <head>
    <link rel="stylesheet" href="/default-css/errorpages/errorpages.css" />
    <link rel="stylesheet" href="/default-css/hacker.css" />

    <!-- Begin Default Header-->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="generator" content="" />
    <meta name="author" content="" />
    <meta name="description" content="" />
    <meta property="og:description" content="" />

    <link rel="icon" type="image/x-icon" href="https://avatars2.githubusercontent.com/u/43266386?s=200&v=4" />
    <link rel="stylesheet" href="/default-css/github/ribbon.css" />
    <link rel="stylesheet" href="/default-css/other/forms-min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?Roboto&family=Roboto+Mono&display=swap" />
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.0.3/cookieconsent.min.css"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <script src="https://cdn.jsdelivr.net/npm/@widgetbot/crate@3" async defer></script>
    <script src="/default-js/errorpages/isup.js" async defer></script>
    <script src="/default-js/errorpages/homepage.js" async defer></script>
    <script src="/default-js/errorpages/loaddomain.js" async defer></script>
    <script src="/default-js/utils/fetch.min.js" async defer></script>
    <script src="/default-js/utils/popper.min.js" async defer></script>
    <script src="/default-js/utils/bootstrap.bundle.min.js" async defer></script>
    <script src="https://cdn.passprotect.io/passprotect.min.js" defer></script>
    <!-- End Default Header-->
    <title>Domain Doesn't Exist</title>
  </head>
  <body>
    <div class="container vh-100">
      <br /><br />
      <div class="c1">
        <h2>
          UMMMMM<br />
          This site doesn't seem to exist<br />
        </h2>
        <br /><br />
        <img alt="error" height="400" width="400" src="/default-error/images/oops.gif" />
        <br /><br /><br />
      </div>
      <div class="c5">
        <br />
        <?php echo "System Hostname: " , gethostname() . "<br />"; ?>
        <?php echo "Server Name: " . $_SERVER['SERVER_NAME'] . "<br />"; ?>
        <?php echo "IP Address: " . $_SERVER['SERVER_ADDR'] . "<br />"; ?>
        <br /><br />
        Linux OsVer:
        <?php echo shell_exec('cat /etc/redhat-release'); ?><br />
        ConfigVer:
        <?php echo shell_exec('cat /etc/casjaysdev/updates/versions/configs.txt'); ?>
        <br /><br />
        Powered by a Redhat based system<br />
        <a href="https://redhat.com">
          <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg" /> </a
        ><br />
      </div>
      <br /><br /><br /><br /><br />
    </div>
    <!-- Begin Casjays Developments Footer -->
    <center>
      <?php include "https://REPLACE_STATIC_HOSTNAME/default-html/casjays-footer.php"; ?>
    </center>
    <!-- End Casjays Developments Footer -->
  </body>
</html>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <meta name="generator" content="CasjaysDev" />

    <link rel="shortcut icon" href="https://avatars2.githubusercontent.com/u/62282596?s=200&v=4" />

    <link
      href="https://fonts.googleapis.com/css?family=Fira+Sans:400,700,400italic,700italic"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800"
      rel="stylesheet"
      type="text/css"
    />

    <link rel="stylesheet" type="text/css" href="/default-css/hacker.css" />
    <link rel="stylesheet" type="text/css" href="/default-css/casjaysdev.css" />

    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.0.3/cookieconsent.min.css"
    />

    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"
      integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog=="
      crossorigin="anonymous"
    />

    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/darkly/bootstrap.min.css"
      integrity="sha512-YRcmztDXzJQCCBk2YUiEAY+r74gu/c9UULMPTeLsAp/Tw5eXiGkYMPC4tc4Kp1jx/V9xjEOCVpBe4r6Lx6n5dA=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/js/all.min.js"
      crossorigin="anonymous"
      defer
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
      integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
      crossorigin="anonymous"
      defer
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js" defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" defer></script>
    <script
      src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
      integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
      crossorigin="anonymous"
      defer
    ></script>

    <script src="/default-js/errorpages/isup.js" defer></script>
    <script src="/default-js/errorpages/homepage.js" defer></script>
    <script src="/default-js/errorpages/loaddomain.js" defer></script>
    <script src="https://cdn.passprotect.io/passprotect.min.js" defer></script>
    <title>Site Configured</title>
  </head>
  <body>
    <br /><br />

    <div class="c1">
      <h2>
        Welcome to your new site <br />
        The site you have visited has <br />
        just been setup and the user <br />
        hasn't created a site yet. <br /><br />
        Please come back soon as I'm sure the <br />
        site owner is working on it! <br /><br /><br /><br />
      </h2>
    </div>

    <div class="c3">
      Server Admin you can now upload your site to <br />
      <?php echo $_SERVER['DOCUMENT_ROOT']; ?>
      <br /><br /><br />
      <?php echo "System Hostname: " , gethostname() . "<br />"; ?>
      <?php echo "Server Name: " . $_SERVER['SERVER_NAME'] . "<br />"; ?>
      <?php echo "IP Address: " . $_SERVER['SERVER_ADDR'] . "<br />"; ?>
      <br />
      Linux OsVer:
      <?php echo shell_exec('cat /etc/redhat-release'); ?>
      <br />
      ConfigVer:
      <?php echo shell_exec(
        'cat /etc/casjaysdev/updates/versions/configs.txt'
      ); ?>
      <br /><br /><br />
      Powered by a Redhat based system<br />
      <a href="https://redhat.com">
        <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg" /> </a
      ><br /><br /><br /><br />
    </div>

    <center>
      <!-- Begin Casjays Developments Footer -->
      <?php include "https://REPLACE_STATIC_HOSTNAME/default-html/casjays-footer.php"; ?>
      <!-- End Casjays Developments Footer -->
    </center>
  </body>
</html>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <meta name="generator" content="CasjaysDev" />
  <link rel="shortcut icon" href="https://avatars2.githubusercontent.com/u/62282596?s=200&v=4" />
  <link href="https://fonts.googleapis.com/css?family=Fira+Sans:400,700,400italic,700italic" rel="stylesheet"
    type="text/css" />
  <link
    href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800"
    rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="/default-css/casjaysdev.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"
    integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog=="
    crossorigin="anonymous" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/darkly/bootstrap.min.css"
    integrity="sha512-YRcmztDXzJQCCBk2YUiEAY+r74gu/c9UULMPTeLsAp/Tw5eXiGkYMPC4tc4Kp1jx/V9xjEOCVpBe4r6Lx6n5dA=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/js/all.min.js" defer async></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
    integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous" defer
    async></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" crossorigin="anonymous" defer
    async></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous" defer
    async>
    </script>
  <script src="/default-js/errorpages/isup.js" crossorigin="anonymous" defer async></script>
  <script src="/default-js/errorpages/homepage.js" crossorigin="anonymous" defer async></script>
  <script src="/default-js/errorpages/loaddomain.js" crossorigin="anonymous" defer async></script>
  <script src="https://cdn.jsdelivr.net/npm/passprotect@1.0.0/umd/passprotect.min.js" crossorigin="anonymous" defer
    async></script>
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
    <?php
    echo "System Hostname: ", gethostname() . "<br />";
    echo "Server Name: " . $_SERVER['SERVER_NAME'] . "<br />";
    echo "IP Address: REPLACE_IP_4_ADRESS<br />";
    ?>
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
      <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg" />
    </a><br /><br /><br /><br />
  </div>

  <br />
  <hr />
  <div class="footer footer-custom col-sm-12">
    <!-- Begin Casjays Developments Footer -->
    <br /><br /><br />
    REPLACE_COPYRIGHT_FOOTER
    <br>
    <a href="https://casjay.pro" target="_blank">Casjays Developments</a> and <a href="https://jason.malaks.us"
      target="_blank">Jason M. Hempstead-Malak</a><br>
    Hosting by <a href="https://casjay.pro/hosting" target="_blank">Casjays Developments: Hosting</a><br>
    and powered by <a href="https://casjaysdev.pro" target="_blank">CasjaysDev.pro</a>
    <br>
    <br>
    <a href="https://www.patreon.com/casjay" target="_blank"><img
        src="https://img.shields.io/badge/patreon-donate-orange.svg" border="0" alt="Casjays Patreon Page"></a>
    <a href="https://www.paypal.me/casjaysdev" target="_blank"><img
        src="https://img.shields.io/badge/Donate-PayPal-green.svg?casjay@yahoo.com" alt="Casjays Paypal Page"></a>
    <br>
    <br>
    <a href="https://help.casjay.pro" target="_blank">CasjaysDev Support</a> |
    <a href="https://bugs.casjay.pro" target="_blank">CasjaysDev Bugs</a> <br>
    <a href="https://servers.casjay.app" target="_blank">System Status</a> |
    <a href="https://uptime.casjay.app" target="_blank">Service Status</a> |
    <a href="https://status.casjaysdev.pro" target="_blank">Complete Status</a> <br>
    <a href="https://casjaysdev.pro/domains.html" target="_blank">Casjays Developments Domains</a>
    <br>
    <br>
    Casjays Developments privacy policy can be found at<br>
    <a href="https://casjaysdev.pro/policy/" target="_blank">https://casjaysdev.pro/policy</a>
    <br>
    <!-- End Casjays Developments Footer -->
    <!-- Begin theme Code -->
    <div class="text-center" style="color: royalblue;">
      <br>
      Made with 💜💜💜💜💜💜 by <br>
      <a href="http://github.com/casjay" target="_blank" rel="noopener">
        Jason M. Hempstead (Casjay)</a><br>
      This site is powered by an
      <a href="https://github.com/casjay-templates/jekyll-site" target="_blank"> open source </a>theme
    </div>
    <br>
    <!-- End Theme powered -->
    <!-- Begin Google Track -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-936146-1"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag() { dataLayer.push(arguments); }
      gtag('js', new Date());
      gtag('config', 'UA-936146-1');
    </script>
    <!-- Eng Google Track -->

    <!-- Begin EU compliant -->
    <link rel="stylesheet" type="text/css"
      href="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.0.3/cookieconsent.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.0.3/cookieconsent.min.js"></script>
    <script>
      window.addEventListener("load", function () {
        window.cookieconsent.initialise({
          "palette": {
            "popup": {
              "background": "#64386b",
              "text": "#ffcdfd"
            },
            "button": {
              "background": "transparent",
              "text": "#f8a8ff",
              "border": "#f8a8ff"
            }
          },
          "content": {
            "message": "In accordance with the EU GDPR law this message is being displayed. - ",
            "dismiss": "I Agree",
            "link": "CasjaysDev Policy",
            "href": "https://casjaysdev.pro/policy/"
          },
          "type": "opt-out"
        })
      });
    </script>
    <br>
    <!-- end EU compliant --->
  </div>
  <br> <br>
  <!-- End Casjays Developments Footer -->
  </center>
</body>

</html>

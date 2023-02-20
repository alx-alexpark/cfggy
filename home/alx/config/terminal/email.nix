{ pkgs, config, ... }:
let 
  econfig = {
      gpg = {
        signByDefault = true;
        key = "69EBCBF0A7D62959881B4A2C24A3B83FB26AA900";
      };
      imap = {
        host = "imap.migadu.com";
        port = 993;
        tls = {
          enable = true;
        };
      };
      smtp = {
        host = "smtp.migadu.com";
        port = 465;
        tls.enable = true;
      };
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp = {
        enable = true;
      };
      neomutt = {
        enable = true;
      };
      signature = {
        showSignature = "append";
        text = ''
          Alex(ander) Park | www.parkalex.dev
          PGP Public key: 69EBCBF0A7D62959881B4A2C24A3B83FB26AA900
        '';
      };
      passwordCommand = "env TERM=alacritty pass me@parkalex.dev";
      realName = "Alex Park";
    };

in
{
  accounts.email.maildirBasePath = "mail";
  accounts.email.accounts = {
    me = econfig // {
      address = "me@parkalex.dev";
      userName = "me@parkalex.dev";
      primary = true;
    };
  };
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.neomutt = {
    enable = true;
    editor = "vim";
    sidebar = {
      enable = true;
      shortPath = true;
    };
    macros = [
      {
        key = "S";
        action = "<shell-escape>mbsync -a<enter>";
        map = [ "index" ];
      }
      {
        key = "a";
        action = "<pipe-message>abook --add-email-quiet<return>";
        map = [ "index" "pager" ];
      }
    ];
    binds = [
      {
        key = "<Tab>";
        action = "complete-query";
        map = [ "editor" ];
      }
      {
        key = "\\Cn";
        action = "sidebar-next";
        map = [ "index" "pager" ];
      }
      {
        key = "\\Ce";
        action = "sidebar-prev";
        map = [ "index" "pager" ];
      }
      {
        key = "\\Co";
        action = "sidebar-open";
        map = [ "index" "pager" ];
      }
    ];
    extraConfig = ''
    color index yellow default "~g | ~G"
    color index red default "~D"
    color index green default "~N"
    account-hook .* mbsync -a -L -H
    set query_command= "abook --mutt-query '%s'"
    '';
  };
  programs.abook = {
    enable = true;
  };
}

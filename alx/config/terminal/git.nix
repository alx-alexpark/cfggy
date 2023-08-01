{ pkgs, ... }: 
{
    programs.git = {
        enable = true;
        userName = "Alex Park";
        userEmail = "me@parkalex.dev";
        signing.key = "69EBCBF0A7D62959881B4A2C24A3B83FB26AA900";
        signing.signByDefault = true;
    };

}

{ pkgs, ... }:
{
  programs.newsboat = {
    enable = true;
    urls = [
      {
        tags = [ "blog" ];
        title = "Xe";
        url = "https://christine.website/blog.rss";
      }
      {
        tags = [ "blog"];
        title = "Drew";
        url = "https://drewdevault.com/blog/index.xml";
      }
      {
        tags = [ "blog" ];
        title = "fasterthanlime";
        url = "https://fasterthanli.me/index.xml";
      }
      {
        tags = [ "news" ];
        title = "Hacker News";
        url = "https://hnrss.org/frontpage?points=50";
      }
    ];
  };
}


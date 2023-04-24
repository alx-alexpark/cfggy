{ pkgs, ... }:
{
  environment.etc = {
    u2f_keys = {
      text = ''
      alx:JT7Drzg798rgjuHrlkUOWP05eH4nPflnrBcGXqzTmDnp7K8NevIFIyQzXYBcAfFUrMdmno0I8H3RvDFLSAuNcw==,vT78PQg+oH3D2oy44WrXX7pY0ws9LdE8a1MZKBtKYAaWsN7/RLAKmC+KtYSQWGD2UIhhD/RBh3YESR2pc53Mdg==,es256,+presence
      andrew:JT7Drzg798rgjuHrlkUOWP05eH4nPflnrBcGXqzTmDnp7K8NevIFIyQzXYBcAfFUrMdmno0I8H3RvDFLSAuNcw==,vT78PQg+oH3D2oy44WrXX7pY0ws9LdE8a1MZKBtKYAaWsN7/RLAKmC+KtYSQWGD2UIhhD/RBh3YESR2pc53Mdg==,es256,+presence
        '';
        mode = "0644";
    };
  };
}

{
  description = "A collection of flake templates";
  outputs = { self }: {
    templates = {
      python = {
        path = ./python;
        description = "Python template, using poetry2nix";
      };
    };
  };
}

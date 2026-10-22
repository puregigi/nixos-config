{
  flake.modules.nixos.locale = { ... }: {
    time.timeZone = "America/Sao_Paulo";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "en_US.UTF-8"; #"pt_BR.UTF-8"
    };

    console.keyMap = "us-acentos";

    services.xserver.xkb = {
      layout = "us";
      variant = "intl";
    };
  };

  flake.modules.homeManager.locale = { config, ... }: {
    home.file.".XCompose".text = ''
      include "%L"

      <dead_acute> <c> : "ç" U00E7
      <dead_acute> <C> : "Ç" U00C7
    '';   
    home.sessionVariables = {
      GTK_IM_MODULE = "cedilla";
      QT_IM_MODULE = "cedilla";
      XCOMPOSEFILE = "${config.home.homeDirectory}/.XCompose";
    };
  };
}

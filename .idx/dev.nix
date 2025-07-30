# Add system tools, extensions, and services to
# define the components of your workspace.
# Learn more at https://developers.google.com/idx/guides/customize-dev-nix
{
  # System tools enabled whenever this workspace is running
  packages = [
    pkgs.python3
  ];

  # Workspace extensions for the user
  vscode.extensions = [
    # Example: See https://open-vsx.org/
    # "golang.go"
  ];

  # Services to be running when the workspace is started
  services.enable = [
    # Example: See https://github.com/nix-community/home-manager/blob/master/modules/services/misc/redis.nix
    # "redis"
  ];

  # Global environment variables
  env = {
    # Example:
    # GREETING = "Hello, world!"
    FLASK_APP = "main.py";
    FLASK_DEBUG = 1;
  };

  # setup hook to install python packages
  enterShell = ''
    pip install -r requirements.txt
  '';
}
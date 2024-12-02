# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.jdk21_headless
    pkgs.gradle
  ];
  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "vscjava.vscode-java-pack"
      "vmware.vscode-boot-dev-pack"
      "redhat.fabric8-analytics"
      "SonarSource.sonarlint-vscode"
    ];
    
    previews = {
      enable = true;
      previews = {
        app = {
          command = [
            "./gradlew"
            "bootRun"
            "--args='--server.port=$PORT'"
          ];
          env = {
            PORT = "8080";
          };
          manager = "gradle";
        };
      };
    };

    workspace = {
      onCreate = {
        setup = "chmod +x gradlew && ./gradlew clean build";
        default.openFiles = [
          "README.md"
        ];
      };
    };
  };

  services = {
    docker = {
      enable = true;
    };

    postgres = {
      enable = false;
      enableTcp = true;
    };

    redis = {
      enable = false;
      port = 6379;
    };
  };
}

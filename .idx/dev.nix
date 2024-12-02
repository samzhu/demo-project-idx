# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.jdk21_headless
  ];
  # Sets environment variables in the workspace
  env = {
    JAVA_HOME = "${pkgs.jdk21_headless}";
  };
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
            "--args='--server.port=$PORT'"  # 建議加入，以確保 port 設定被正確傳遞
          ];
          env = {
            PORT = "8080"
          };
          manager = "web";
        };
      };
    };

    workspace = {
      onCreate = {
        setup = "chmod +x gradlew && ./gradlew clean build";  # 確保 gradlew 可執行
        default.openFiles = [
          "README.md"
        ];
      };
      onStart = {
        runApp = "./gradlew bootRun";  # PORT 已經在 previews 中設定了
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

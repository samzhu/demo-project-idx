# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  services.docker.enable = true;
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.apt
    pkgs.jdk21_headless
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
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        setup = "./gradlew clean build"; # 初始化專案
      };
      # Runs when a workspace is (re)started
      onStart = {
        runApp = "PORT=8080 ./gradlew bootRun"; # 啟動 Spring Boot 應用
      };
    };
  };
}

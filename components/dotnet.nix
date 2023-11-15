{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    (with dotnetCorePackages; combinePackages [
       dotnet-sdk_6
       dotnet-aspnetcore_6
       dotnet-sdk_7
       dotnet-aspnetcore_7
       pkgs-unstable.dotnet-sdk_8
       pkgs-unstable.dotnet-aspnetcore_8
    ])
  ];
}

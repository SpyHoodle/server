{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    mapHashBucketSize = 128;
    mapHashMaxSize = 512;
  };
}

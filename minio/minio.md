# Running minio on a local VM


## Running minio container

```
podman run \
   -d \
   -p 8000:9000 \
   -p 8090:9090 \
   -v /data/minio-data2:/data \
   -e "MINIO_ROOT_USER=minio" \
   -e "MINIO_ROOT_PASSWORD=minio123" \
   docker.io/minio/minio:RELEASE.2022-06-20T23-13-45Z server /data --console-address ":9090"
```

## Access Web URL

```
http://<ip address>:8090/buckets
```
![Image](https://github.com/ekambaraml/sustainability/blob/main/minio/minio-ui.png)

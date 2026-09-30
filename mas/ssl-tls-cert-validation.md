# Validating the TLS certificate files


## Verifying the MD5 are same
```
$ openssl x509 -noout -modulus -in tls.crt | openssl md5
(stdin)= b78a80029ef7c3fba73de79094b46f9a
$ openssl rsa -noout -modulus -in tls.key | openssl md5
(stdin)= b78a80029ef7c3fba73de79094b46f9a
```
## Check key is not corrupted
```
$ openssl rsa -in tls.key -check -noout
RSA key ok
```
## Check validity
```
$ openssl x509 -in tls.crt -text -noout | grep -A 2 "Validity"
        Validity
            Not Before: Sep  8 18:48:25 2026 GMT
            Not After : Dec  7 18:48:24 2026 GMT

```

## Display certificate in text format
```
 openssl x509 -in tls.crt  -text -noout
 ```

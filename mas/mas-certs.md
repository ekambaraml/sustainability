# How to Deploy self-signed SSL certs for Maximo on IBM Cloud cluster?

Log in to your cluster with your IBMid by using one of the following methods:

* Browse to the OpenShift Console. From the dropdown menu in the upper right of the page, click Copy Login Command. Paste the copied command in your local terminal.
* Browse to the oauth token request page. Follow the instructions on the page.
* Switch to the Maximo Application Suite core namespace:
```
oc project <mas-dev-core>
```

## Extract ROKS ingress certificates to your local folder:
```  
oc extract secret/$(oc get route console -n openshift-console -o jsonpath="{.spec.host}" | awk -F'.' '{print $2}') -n ibm-cert-store --confirm --to=./
```
  
  
## Apply the Certificate

Log into MAS Admin page under 

https://admin.<mas_domain>/initialsetup

![image](https://github.com/ekambaraml/sustainability/assets/26153008/5bf07517-f815-4ffc-81cc-ed106fda5e75)



## Reference
https://www.ibm.com/docs/en/mas87/8.7.0?topic=installing-setting-up-maximo-application-suite
https://www.ibm.com/docs/en/mas-cd/continuous-delivery?topic=configuring-manual-certificate-management
https://medium.com/avmconsulting-blog/how-to-secure-applications-on-kubernetes-ssl-tls-certificates-8f7f5751d788


## How does the TLS certificate work ?

THE TLS/SSL HANDSHAKE PROCESS
* Each TLS certificate consists of a key pair made of a public key and private key.
These keys are important because they interact behind the scenes during website transactions.
* Every time you visit a website, the client server and web browser communicate to ensure there is a secure TLS/SSL encrypted connection.
* When a web browser (or client) directs to a secured website, the website server shares its TLS/SSL certificate and its public key with the client to establish a secure connection and a unique session key.
* The browser confirms that it recognizes and trusts the issuer, or Certificate Authority, of the SSL certificate—in this case DigiCert. The browser also checks to ensure the TLS/SSL certificate is unexpired, unrevoked, and that it can be trusted.
* The browser sends back a symmetric session key and the server decrypts the symmetric session key using its private key. The server then sends back an acknowledgement encrypted with the session key to start the encrypted session.
* Server and browser now encrypt all transmitted data with the session key. They begin a secure session that protects message privacy, message integrity, and server security.


## File types

![image](https://github.com/ekambaraml/sustainability/assets/26153008/d72aa09d-976b-46f6-a543-dd134e6a5f31)


Extension |	Description
----------|------------
.pem |	PEM encoded certificates and keys (allows the certificate and private key to be stored together in the same file)
.der |	DER encoded certificates
.p8 |	PKCS#8 file
.p7b |	PKCS#7 file
.p12 |	PKCS12 file (allows the certificate and private key to be stored together in the same file)
.jks |	Java KeyStore file

## PEM format

Most CAs (Certificate Authority) provide certificates in PEM format in Base64 ASCII encoded files. The certificate file types can be .pem, .crt, .cer, or .key. The .pem file can include the server certificate, the intermediate certificate and the private key in a single file. The server certificate and intermediate certificate can also be in a separate .crt or .cer file. The private key can be in a .key file.

PEM files use ASCII encoding, so you can open them in any text editor such as notepad, MS word etc. Each certificate in the PEM file is contained between the ---- BEGIN CERTIFICATE---- and ----END CERTIFICATE---- statements. The private key is contained between the ---- BEGIN RSA PRIVATE KEY----- and -----END RSA PRIVATE KEY----- statements. The CSR is contained between the -----BEGIN CERTIFICATE REQUEST----- and -----END CERTIFICATE REQUEST----- statements.


## Certificate file naming conventions and details

file name | location | details
----------|----------|----------
cert.pem | ../../archive/maximo.elaxman.com/cert2.pem | details
chain.pem| ../../archive/maximo.elaxman.com/chain2.pem |
fullchain.pem | ../../archive/maximo.elaxman.com/fullchain2.pem|
privkey.pem | ../../archive/maximo.elaxman.com/privkey2.pem |

Another naming conventions
Name | details
-----|--------
tls.crt | Transport Layer Security (TLS) certificates also known as Secure Sockets Layer (SSL)
tls.key | 
ca.crt | ?

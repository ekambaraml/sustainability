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

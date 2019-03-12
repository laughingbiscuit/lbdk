# SAML in Apigee API Proxies

In Apigee is it possible to both Generate and Validate SAML Assertions

## Prerequisites

SAML Assertions use signatures. Before we can go any further, we must create a Keystore containing our public certificate and private key

Create Server Certs

``` 
# Create CA Key and Cert
openssl req -new -x509 -days 9999 -config ca.cnf -keyout ca-key.pem -out ca-crt.pem

# Generate private key for our server
openssl genrsa -out server-key.pem 4096

# Generate CSR for server
openssl req -new -config server.cnf -key server-key.pem -out server-csr.pem

# Sign the request
openssl x509 -req -extfile server.cnf -days 999 -passin "pass:password" -in server-csr.pem -CA ca-crt.pem -CAkey ca-key.pem -CAcreateserial -out server-crt.pem
```

Create Client Certs

```
# Generate client private key
openssl genrsa -out client1-key.pem 4096

# Create client CSR
openssl req -new -config client1.cnf -key client1-key.pem -out client1-csr.pem

# Sign cert
openssl x509 -req -extfile client1.cnf -days 999 -passin "pass:password" -in client1-csr.pem -CA ca-crt.pem -CAkey ca-key.pem -CAcreateserial -out client1-crt.pem

# Test 
openssl verify -CAfile ca-crt.pem client1-crt.pem
```

Upload cert to Apigee

```
# create keystore
./createKeystore.sh

# create jar
mkdir -p certs/META-INF
printf "certFile=server-crt.pem \nkeyFile=server-key.pem" > certs/META-INF/descriptor.properties
cp server-crt.pem certs && cp server-key.pem certs && cd certs && jar -cf myKeystore.jar server-crt.pem server-key.pem && jar -uf myKeystore.jar META-INF/descriptor.properties

# upload jar
./uploadCertAndKey.sh
```

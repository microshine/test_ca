# Test CA

## Generate key

```
openssl genrsa -out keyname.key
```

## Generate self-signed root CA certificate

```
openssl req -new -x509 -days 1826 -key root.key -out root.crt -config root.conf 
```

## Generate CA certificate

### Generate request
```
openssl req -new -key ca.key -out ca.req -config ca.conf
```

### Generate certificate
```
openssl x509 -req -in ca.req -CA root.crt -CAkey root.key -out ca.crt -extfile ca.conf -extensions x509_extensions
```

> NOTE: For `srl` file creation use `-CAcreateserial` option

## Signing client's request

```
openssl x509 -req -in client.req -CA ca.crt -CAkey ca.key -out client.crt -extfile client.conf -extensions x509_extensions
```

> NOTE: For `srl` file creation use `-CAcreateserial` option
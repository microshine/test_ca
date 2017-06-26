# generate keys
openssl genrsa -out root.key
openssl genrsa -out ca.key
openssl genrsa -out client.key

# generate root
openssl req -new -x509 -days 1826 -key root.key -out root.crt -config root.conf 

# generate ca
openssl req -new -key ca.key -out ca.req -config ca.conf
openssl x509 -req -in ca.req -CA root.crt -CAkey root.key -out ca.crt -extfile ca.conf -extensions x509_extensions -CAcreateserial

# generate client
openssl req -new -key client.key -out client.req -config client.conf
openssl x509 -req -in client.req -CA ca.crt -CAkey ca.key -out client.crt -extfile client.conf -extensions x509_extensions -CAcreateserial

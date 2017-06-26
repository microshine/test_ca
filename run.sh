mkdir src
cd src

# generate root
mkdir root
cd root
openssl genrsa -out root.key
openssl req -new -x509 -days 1826 -key root.key -out root.crt -config ../../root.conf
mkdir database
touch database/index.txt
touch database/index.txt.attr
cd ..

# generate ca
mkdir ca
cd ca
openssl genrsa -out cert.key
openssl req -new -key cert.key -out cert.req -config ../../ca.conf
# signing ca with root
cd ../root
openssl x509 -req -in ../ca/cert.req -CA root.crt -CAkey root.key -out ../ca/cert.crt -extfile ../../ca.conf -extensions x509_extensions -CAcreateserial
cd ../ca
mkdir database
touch database/index.txt
touch database/index.txt.attr

# generate client
mkdir certificates
openssl genrsa -out certificates/client.key
openssl req -new -key certificates/client.key -out certificates/client.req -config ../../client.conf
openssl x509 -req -in certificates/client.req -CA cert.crt -CAkey cert.key -out certificates/client.crt -extfile ../../client.conf -extensions x509_extensions -CAcreateserial

# Revoke certificate
echo "Revoke certificate"
openssl ca -revoke certificates/client.crt -config ../../ca.conf
openssl ca -gencrl -config ../../ca.conf -out crl.pem
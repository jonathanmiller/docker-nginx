#!/bin/sh

# Generate a private key and a self-signed certificate.

CERTS_DIR='/ssl'
CONFIG=$CERTS_DIR'/openssl.conf'
PEM='server.pem'
CRT='server.crt'
CSR='private.csr'

# Generate private key.
openssl genrsa -out $CERTS_DIR/$PEM 1024

# Generate cert signing request.
openssl req -new \
    -key $CERTS_DIR/$PEM \
    -out $CERTS_DIR/$CSR \
    -config $CONFIG

# Generate self-signed cert.
openssl x509 -req \
    -days 365 \
    -signkey $CERTS_DIR/$PEM \
    -in $CERTS_DIR/$CSR \
    -out $CERTS_DIR/$CRT \
    -extensions v3_req \
    -extfile $CONFIG

# Delete signing request.
rm $CERTS_DIR/$CSR


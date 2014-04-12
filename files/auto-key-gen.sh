#!/bin/sh

# Generate a private key and a self-signed certificate.

CERTS_DIR='/ssl'
CONFIG=$CERTS_DIR'/openssl.conf'
PEM='server.pem'
CRT='server.crt'
CSR='private.csr'

if [ ! -e $CONFIG ];
then
  echo "no openssl certificate config not present"
  exit
fi

# Generate private key if not provided.
if [ -e $CERTS_DIR/$PEM ];
then
  echo "$PEM already exists, skip generation."
else
  openssl genrsa -out $CERTS_DIR/$PEM 1024
fi


# Generate cert signing request if not provided.
if [ -e $CERTS_DIR/$CSR ];
then
  echo "$CSR already exists, skip generation."
else
  openssl req -new \
    -key $CERTS_DIR/$PEM \
    -out $CERTS_DIR/$CSR \
    -config $CONFIG
fi

# Generate self-signed cert if not provided.
if [ -e $CERTS_DIR/$CRT ];
then
  echo "$CRT already exists, skip generation."
else
  openssl x509 -req \
    -days 365 \
    -signkey $CERTS_DIR/$PEM \
    -in $CERTS_DIR/$CSR \
    -out $CERTS_DIR/$CRT \
    -extensions v3_req \
    -extfile $CONFIG
fi

# Delete signing request.
rm $CERTS_DIR/$CSR


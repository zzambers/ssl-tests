## General info
This project consists of:
- ssl-tests - does SSL/TLS testing, see lower
- certgen - generates keys/certificates/keystores (required by SSLSocketTest)
- SSLContextInfo - lists available SSLContexts
- SSLSocketInfo - lists default/supported ciphers for SSLSocket/SSLServerSocket (default SSLContext).

To use specific JDK use JAVA_HOME env. variable:
```
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
```

## ssl-tests
It iterates over all providers/algorithm/protocol/cipher combinations and tests them one by one.
It creates basic client+server scenario, where server just echos (repeats) everything client sends.
Both server and client sockets are configured to have only one protocol and one cipher enabled at a time (these ones to be tested).
Test then checks that no exeptions are thrown and that data sent and received match.

run by:
```
make ssl-tests
```

#### makefile variables:
- SSLTESTS_IGNORE_PROTOCOLS=... - protocols matching this pattern will be ignored
- SSLTESTS_IGNORE_CIPHERS=...   - ciphers matching this pattern will be ignored
- SSLTESTS_SSL_CONFIG_FILTER=?,?,?,? - only specified combination of provider,algorithm,protocol,cipher will be tested
- SSLTESTS_USE_OPENSSL_CLIENT=1 - use openssl client instead of default SSLSocketClient written in java for testing
- SSLTESTS_USE_GNUTLS_CLIENT=1 - use gnutls client instead of default SSLSocketClient written in java for testing
- SSLTESTS_USE_NSS_CLIENT=1 - use nss client instead of default SSLSocketClient written in java for testing

#### IGNORED combinations:
Currently, tested combination may show up as IGNORED for following reasons:
- SSLv2Hello protocol is used, having this enabled as only protocol does not make sense as far as I know
- [TLS_EMPTY_RENEGOTIATION_INFO_SCSV](https://tools.ietf.org/html/rfc5746#section-3.3) cipher is used, as this in not really a ciper
- ["No appropriate protocol" exception](https://hg.openjdk.java.net/jdk8u/jdk8u/jdk/file/ce1f37506608/src/share/classes/sun/security/ssl/Handshaker.java#l554) is thrown, as it is caused by invalid protocol/algorithm combination  (thrown by handshaker)
- protocol starts with DTLS - tests currently does not support DTLS
- ciphers starting with TLS_KRB5 - tests currently does not support these
- it is explicitly ignored (see higher)

## Other utilities

run by:
```
make SSLContextInfo
make SSLSocketInfo
```

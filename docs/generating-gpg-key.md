## GPG key

### Overview
GPG (GNU Privacy Guard)
It's a method used for encrypting and decrypting digital files and communications over the internet.

### Introduction
The following document will outline how to generate one to be used for encryption of backups(duplicity) or any other use.

### Pre-requisite
Ensure you have `gpg` installed in your machine and its version 2.1.17 or greater
````bash
gpg --version
````
if you not you can install it using the below on ubuntu but for other distros kindly download from https://www.gnupg.org/download/
````bash
sudo apt install gnupg
````

### Generate GPG key
````bash
gpg --full-generate-key
````
1. On the menu prompt select the default `RSA and RSA (default)` unless there are other explicit requirements.
````bash
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
  (14) Existing key from card
Your selection? 1
````
2. What keysize do you want? `Enter the desired or use default`
3. Select key expiry period. Choose the desired or use default.
````bash
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
````
4. Confirm your choices and press enter.
````bash
Is this correct? (y/N) y
````

5. The prompt will require you to enter the identity for your key. Enter any name must be at least 5 characters long.
````bash
GnuPG needs to construct a user ID to identify your key.

Real name: duplicity
````
6. Then enter your email address on the next prompt then enter
7. Then enter a comment on the next prompt then enter
8. Finally, confirm all your entries.
````bash
Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
````
9. You'll be presented with a password dialog, enter a secure password.

### Export public key (-pub.key)
1. List the keys
````bash
gpg --list-keys --keyid-format SHORT
````
````bash
/home/morty/.gnupg/pubring.kbx
-----------------------------
pub   rsa2048/1F660965 2021-05-11 [SC]
      3775D234D1729924919064E33B10AA311F660965
uid         [ultimate] duplicity
sub   rsa2048/78876A7A 2021-05-11 [E]
````
*NOTE: Key-ID can be in SHORT (8 last digits) or LONG (16 last digits)*
for the example above SHORT `1F660965`, LONG `3B10AA311F660965` and then the fingerprint `3775D234D1729924919064E33B10AA311F660965`

2. Export public key

````bash
gpg --armor --output 1F660965-pub.key --export 1F660965
````

### Export private keys (-priv.key)
1. List the keys

````bash
gpg --list-secret-keys --keyid-format SHORT
````
````bash
/home/morty/.gnupg/pubring.kbx
-----------------------------
sec   rsa2048/1F660965 2021-05-11 [SC]
      3775D234D1729924919064E33B10AA311F660965
uid         [ultimate] duplicity
ssb   rsa2048/78876A7A 2021-05-11 [E]
````

2. Export the secret key

````bash
gpg --armor --output 1F660965-priv.key --export-secret-keys 1F660965
````
### Export ultimate keys (-ulimate.trust)
````bash
gpg --export-ownertrust
````
Pick the fingerprint of your key-id from the list
````
6826D25B796311C5B124B2F4600AD683013E97CA:6:
3775D234D1729924919064E33B10AA311F660965:6: here!!
940358D7E31AB2F3020B3E3713BDD534C84AD974:6:
````
````
echo "3775D234D1729924919064E33B10AA311F660965:6:" >  1F660965-ulimate.trust
````

DONE!!

-----------------

### Import the key
````bash
gpg --import 1F660965-priv.key
gpg --import 1F660965-pub.key
gpg --import-ownertrust 1F660965-ulimate.trust
````

### Delete the key
````bash
gpg --delete-secret-keys 1F660965-priv.key
gpg --delete-keys 1F660965-pub.key
````

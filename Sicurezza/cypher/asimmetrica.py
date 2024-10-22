
# creazione environment, per evitare che ubuntu non vi faccia installare la libreria di crittografia
# python -m venv .venv
# e poi:
# . .venv/bin/activate
# e poi fare pip install pycryptodome
#

from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP
import base64


# # Per importare una chiave pubblica
# keyDER = base64.b64decode(pubkey)
# seq = base64.asn1.DerSequence()
# seq.decode(keyDER)
# keyPub = RSA.construct((seq[0], seq[1]))

# # Per iniziare generiamo una coppia di chiavi e le stampiamo
# # Generating RSA Key Pair
# # Una volta stampate, non serve più
# key_pair = RSA.generate(2048)
# print(key_pair.export_key())
# public_key = key_pair.publickey()
# print(public_key.export_key())
# exit(0)
sPriv = "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEAqhHBI8P5uzFToYd7tgttT0WajjRK+WNnDsyZuw4KEm6RW9Az\nQod5Qu9tHH1+5QW7vwpXkwhDtoDhp7t5d0mWrVLn29uqkiFxIFW7d5W/ixARdT/e\n8aji4poNLwGiE7o2PKhfLRulP2854TkeyGFWy5bACKSQOQOVVgCt7n6mHwILS235\n1CycnIF0ngeKFN/okKgZKzIk5ThqfjQp49JSmHehqRxs9GfdLJGRR9rDUPF0odm9\n8EBk/zqtUbAeyt2XZNHxlgaNYBSJqFa7wny1nZalwhsU5MPagPHkw/upTg4qQLFT\ndePpOBuwFkw3RHMgmFWytxWrP5Jmky26WKfUeQIDAQABAoIBACsQcdqvnkYDWIz3\ndKEFRbmkA13s6es6e3co4eiWxoAiVVZtYv1+tnr3i6aCNKajjAX1BXXqytKk0f8a\nHsjQ7oGXE7T9a7SzGSU58E14stbwy6rn8Hk67bC5l4sGm9bo+SDk9azDalWkwYBB\naYUN+N92ncvSd96oBKGRbHmOwlvpS+lLuWoA7orZJlZlOmj58OhyLedwx2TMT6dw\nfiJJ9ZoR9kAmTcZostNbydOFx6U04tdsb5ubnF13GHVWeJZqaI7HqBkQWOM6heDM\nFJbJPuUu9dSlnOh5JOfrSN+QEbU94Lkor+T+I294zj2WCM7YHcsakARZ0FP6lCQn\n0MQHjJ0CgYEAzVHIPe0kNHrJWE20X60W2AfpOIZUg+43rNZQpK26Isj4nVPVpN32\n/DBnI46xB63hM7J/X3UmB/LeKo8+GZe2O++tdbK5yYm95NpETTaICiH/f1+/v4AD\nZukVneTwXTVJOC2fv7gvSdD3Bq9LvIYNnfrxHHmfiGHIruN9SASHPk8CgYEA1AyB\nBheHJB7S40olRnpqPZ6Onlj1KA9Nzce59+jSkcRtQZrTRTcPcUg1RT1jYOo3izU+\n1SO5kEsbzGniR2Vd0/sKLxWhDiMUABfTcK1224trihsoS3E3Jrz9G3bDVEiJH3FZ\nG7LAmjHfUyXOUod26q1uScXo9Zfgk9bvO6UIlrcCgYB4CHnSilMCQ052y2bKEH0s\nauOT4iSCxL/T0a9vtwj80RVXlO1v5zw/j2Scywz/+k2QVahVfD1xpDDyHLAnciRd\nwe9cwdIP2vEjW99WbKz3j4y5QJbvM73JajbzCibjtwVJTJL6GIm80+e3BsB2RMCt\nPUm8ZfY4W0JhzCkv80XFzQKBgQCGs+rCk++lYm9VM6S6QMl8m1y9+oTCDfa+4kGg\n2qXpM360TkYnkfKdY+FzOqwGxMLEC+7+NtOKdiwSjrDP6fTQ1IiDoJnPATmTVY9b\n5NW8YbTO5rGSOzltwmCHMcqjn/B7qOWSUttHGKdlin6mrqc8LTACbVavrOtc/wy6\nNvxdwQKBgFPKL0khzpaxc1dam5KsWZrsUFQKxnon7PD93hI7DPWW/BugAYAig/WI\nj3ebABvaX6IJUyRgB4RjAwVA3kMu2d+FHGOsN2sCI37/3kYjIv5ZKe370TYCPKJM\nXHSo4bqIj47xiScDJkTv7/dtssP/Ba2V6sa8CrAeMBHQMskVz0T2\n-----END RSA PRIVATE KEY-----"
sPub = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqhHBI8P5uzFToYd7tgtt\nT0WajjRK+WNnDsyZuw4KEm6RW9AzQod5Qu9tHH1+5QW7vwpXkwhDtoDhp7t5d0mW\nrVLn29uqkiFxIFW7d5W/ixARdT/e8aji4poNLwGiE7o2PKhfLRulP2854TkeyGFW\ny5bACKSQOQOVVgCt7n6mHwILS2351CycnIF0ngeKFN/okKgZKzIk5ThqfjQp49JS\nmHehqRxs9GfdLJGRR9rDUPF0odm98EBk/zqtUbAeyt2XZNHxlgaNYBSJqFa7wny1\nnZalwhsU5MPagPHkw/upTg4qQLFTdePpOBuwFkw3RHMgmFWytxWrP5Jmky26WKfU\neQIDAQAB\n-----END PUBLIC KEY-----"
sPubRik = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwc9uIwmdNbFUMB797+C7\n3/QATMflxFfljonKo6QKmZJ0U2zqbYJCOug+eghb3Lehf97Ik+gjHUZbc3sy1Wzt\nDFreiRIVx8Z6jfo1IlH1Pcn3/4PBr3cU7JDNMUNV4VaVn75QJVveUIJ5YptN7oZG\nUZkI4AShPv5hIpSygLF1UJYZ2xK6UeGGnIkVdtECIBeCRHnKrcv0XgIL5fvMcsqR\nupTSmo/oBc8rajJ/QjGx/If8nIfNn1PmKsv5s/GeThFe5iOLPX3PMr19bdUlNCjh\nFfjx9DURZgmkiXxjK3xMdYLKqUKQpx3TJkaEwF04zzCedytc9iaXxE98s+bqMXPk\nIQIDAQAB\n-----END PUBLIC KEY-----"
# Ora dobbiamo ricreare le chiavi a partire da queste due stringhe
key_pair = RSA.import_key(sPriv)
public_key = RSA.import_key(sPub)


# Function to encrypt message
def encrypt_message(message, pub_key):
    cipher = PKCS1_OAEP.new(pub_key)
    encrypted_message = cipher.encrypt(message.encode("utf-8"))
    return base64.b64encode(encrypted_message).decode("utf-8")


# Function to decrypt message
def decrypt_message(encrypted_message, priv_key):
    cipher = PKCS1_OAEP.new(priv_key)
    decrypted_message = cipher.decrypt(base64.b64decode(encrypted_message))
    return decrypted_message.decode("utf-8")


# Example usage
#Encrypt
# message = "Ciao Ricky! :3"
# encrypted_message = encrypt_message(message, public_key)
# print("Original Message:", message)
# print("Encrypted Message:", encrypted_message)

#Decrypt
message = "eMDNbsA4JT4tiLHM9GD9o2Ngx6aKUZ3DQ2My0moAO6qofL7snK8vQglXDwTRJKzJuYKieva8OdUx44aapamMimcfeseClK0uCSAkx4COZORf/2vJg6jSoDDRt0jpPbhxp2uEwNHE5IQ+TtHXiu3AmVqA+dXjrKyZfin6TGnFT3ABn5GOSVA55ijpf03T8WCxpgrI70Yax5J7JVg4IOgrPCyooyNvJzbvllS6hCEztVxY5Ozd9XK94gSfDVKWh2O7Q/Fh4ESThJjd5L+AMRU1BmnLH93/0J0fWoY/2Ehmu8XFRy1iXNUoKb48Ttdc4J4O0Tkg3KOmBQpkpBr4DPW46Q=="

decrypted_message = decrypt_message(message, key_pair)

print("Encrypted Message:", message)
print("Decrypted Message:", decrypted_message)
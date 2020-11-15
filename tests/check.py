import sys
import os
import json
import socket

path=sys.argv[1]

def pack(s):
    return bytes(json.dumps(s), 'utf8')

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("localhost", 4444))

ok = b'{"return":'
err = b'{"error":'

caps = pack({"execute": "qmp_capabilities"})
dump = pack({"execute": "screendump", "arguments": {"filename": f"{path}"}})

print(s.recv(1024))

print(caps)
s.send(caps)
print(s.recv(1024))

print(dump)
s.send(dump)
while True:
    r = s.recv(1024)
    print(r)
    if r.startswith(ok):
        break
    elif r.startswith(err):
        break

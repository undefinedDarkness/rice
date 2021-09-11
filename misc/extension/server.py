#!/usr/bin/python3

import json
import sys
import struct
import subprocess
import threading
import signal

# Native Messaging API {{{
# Read a message from stdin and decode it.
def get_message():
    raw_length = sys.stdin.buffer.read(4)

    if not raw_length:
        sys.exit(0)
    message_length = struct.unpack('=I', raw_length)[0]
    message = sys.stdin.buffer.read(message_length).decode("utf-8")
    return json.loads(message)

# Encode a message for transmission, given its content.
def encode_message(message_content):
    encoded_content = json.dumps(message_content).encode("utf-8")
    encoded_length = struct.pack('=I', len(encoded_content))
    #  use struct.pack("10s", bytes), to pack a string of the length of 10 characters
    return {'length': encoded_length, 'content': struct.pack(str(len(encoded_content))+"s",encoded_content)}

# Send an encoded message to stdout.
def send_message(encoded_message):
    sys.stdout.buffer.write(encoded_message['length'])
    sys.stdout.buffer.write(encoded_message['content'])
    sys.stdout.buffer.flush()
# }}}

inputFile = open("/tmp/ff-tabs-input", "w+")

def checkMessageFromOutside(num, frame):
    #send_message(encode_message("Server said to read!!!"))
    command = inputFile.read()
    if command.startswith("focusTab") or command.startswith("removeTab"):
        send_message(encode_message(command))

signal.signal(signal.SIGUSR1, checkMessageFromOutside)
while True:
    message = get_message()
    #if 'event' in message:
    if message['event'] == "updateTabs":
        subprocess.run([ 'awesome-client', f'awesome.emit_signal("custom::update_ff_tabs", [[ {json.dumps(message["payload"])} ]])' ])
    elif message['event'] == "addTab":
         subprocess.run([ 'awesome-client', f'awesome.emit_signal("custom::add_ff_tab", [[ {json.dumps(message["payload"])} ]])' ])
    elif message['event'] == "updateFocused":
        subprocess.run([ 'awesome-client', f'awesome.emit_signal("custom::update_ff_focused", {message["payload"]})' ])
    elif message['event'] == "removeTab":
        subprocess.run([ 'awesome-client', f'awesome.emit_signal("custom::remove_ff_tab", {message["payload"]})' ])
    elif message['event'] == "updateTab":
        subprocess.run([ 'awesome-client', f'awesome.emit_signal("custom::update_ff_tab", [[ {json.dumps(message["payload"])} ]])' ])

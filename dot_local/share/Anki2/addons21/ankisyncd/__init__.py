import os

# https is very necessary
#addr = "https://testing.portnoy4prez.yavin4.ch/"
addr = "https://portnoy4prez.yavin4.ch/anki-sync-server/"
os.environ["SYNC_ENDPOINT"] = addr + "sync/"
os.environ["SYNC_ENDPOINT_MEDIA"] = addr + "msync/"

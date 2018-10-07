#!/bin/bash
wvdialconf
gammu -f /var/log/gammulog identify
gammu sendsms TEXT 0903789334 -text "Hi My First Message from My Monitoring System"


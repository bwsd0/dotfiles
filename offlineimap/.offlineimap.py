#! /usr/bin/env python2

from subprocess import check_output

def mailpasswd():
    return check_output("gpg2 -dq ~/.msmtp-gmail.gpg", shell=True).strip("\n")

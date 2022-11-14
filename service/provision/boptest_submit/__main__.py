from .boptest_submit import BoptestSubmit
import sys
import os
import argparse


parser = argparse.ArgumentParser(description='Submit test cases to BOPTEST.', add_help=False)

parser = argparse.ArgumentParser(parents=[parser])
parser.add_argument('-a', '--auth-token', required=True)
parser.add_argument('-s', '--shared', action='store_true')
parser.add_argument('-d', '--submit-to-dashboard', action='store_true')
parser.add_argument('-p', '--path', default='./')

args = parser.parse_args()

client = BoptestSubmit()
if args.submit_to_dashboard:
    client.submit_to_dashboard()
else:
    client.submit_all(args.path, args.auth_token, args.shared)

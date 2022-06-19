# Script to install utils-jq library
# 
# install 'pip'
#   `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py`
#   `python get-pip.py` (in current directory of get-pip.py downloaded)
# 
# install 'requests'
#   `pip instal requests`
# ----------------------------------------------------------------------------------------

import requests
import os

DEFAULT_DIR = os.path.expandvars("%userprofile%") + r"\.jq"

def get_url_content(url, full_name):
    response = requests.get(url)
    if os.path.exists(full_name) == False:
        open(full_name, "wb").write(response.content)
        print(">> File \"utils-jq.jq\" downloaded in directory \"{}\"!!!".format(DEFAULT_DIR))
    else:
        print(">> EXCEPTION: The file \"utils-jq.jq\" already exists in \"{}\"!!!".format(DEFAULT_DIR))


def setup():
	print("+--------------------------------+")
    print("|                                |")
    print("|    Setup installer utils-jq    |")
    print("|                                |")
    print("+--------------------------------+")
    print("")
    opt = input(\
    	"The following script will install the \"utils-jq\" library on your system from"\
    	"---REPO--- do you want to continue (y/n)"\
    	"\n"
    	)
    if opt.lower() == 'y':
    	get_url_content("---REPO---", DEFAULT_DIR)


# Script to install jq
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

EXECUTABLE_URL = "https://raw.githubusercontent.com/manuel-chinchi/utils-jq/dev/jq/x64/jq-1.6.exe"
EXECUTABLE_PATH = os.path.expandvars("%userprofile%") + r"\.jq"
EXECUTABLE_FULL_NAME = EXECUTABLE_PATH + r"\jq.exe"

def mkdir(new_dir):
    if os.path.exists(new_dir) == False:
        os.mkdir(new_dir)
        print(">> Created new directory \"{}\" in system!!!".format(new_dir))
    else:
        print(">> Directory \"{}\" already exists!!!".format(new_dir))

def get_url_content(url, full_name):
    response = requests.get(url)
    if os.path.exists(full_name) == False:
        open(full_name, "wb").write(response.content)
        print(">> Downloaded file in \"{}\" from {}!!!".format(full_name, url))
    else:
        print(">> File \"{}\" already exists!!!".format(full_name))

# @author Kieran Wood
# @ref https://stackoverflow.com/questions/63782773/how-to-modify-windows-10-path-variable-directly-from-a-python-script
def add_to_path(program_path: str):
    """Takes in a path to a program and adds it to the system path"""
    if os.name == "nt": # Windows systems
        import winreg # Allows access to the windows registry
        import ctypes # Allows interface with low-level C API's

        with winreg.ConnectRegistry(None, winreg.HKEY_CURRENT_USER) as root: # Get the current user registry
            with winreg.OpenKey(root, "Environment", 0, winreg.KEY_ALL_ACCESS) as key: # Go to the environment key
                existing_path_value = winreg.EnumValue(key, 3)[1] # Grab the current path value
                new_path_value = existing_path_value + ";" + program_path + ";" # Takes the current path value and appends the new program path
                winreg.SetValueEx(key, "PATH", 0, winreg.REG_EXPAND_SZ, new_path_value) # Updated the path with the updated path
    else: # If system is *nix
        with open(f"{os.getenv('HOME')}/.bashrc", "a") as bash_file:  # Open bashrc file
            bash_file.write(f'\nexport PATH="{program_path}:$PATH"\n')  # Add program path to Path variable
        os.system(f". {os.getenv('HOME')}/.bashrc")  # Update bash source
    # print(f"Added {program_path} to path, please restart shell for changes to take effect")

def setup():
    mkdir(EXECUTABLE_PATH)
    get_url_content(EXECUTABLE_URL, EXECUTABLE_FULL_NAME)
    #TODO falta chequear si ya existe la variable de usuario
    #TODO revisar 'add_to_path', ya que setea bien el valor pero borra el PATH original al parecer 
    opt = input(">> Edit PATH enviroment system? y/n:\n")
    if opt == 'y':
        add_to_path(EXECUTABLE_PATH)
        print(">> Add \"{}\" into PATH system!!!".format(EXECUTABLE_PATH))
    else:
        print(">> Exit")

setup()
# Script to install jq.exe
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
        print(">> New directory \"{}\" created in you system!!!".format(new_dir))
    else:
        print(">> EXCEPTION: The directory \"{}\" already exists!!!".format(new_dir))

def get_url_content(url, full_name):
    response = requests.get(url)
    if os.path.exists(full_name) == False:
        open(full_name, "wb").write(response.content)
        print(">> File \"jq.exe\" downloaded in directory \"{}\"!!!".format(EXECUTABLE_PATH))
    else:
        print(">> EXCEPTION: The file \"jq.exe\" already exists in \"{}\"!!!".format(EXECUTABLE_PATH))

# @author Kieran Wood
# @ref https://stackoverflow.com/questions/63782773/how-to-modify-windows-10-path-variable-directly-from-a-python-script
def add_to_path(program_path: str):
    """Takes in a path to a program and adds it to the system path"""
    if os.name == "nt": # Windows systems
        import winreg # Allows access to the windows registry
        import ctypes # Allows interface with low-level C API's

        with winreg.ConnectRegistry(None, winreg.HKEY_CURRENT_USER) as root: # Get the current user registry
            with winreg.OpenKey(root, "Environment", 0, winreg.KEY_ALL_ACCESS) as key: # Go to the environment key
                current_path_user = winreg.EnumValue(key, 3)[1] # Grab the current path value
                if current_path_user.find(program_path) > -1:
                    print(">> EXCEPTION: The user variable PATH already contains the value \"{}\"!!!".format(program_path))
                    return
                if current_path_user[-1] != ";":
                    current_path_user = current_path_user + ";"
                new_path_value = current_path_user + program_path + ";" # Takes the current path value and appends the new program path
                winreg.SetValueEx(key, "PATH", 0, winreg.REG_EXPAND_SZ, new_path_value) # Updated the path with the updated path

        # This part allows the modified variable "PATH" to be recognized without the need to restart the computer.
        HWND_BROADCAST = 0xFFFF
        WM_SETTINGCHANGE = 0x1A
        SMTO_ABORTIFHUNG = 0x0002
        result = ctypes.c_long()
        SendMessageTimeoutW = ctypes.windll.user32.SendMessageTimeoutW
        SendMessageTimeoutW(HWND_BROADCAST, WM_SETTINGCHANGE, 0, u"Environment", SMTO_ABORTIFHUNG, 5000, ctypes.byref(result),)
    else: # If system is *nix
        with open(f"{os.getenv('HOME')}/.bashrc", "a") as bash_file:  # Open bashrc file
            bash_file.write(f'\nexport PATH="{program_path}:$PATH"\n')  # Add program path to Path variable
        os.system(f". {os.getenv('HOME')}/.bashrc")  # Update bash source
    print(">> The user variable PATH has updated!!!")
    # print(f"Added {program_path} to path, please restart shell for changes to take effect")


def setup():
    print("+--------------------------------+")
    print("|                                |")
    print("|        jq 1.6 installer        |")
    print("|                                |")
    print("+--------------------------------+")
    print("")
    opt = input( \
        "The following script will create a directory on your system and modify "\
        "the PATH environment variable (for users only) do you want to continue? (y/n)"\
        "\n"
        )
    if opt.lower() == 'y':
        mkdir(EXECUTABLE_PATH)
        get_url_content(EXECUTABLE_URL, EXECUTABLE_FULL_NAME)
        add_to_path(EXECUTABLE_PATH)

setup()
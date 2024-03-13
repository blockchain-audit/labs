

## Task


* Copy, explain and compile the 1_Storage.sol, 2_Owner.sol, 3_Ballot.sol from [this](https://github.com/blockchain-audit/cheatsheet.sol/tree/main/contracts) file.

* commit into your labs forked repository
* send an okay in henry-class channel



## Connect to the Server

To make an SSH connection using a specific private key file, you can utilize the `-i` flag in the `ssh` command. Here's how you can do it:

```bash
ssh -i /path/to/private_key_file username@34.165.212.190
```

Replace `/path/to/private_key_file` with the actual path to your private key file, `username` with your username on the remote server, and `hostname` with the hostname or IP address of the remote server.

For example:

```bash
ssh -i ~/.ssh/id_rsa username@34.165.212.190
```

This command will initiate an SSH connection to `example.com` using the private key located at `~/.ssh/id_rsa`.

Make sure that the private key file has the correct permissions set. Typically, it should only be readable by the owner:

```bash
chmod 600 /path/to/private_key_file
```

This command ensures that only the owner of the file can read it.

That's it! You should now be able to establish an SSH connection using the specific private key file.




## Linux Intro


Certainly! Here are ten commonly used commands in Linux along with explanations and examples:

1. **ls** (List Directory Contents):
   - Explanation: Lists files and directories in the current directory.
   - Example:
     ```bash
     ls
     ```
     This command will list the files and directories in the current working directory.

   - Example:
     ```bash
     ls -oa
     ```
     This command show all the details


2. **cd** (Change Directory):
   - Explanation: Allows you to change your current working directory.
   - Example:
     ```bash
     cd /path/to/directory
     ```
     This command will change the current working directory to `/path/to/directory`.

3. **pwd** (Print Working Directory):
   - Explanation: Prints the full path of the current working directory.
   - Example:
     ```bash
     pwd
     ```
     This command will display the full path of the current working directory.

4. **mkdir** (Make Directory):
   - Explanation: Creates a new directory.
   - Example:
     ```bash
     mkdir new_directory
     ```
     This command will create a new directory named `new_directory` in the current working directory.

5. **rm** (Remove):
   - Explanation: Deletes files or directories.
   - Example:
     ```bash
     rm file.txt
     ```
     This command will delete the file named `file.txt`.

6. **cp** (Copy):
   - Explanation: Copies files or directories.
   - Example:
     ```bash
     cp file1.txt file2.txt
     ```
     This command will copy `file1.txt` to `file2.txt`.

7. **mv** (Move):
   - Explanation: Moves or renames files or directories.
   - Example:
     ```bash
     mv file1.txt /path/to/destination/
     ```
     This command will move `file1.txt` to the directory `/path/to/destination/`.

8. **cat** (Concatenate and Display):
   - Explanation: Displays the contents of a file or concatenates files and displays the output.
   - Example:
     ```bash
     cat file.txt
     ```
     This command will display the contents of the file `file.txt`.

9. **grep** (Global Regular Expression Print):
   - Explanation: Searches for patterns in files.
   - Example:
     ```bash
     grep "pattern" file.txt
     ```
     This command will search for the string "pattern" in the file `file.txt`.

10. **sudo** (Superuser Do):
    - Explanation: Executes a command with elevated privileges.
    - Example:
      ```bash
      sudo apt-get update
      ```
      This command will update the package lists for repositories configured in APT (Advanced Package Tool) with root privileges.

These commands are fundamental to navigating and manipulating files and directories in a Linux environment. They form the basis of many workflows and are essential for both beginners and experienced users.

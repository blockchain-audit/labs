

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

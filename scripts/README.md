## The `scripts` folder

Inside this folder are some scripts used for building and running (and maybe other things) the OS.

Most of these scripts are actually just simpler versions of the original commands they replace. For example:

- Instead of running `nasm -f bin boot.asm -o boot.bin` for building a binary for the OS, you can run the `./scripts/build.sh` script like this:

    ```./scripts/build.sh boot.asm```
    
    This will automatically output a `boot.bin` file inside the `bin` folder.
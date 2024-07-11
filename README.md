# [Commander X16](http://www.commanderx16.com/) Assembly Examples

* [Download](https://github.com/cc65/cc65?#downloads) and install the `ca65` compiler and the `ld65` linker (part of the [cc65](https://cc65.github.io/) tool). Unfortunately there is no pre-built mac executable, but it is easy enough to install using brew (`brew install cc65`).

* Run the [`compile.sh`](compile.sh) file or use the [vscode build task](.vscode/tasks.json). It will compile the assembler source [`main.s`](main.s) and link to a [`main.prg`](main.prg) file (file should be around 45 bytes).

* Run the `main.prg` on the x16 hardware or the [x16 emulator](https://github.com/X16Community/x16-emulator/releases). Type `LOAD"MAIN.PRG",8,1` to load the file and then type `RUN` to start the program. The text `HELLO WORLD!` will be shown.
 If you run the emulator on the command line, you can type: `./x16emu -prg main.prg -run` to load and run it without having to type inside the emulator.

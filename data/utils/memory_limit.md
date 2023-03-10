# Limit memory for processes in HPC batch file

There are some tools which always cause memory overflow and hence the HPC job gets killed. This can be overcome by setting a softlimit on memory using `ulimit` bash command.

```bash
## set the memory soft limit to 20000Mb
ulimit  -Sv 20000
## some command
ulimit -Sv unlimited
```

<br><br>
___
*[back to Utils page](../../00_utils.md)* &nbsp; &nbsp; &nbsp; &nbsp; or &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *[back to main page](../../README.md)*

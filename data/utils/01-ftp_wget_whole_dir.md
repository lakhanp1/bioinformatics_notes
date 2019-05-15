
## download all the files and directories from FTP link using wget
**Example:**  
```bash
wget -rkpN -e robots=off --no-parent http://www.example.com/
```
In the above command:
- -r means recursively
- -k means convert links. So links on the webpage will be localhost instead of example.com/bla
- -p means get all webpage resources so obtain images and javascript files to make website work properly.
- -N is to retrieve timestamps so if local files are newer than files on remote website skip them.
- -e is a flag option it needs to be there for the robots=off to work.
- --no-parent means don't ascend to the parent directory
- robots=off means ignore robots file. 

**Reference**: https://superuser.com/questions/655554/download-all-folders-subfolders-and-files-using-wget



## download all the files and directories from FTP link using wget
**Example:**  
```bash
wget -rkpN -nH --cut-dirs 7 -e robots=off --no-parent -P output_dir http://rsat-tagc.univ-mrs.fr/rsat/tmp/www-data/2019/09/15/matrix-clustering_2019-09-15.114019_wP3p5W/
```
In the above command:
- -r means recursively
- -k means convert links. So links on the webpage will be localhost instead of example.com/bla
- -p means get all webpage resources so obtain images and javascript files to make website work properly.
- -N is to retrieve timestamps so if local files are newer than files on remote website skip them.
- -nH will not create host directories
- --cut-dirs ignores NUMBER (7 in above URL) remote directory components
- -e is a flag option it needs to be there for the robots=off to work.
- --no-parent means don't ascend to the parent directory
- robots=off means ignore robots file. 
- -P data is stored to directory provided by this perfix

**Reference**: https://superuser.com/questions/655554/download-all-folders-subfolders-and-files-using-wget

<br><br>
___
*[back to Utils page](../../00_utils.md)* &nbsp; &nbsp; &nbsp; &nbsp; or &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *[back to main page](../../README.md)*
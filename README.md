# Download_GSE_Files

automates the process of downloading GSE files from public repository GEO

## Setup

1. `cd <working directory>`
2. `git clone https://github.com/laratse/Download_GSE_Files.git`
3. change permissions of `downloadFiles` and `downloadGseFiles.sh`

```
chmod +x downloadFiles Tools/downloadGseFiles.sh
```

4. move `Tools` and `downloadFiles` to working directory

## Usage

1. Create your own directory to store the downloaded files. The directory name must be in the format of "xx..x_GSEnn..n" (no whitespace characters allowed, GSE id must be placed at the end of the string), eg. xyz_XYZ_GSE12345. When a corresponding directory is not provided, a default directory with the name DIR_GSEn...nn will be used instead
2. create in.txt to enter the ID, one ID per line
3. run the program by `./downloadFiles`

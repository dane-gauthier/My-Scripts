remove-item -path 'C:\test\*' -recurse
new-item -Path 'C:\test\test&1' -ItemType Directory
new-item -Path 'C:\test\Test&2' -ItemType Directory
new-item -Path 'C:\test\Test&3' -ItemType Directory
new-item -Path 'C:\test\Test&1.txt' -ItemType File
new-item -Path 'C:\test\Test&2.txt' -ItemType File 
new-item -Path 'C:\test\Test&3.txt' -ItemType File
new-item -path 'C:\test\test  1.txt' -ItemType File
new-item -path 'C:\test\test  2.txt' -ItemType File
new-item -path 'C:\test\test  3.txt' -ItemType File
New-Item -path 'C:\test\test  1' -ItemType Directory
New-Item -path 'C:\test\test  2' -ItemType Directory
New-Item -path 'C:\test\test  3' -ItemType Directory
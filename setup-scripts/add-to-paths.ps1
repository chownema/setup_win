﻿# Get it
$path = [System.Environment]::GetEnvironmentVariable(
    'PATH',
    'Machine'
);
$pathArray = $path.Split(';');
echo $pathArray;

$includePathArray = 
'C:\Program Files\Oracle\VirtualBox',
'C:\Program Files\Docker\Docker\resources\bin',
'C:\Program Files (x86)\Common Files\Oracle\Java\javapath',
'C:\Program Files\Alacritty\',
'C:\ProgramData\chocolatey\bin',
'C:\Program Files\Git\cmd',
'C:\Program Files\Amazon\AWSCLI\bin\',
'C:\Users\chown\AppData\Local\Programs\Microsoft VS Code\Code.exe',
'C:\Users\chown\flutter\bin';

ForEach ($includeP in $includePathArray) {
    $existsInArray = 0;
    ForEach ($p in $pathArray) {
        if ($includeP -eq $p) {
            $existsInArray = 1;
        }
    }

    if (!$existsInArray) {
        echo $includeP;
        echo 'does not exist in path, adding ...';
       
        $newPath = [System.Environment]::GetEnvironmentVariable(
            'PATH',
            'Machine'
        );
        
        $newPath += $includeP;
        $newPath += ';';

        [System.Environment]::SetEnvironmentVariable(
            'PATH',
            $newPath,
            'Machine'
        )

    }
}

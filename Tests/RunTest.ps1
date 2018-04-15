Param (
    [Parameter(Mandatory=$false)]
    $testFilesPath
)

Import-Module Azure -Force
Import-Module Pester -Force

if ($testFilesPath) {
    Invoke-Pester $testFilesPath
}
else {
    Invoke-Pester
}


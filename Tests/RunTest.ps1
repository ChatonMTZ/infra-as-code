Param (
    [Parameter(Mandatory=$false)]
    $testFilesPath
)

Import-Module Azure -Force
Import-Module Pester -Force

if ($testFilesPath) {
    Invoke-Pester -OutputFile $testFilesPath\testresult.xml -OutputFormat NUnitXml $testFilesPath
}
else {
    Invoke-Pester -OutputFile testresult.xml -OutputFormat NUnitXml
}


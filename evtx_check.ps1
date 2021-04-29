#powershellが存在するとこ
$strP =Split-Path -Parent $MyInvocation.MyCommand.Path
$sinseiList = ""
$re = ""
$d = Get-Date
$prs = 1
get-childItem $strP"\evtx格納先\" | foreach {
    $sinseiList = Get-WinEvent -Path $strP\evtx格納先\$_ 
    foreach($List in $sinseiList){
        if (($List.Id -ne 1) -and ($List.Id -ne 14) -and ($List.Id -ne 4) -and ($List.TimeCreated.Date -eq $d.Date)){
            $re += $_.ToString()+"`r`n"
        }
    }
    $prss = $prs / ((get-childItem $strP"\evtx格納先\").Length / 100)
    Write-Progress -Activity "チェック中…" -Status "しばらくおまちください" -PercentComplete $prss -CurrentOperation "$prss % 完了"
    $prs +=1
}
if($re.Length -eq 0){
    Write-Host "
       ■          ■                              
■■■■   ■      ■   ■   ■     ■             ■      
■■■■■■■■■■■   ■■  ■  ■     ■■■■■■■■■■    ■■      
       ■       ■  ■  ■    ■■■ ■ ■        ■■      
■■■■ ■■  ■        ■         ■ ■ ■        ■■      
     ■■ ■     ■■■■■■■■■   ■■■■■■■■■■■    ■■      
■■■■  ■■              ■     ■ ■ ■        ■■      
■■■■  ■  ■    ■■■■■■■■■   ■■■■■■■■■■■    ■■      
■  ■ ■  ■■            ■                  ■■     ■
■  ■   ■ ■            ■    ■  ■ ■  ■      ■   ■■ 
■■■■ ■■   ■   ■■■■■■■■■   ■■  ■  ■  ■     ■■■■■  
■                     ■       ■                  
" -BackgroundColor White -ForegroundColor Magenta
}else{
    Write-Host $re -BackgroundColor Yellow -ForegroundColor DarkBlue
    Write-Host "↑バックアップ失敗している"
}
pause

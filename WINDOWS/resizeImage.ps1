 Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string[]]$Params
)

foreach ($param in $Params) {
    $TMP_TARGET = [System.IO.Path]::GetFileNameWithoutExtension($param)
    New-Item -ItemType Directory -Path $TMP_TARGET | Out-Null

    $size = & 'identify' -format "%wx%h" $param
    $size_x4 = "{0}x{1}" -f ($size.Split('x')[0]*4), ($size.Split('x')[1]*4)
    $size_x3 = "{0}x{1}" -f ($size.Split('x')[0]*3), ($size.Split('x')[1]*3)
    $size_x2 = "{0}x{1}" -f ($size.Split('x')[0]*2), ($size.Split('x')[1]*2)
    $size_x1_5 = "{0}x{1}" -f ($size.Split('x')[0]*1.5), ($size.Split('x')[1]*1.5)
    $size_x0_75 = "{0}x{1}" -f ($size.Split('x')[0]*0.75), ($size.Split('x')[1]*0.75)

    & 'convert' $param -resize $size_x4 "$TMP_TARGET/$TMP_TARGET@4x.png"
    Write-Host "FINISHED Image size $param x4 : $size_x4"
    
    & 'convert' $param -resize $size_x3 "$TMP_TARGET/$TMP_TARGET@3x.png"
    Write-Host "FINISHED Image size $param x3 : $size_x3"
    
    & 'convert' $param -resize $size_x2 "$TMP_TARGET/$TMP_TARGET@2x.png"
    Write-Host "FINISHED Image size $param x2 : $size_x2"
    
    & 'convert' $param -resize $size_x1_5 "$TMP_TARGET/$TMP_TARGET@1.5x.png"
    Write-Host "FINISHED Image size $param x1.5 : $size_x1_5"
    
    & 'convert' $param -resize $size "$TMP_TARGET/$TMP_TARGET@1x.png"
    Write-Host "FINISHED Image size $param x1 : $size"
    
    & 'convert' $param -resize $size_x0_75 "$TMP_TARGET/$TMP_TARGET@0.75x.png"
    Write-Host "FINISHED Image size $param x0.75 : $size_x0_75"
}
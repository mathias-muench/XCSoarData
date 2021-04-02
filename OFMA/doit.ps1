$airac=2103
$shell=new-object -com shell.application
$Location=$shell.namespace((Get-Location).Path)

#$regions = @{"germany" = "ed"; "austria" = "lovv"; "switzerland" = "lsas"; "slovenia" = "ljla"; "ep" = "epww"; "lk" = "lkaa"; "eb" = "ebbu"; "eh" = "ehaa"}
$regions = @{"germany" = "ed"; "austria" = "lovv"; "switzerland" = "lsas"; "slovenia" = "ljla"; "li" = "li"}
foreach ($region in $regions.Keys)
{
    $fir=$regions.Item($region)

    Invoke-WebRequest -Uri http://snapshots.openflightmaps.org/live/$airac/cup/$fir/latest/cup_$region.zip -OutFile cup_$region.zip
    Remove-Item -Recurse -ErrorAction Ignore cup_$region
    $ZipFile=Get-ChildItem cup_$region.zip
    $Location.Copyhere($shell.namespace($ZipFile.fullname).items())
    Copy-Item -Force -Destination ($fir + ".cup") cup_$region\isolated\ofm.cup
}

#$regions = @{"ed" = "ed"; "lo" = "lovv"; "ls" = "lsas"; "lj" = "ljla"; "ep" = "epww"; "lk" = "lkaa"; "eb" = "ebbu"; "eh" = "ehaa"}
$regions = @{"ed" = "ed"; "lo" = "lovv"; "ls" = "lsas"; "lj" = "ljla"; "li" = "li"}
foreach ($region in $regions.Keys)
{
    $fir=$regions.Item($region)

    Invoke-WebRequest -Uri http://snapshots.openflightmaps.org/live/$airac/openair/$fir/latest/openair_$region.zip -OutFile openair_$region.zip
    Remove-Item -Recurse -ErrorAction Ignore openair_$region
    $ZipFile=Get-ChildItem openair_$region.zip
    $Location.Copyhere($shell.namespace($ZipFile.fullname).items())
    Copy-Item -Force openair_$region\isolated\$fir.desktop.strepla.openair.txt
}

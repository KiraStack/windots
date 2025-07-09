$exePath = "$env:APPDATA\AltSnap\AltSnap.exe"

Register-ScheduledTask -TaskName "AltSnap" `
  -Trigger (New-ScheduledTaskTrigger -AtLogOn -RandomDelay "00:00:10") `
  -Principal (New-ScheduledTaskPrincipal -GroupId "BUILTIN\Users" -RunLevel Highest) `
  -Action (New-ScheduledTaskAction -Execute $exePath) `
  -Settings (New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -ExecutionTimeLimit 0) `
  -Description "Automatically starts AltSnap with highest privileges at user log-on" -Force

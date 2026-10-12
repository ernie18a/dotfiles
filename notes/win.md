# download win 10 directly

- F12
- click top right "..."
- More tools
- Network conditions
- User agent
- Uncheck "Select automatically"
- choose a non-Windows user agent, e.g., "Safari – iPad iOS 12".
- F5
- done
# PotPlayer
Open up Preferences (default shortcut is F5)
In the menu tree on the left, navigate to Playback
Default window size should be at the top, set that to Do not use
# wifi powersave bad for wsl
```bash
Set-NetAdapterAdvancedProperty -Name "Wi-Fi" -DisplayName "Power Saving" -RegistryValue 0
```
```
sudo apt update && sudo apt install -y openssh-server
sudo sed -i 's/^#\?Port .*/Port 22/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
echo -e "[boot]\nsystemd=true" | sudo tee /etc/wsl.conf
sudo systemctl enable ssh
```
```
PS C:\WINDOWS\system32> "[wsl2]`nnetworkingMode=mirrored" | Set-Content "$env:USERPROFILE\.wslconfig" -Encoding ascii
PS C:\WINDOWS\system32> Get-Content "$env:USERPROFILE\.wslconfig"
[wsl2]
networkingMode=mirrored
PS C:\WINDOWS\system32> wsl --shutdown
PS C:\WINDOWS\system32> Set-NetFirewallHyperVVMSetting -Name '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' -DefaultInboundAction Allow
```

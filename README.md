This project leverages a simple vulnerability in the way that StartAllBack checks licensing.

The key will be the only key under CLSID that is all lowercase. StartAllBack looks to see how long that key has been active. If you delete it, it recreates the key and restarts the trial.

Example HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{9fce6b89-ea11-1a21-9bc0-81917c66e2f}

Your trial will remain at 100 days, eternally. Check out our <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/releases">Releases</a>.

Tested on Windows 24H2 and StartAllBack v3.9.10.

I've actually been testing this vulnerability for several versions of StartAllBack and no changes we're needed in my code.

Try the Eternal Trial on the latest version, first.

<b>INSTRUCTIONS:</b><br>
1.) Download the official release of <a href="https://www.startallback.com/">StartAllBack</a> (Whatever it is at this time) and install it.<br>
2.) Check out <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/releases">Releases</a> page and download the latest release. <b>StartAllBack_EternalTrial.exe</b>

<b>ISSUES/DOESN'T WORK:</b><br>
1.) Uninstall StartAllBack.<br>
2.) Download the last tested version <a href="https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_3.9.10_setup.exe">StartAllBack v.3.9.10</a> (Official Signed Source) and install it.<br>
3.) Try our latest release again. <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/releases">Releases</a>. <b>StartAllBack_EternalTrial.exe</b><br>

<b>Reporting an Issue:</b>
Create a new post, <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/issues">here</a> in the <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/issues">Issues</a> section.

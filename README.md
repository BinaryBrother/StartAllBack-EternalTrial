<h1>True Apps</h1>
<p>This project leverages a simple vulnerability in the way that StartAllBack checks licensing.</p>
<p>StartAllBack looks at the "last modified" timestamp of a specific registry key.<br />The registry key will be the only key under CLSID that is all lowercase.&nbsp; If you delete it, it recreates the key and restarts the trial.<br /><br />Example HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{9fce6b89-ea11-1a21-9bc0-81917c66e2f} </p>
<p>With this project, your trial will remain at 100 days. I've actually been testing this vulnerability for several versions of StartAllBack and no changes we're needed in my code. Try the Eternal Trial on the latest version, first.</p>
<h1>INSTRUCTIONS</h1>
<p>1.) Download the official release of <a href="https://www.startallback.com/">StartAllBack</a> (Whatever it is at this time) and install it.<br /> 2.) Check out <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/releases">Releases</a> page and download the latest release. <strong>StartAllBack_EternalTrial.exe</strong></p>
<h1>Troubleshooting</h1>
<p>1.) Uninstall StartAllBack.<br /> 2.) Download the last tested version <a href="https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_3.9.10_setup.exe">StartAllBack v.3.9.10</a> (Official Signed Source) and install it.<br /> 3.) Try our latest release again. <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/releases">Releases</a>. <strong>StartAllBack_EternalTrial.exe</strong></p>
<h1>Reporting an Issue</h1>
<p>Create a new post, <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/issues">here</a> in the <a href="https://github.com/BinaryBrother/StartAllBack-EternalTrial/issues">Issues</a> section.</p>
<p>Last tested StartAllBack version: <strong>v3.9.10</strong> (Current as of writing)</p>
<p>Last tested OS: <strong>Windows 11 24H2</strong></p>
<h1><strong>Message to Software Vendors</strong></h1>
<p>I provide the neccerary information for these vulnerabilities to be patched. True Apps is purely for educational review. This is why we release FOSS examples, for transparency.</p>

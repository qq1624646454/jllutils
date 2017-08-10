dim objShell
set objShell=wscript.createObject("WScript.Shell")
Set args = WScript.Arguments
if args.Count > 2 then
    rem wscript.echo "Check - args.Count > 2"
    pwd = args(0)
    url = args(1)
    cmd = args(2)
    iReturnCode=objShell.Run("plink -ssh -2 -X -C -pw " & pwd &" " & url & " " & cmd,0,TRUE)
	wscript.echo iReturnCode
else
    wscript.echo "Error - args.Count < 2"
end if
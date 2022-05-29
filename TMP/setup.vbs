Option Explicit

' Const URL = "https://objects.githubusercontent.com/github-production-release-asset-2e65be/5101141/6387d980-de1f-11e8-9108-d55ca3d2be22?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220501%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220501T135253Z&X-Amz-Expires=300&X-Amz-Signature=d58fb8073a75ac652c52cca3414e535602f6b890bb20b446675ef279a10c27f0&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=5101141&response-content-disposition=attachment%3B%20filename%3Djq-win64.exe&response-content-type=application%2Foctet-stream"
' Const URL = "https://www.google.com.ar/?hl=es"
' Const URL="https://github.com/manuel-chinchi/utils-jq/blob/dev/jq/x64/jq-1.6.exe"
Const URL = "https://raw.githubusercontent.com/manuel-chinchi/utils-jq/dev/jq/x64/jq-1.6.exe"

Function GetUsername()
    Dim objShell : set objShell = CreateObject("WScript.Network")
    Dim userName : userName = objShell.userName
    GetUsername = userName 
End Function ' GetUsername

Function GetUrlContent(url, saveDirectory)
    Dim objXMLHTTP : Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP.3.0")
    Dim objStream

    objXMLHTTP.Open "GET", url, False
    objXMLHTTP.Send

    If objXMLHTTP.Status = 200 Then
        Set objStream = CreateObject("ADODB.Stream")
        With objStream
            .Open
            .Type = 1
            .Write objXMLHTTP.responseBody
            .SaveToFile saveDirectory
            .Close
        End With
    End If
End Function ' GetUrlContent

Function MkDir(DirectoryPath)
    Dim objFSO : set objFSO = CreateObject("Scripting.FileSystemObject")
    If Not objFSO.FolderExists(DirectoryPath) Then
        MkDir = objFSO.CreateFolder(DirectoryPath)
    Else
        MkDir = ""
    End If
End Function ' MkDir

' Dim abd: abd = Nothing

Function TMP()
    ' Dim objFSO: set objFSO = CreateObject("Scripting.FileSystemObject")
    ' Dim currDir: currDir = objFSO.GetAbsolutePathName(".")
    ' MsgBox currDir

    Dim newPath: newPath = "C:\Users\manue\jq"

    ' Dim objShell: set objShell = WScript.CreateObject("WScript.Shell")
    Dim objShell: set objShell = CreateObject("Wscript.Shell")
    Dim systemPaths: set systemPaths = objShell.Environment("SYSTEM")

    If InStr(UCase(systemPaths("PATH")), UCase(newPath)) = 0 Then ' Not exists path variable!
        ' MsgBox "agregada " &newPath &" al sistema"
        Dim oldSystemPaths: oldSystemPaths = systemPaths("PATH")
        ' On Error Resume Next
        Dim newSystemPaths: newSystemPaths = oldSystemPaths &";" &newPath &"\"
        systemPaths("PATH") = newSystemPaths

        MsgBox "Agregada la variable " &newPath &" al sistema"
    End If

    ' Dim pos: pos = InStr(UCase(pathsSystem), UCase(newPathSystem))
    ' MsgBox pos
    ' If InStr(UCase(pathsSystem), UCase(newPathSystem)) = 0 Then
    '     MsgBox "ya se agrego a variables de sistema"
    ' End If

End Function ' TMP

TMP

' Dim newDir: newDir = "C:\Users\" &GetUsername &"\.jq"
' Dim newDirPath: newDirPath = MkDir("C:\Users\" &GetUsername &"\.jq")
' If newDirPath = "" Then
'     MsgBox "El directorio " &newDir &" ya existe"
' Else
'     MsgBox "El directorio " &newDirPath &" fue creado"
' End If

' GetUrlContent URL, "C:\Users\manue\Programacion\github\utils-jq\jq.exe"

' -------------------------------------------------------------------------------------------
' Dim fileSys, newFolder, newFolderPath
' newFolderPath = "C:\Users\" &GetUsername  &"\.jq"

' Set fileSys = CreateObject("Scripting.FileSystemObject")
' If Not fileSys.FolderExists(newFolderPath) Then
'     Set  newFolder = fileSys.CreateFolder(newFolderPath)
'     MsgBox("Carpeta creada en " &newFolder)
' Else
'     MsgBox("Se encontro el directorio " &newFolderPath &" en el sistema.")
' End If
' -------------------------------------------------------------------------------------------

' c:\users\%USERNAME%

' res jq in web
' https://objects.githubusercontent.com/github-production-release-asset-2e65be/5101141/6387d980-de1f-11e8-9108-d55ca3d2be22?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220501%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220501T135253Z&X-Amz-Expires=300&X-Amz-Signature=d58fb8073a75ac652c52cca3414e535602f6b890bb20b446675ef279a10c27f0&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=5101141&response-content-disposition=attachment%3B%20filename%3Djq-win64.exe&response-content-type=application%2Foctet-stream

' curr path
' C:\Users\manue\Programacion\github\utils-jq\setup-jq-windows.vbs
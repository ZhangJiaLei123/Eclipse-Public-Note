VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisDocument"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub SelectAllTables()

Dim tempTables As Table

Application.ScreenUpdating = False

If ActiveDocument.ProtectionType = wdAllowOnlyFormFields Then



Exit Sub

End If

ActiveDocument.DeleteAllEditableRanges wdEditorEveryone

For Each tempTable In ActiveDocument.Tables

tempTable.Range.Editors.Add wdEditorEveryone

Next

ActiveDocument.SelectAllEditableRanges wdEditorEveryone

ActiveDocument.DeleteAllEditableRanges wdEditorEveryone

Application.ScreenUpdating = True







End Sub

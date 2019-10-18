Attribute VB_Name = "NewMacros"
Rem:选中所有表格
Sub SelectAllTables()
Attribute SelectAllTables.VB_Description = "选中所有表格"
Attribute SelectAllTables.VB_ProcData.VB_Invoke_Func = "Normal.NewMacros.SelectAllTables"

    Dim tempTables As Table
    
    Application.ScreenUpdating = False
    
    If ActiveDocument.ProtectionType = wdAllowOnlyFormFields Then
    
    MsgBox "受保护文档，操纵失败"
    
    Exit Sub
    
    End If
    
    ActiveDocument.DeleteAllEditableRanges wdEditorEveryone
    
    For Each tempTable In ActiveDocument.Tables
    
    tempTable.Range.Editors.add wdEditorEveryone
    
    Next
    
    ActiveDocument.SelectAllEditableRanges wdEditorEveryone
    
    ActiveDocument.DeleteAllEditableRanges wdEditorEveryone
    
    Application.ScreenUpdating = True
    
    Rem: 设置为单倍行距
    Selection.ParagraphFormat.LineSpacing = LinesToPoints(1)

    Rem:MsgBox "操作成功"

End Sub

Sub setBordersStyle()

Rem: 设置实心边框
With Options
    .DefaultBorderLineStyle = wdLineStyleSingle
    .DefaultBorderLineWidth = wdLineWidth050pt
    .DefaultBorderColor = wdColorAutomatic
End With


End Sub

Rem: 给选中的表格添加全包边框
Sub addBordersWithSelectTable()
Attribute addBordersWithSelectTable.VB_ProcData.VB_Invoke_Func = "Normal.NewMacros.宏3"

   With Selection.Borders(wdBorderTop)
        .LineStyle = Options.DefaultBorderLineStyle
        .LineWidth = Options.DefaultBorderLineWidth
        .Color = Options.DefaultBorderColor
    End With
    With Selection.Borders(wdBorderLeft)
        .LineStyle = Options.DefaultBorderLineStyle
        .LineWidth = Options.DefaultBorderLineWidth
        .Color = Options.DefaultBorderColor
    End With
    With Selection.Borders(wdBorderBottom)
        .LineStyle = Options.DefaultBorderLineStyle
        .LineWidth = Options.DefaultBorderLineWidth
        .Color = Options.DefaultBorderColor
    End With
    With Selection.Borders(wdBorderRight)
        .LineStyle = Options.DefaultBorderLineStyle
        .LineWidth = Options.DefaultBorderLineWidth
        .Color = Options.DefaultBorderColor
    End With
    With Selection.Borders(wdBorderHorizontal)
        .LineStyle = Options.DefaultBorderLineStyle
        .LineWidth = Options.DefaultBorderLineWidth
        .Color = Options.DefaultBorderColor
    End With
    With Selection.Borders(wdBorderVertical)
        .LineStyle = Options.DefaultBorderLineStyle
        .LineWidth = Options.DefaultBorderLineWidth
        .Color = Options.DefaultBorderColor
    End With

End Sub

Rem:遍历设置表格属性 ：表格宽度为百分比 100
Sub m_SetAllTablesWidth()
    
    For Each tempTable In ActiveDocument.Tables
    
    tempTable.PreferredWidthType = wdPreferredWidthPercent
    
    tempTable.PreferredWidth = 100
    
    Next
    
    Rem:ActiveDocument.Tables(1).
    
    MsgBox "操作成功"

End Sub

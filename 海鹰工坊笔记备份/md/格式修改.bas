Attribute VB_Name = "NewMacros"
Rem:ѡ�����б��
Sub SelectAllTables()
Attribute SelectAllTables.VB_Description = "ѡ�����б��"
Attribute SelectAllTables.VB_ProcData.VB_Invoke_Func = "Normal.NewMacros.SelectAllTables"

    Dim tempTables As Table
    
    Application.ScreenUpdating = False
    
    If ActiveDocument.ProtectionType = wdAllowOnlyFormFields Then
    
    MsgBox "�ܱ����ĵ�������ʧ��"
    
    Exit Sub
    
    End If
    
    ActiveDocument.DeleteAllEditableRanges wdEditorEveryone
    
    For Each tempTable In ActiveDocument.Tables
    
    tempTable.Range.Editors.add wdEditorEveryone
    
    Next
    
    ActiveDocument.SelectAllEditableRanges wdEditorEveryone
    
    ActiveDocument.DeleteAllEditableRanges wdEditorEveryone
    
    Application.ScreenUpdating = True
    
    Rem: ����Ϊ�����о�
    Selection.ParagraphFormat.LineSpacing = LinesToPoints(1)

    Rem:MsgBox "�����ɹ�"

End Sub

Sub setBordersStyle()

Rem: ����ʵ�ı߿�
With Options
    .DefaultBorderLineStyle = wdLineStyleSingle
    .DefaultBorderLineWidth = wdLineWidth050pt
    .DefaultBorderColor = wdColorAutomatic
End With


End Sub

Rem: ��ѡ�еı�����ȫ���߿�
Sub addBordersWithSelectTable()
Attribute addBordersWithSelectTable.VB_ProcData.VB_Invoke_Func = "Normal.NewMacros.��3"

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

Rem:�������ñ������ �������Ϊ�ٷֱ� 100
Sub m_SetAllTablesWidth()
    
    For Each tempTable In ActiveDocument.Tables
    
    tempTable.PreferredWidthType = wdPreferredWidthPercent
    
    tempTable.PreferredWidth = 100
    
    Next
    
    Rem:ActiveDocument.Tables(1).
    
    MsgBox "�����ɹ�"

End Sub

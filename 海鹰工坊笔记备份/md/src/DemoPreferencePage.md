
```java {.line-numbers}
// 组件key值，首选项数据以key-Value保存，所以key值不能一样
public class PreferenceConstants {

	public static final String P_PATH = "pathPreference";

	public static final String P_BOOLEAN = "booleanPreference";

	public static final String P_CHOICE = "choicePreference";

	public static final String P_STRING = "stringPreference";
	
}

// ui实现
public class PreferencePage
	extends FieldEditorPreferencePage
	implements IWorkbenchPreferencePage  {

	public PreferencePage() {
		super(GRID);

		setPreferenceStore(Activator.getDefault().getPreferenceStore());
		setDescription("A demonstration of a preference page implementation");
	}

	public void createFieldEditors() {
		addField(new DirectoryFieldEditor(PreferenceConstants.P_PATH,
				"&Directory preference:", getFieldEditorParent()));
		addField(
			new BooleanFieldEditor(
				PreferenceConstants.P_BOOLEAN,
				"&An example of a boolean preference",
				getFieldEditorParent()));

		addField(new RadioGroupFieldEditor(
				PreferenceConstants.P_CHOICE,
			"An example of a multiple-choice preference",
			1,
			new String[][] { { "&Choice 1", "choice1" }, {
				"C&hoice 2", "choice2" }
		}, getFieldEditorParent()));
		addField(
			new StringFieldEditor(PreferenceConstants.P_STRING, "A &text preference:", getFieldEditorParent()));
	}


	public void init(IWorkbench workbench) {
	}

}
```
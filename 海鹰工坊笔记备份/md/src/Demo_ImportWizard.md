```java {.line-numbers}

import org.eclipse.jface.dialogs.IDialogSettings;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.wizard.Wizard;
import org.eclipse.ui.IImportWizard;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.internal.ide.IDEWorkbenchPlugin;
import org.eclipse.ui.internal.wizards.datatransfer.DataTransferMessages;
import org.eclipse.ui.internal.wizards.datatransfer.WizardProjectsImportPage;

@SuppressWarnings("restriction")
public class ImportWizard extends Wizard implements IImportWizard {

	private static final String EXTERNAL_PROJECT_SECTION = "ExternalProjectImportWizard";
	private WizardProjectsImportPage mainPage;
	private IStructuredSelection currentSelection = null;
	private String initialPath = null;

	public ImportWizard() {
		this(null);
	}

	/**
	 * Constructor for ExternalProjectImportWizard.
	 *
	 * @param initialPath
	 *            Default path for wizard to import
	 * @since 3.5
	 */
	public ImportWizard(String initialPath) {
		super();
		this.initialPath = initialPath;
		setNeedsProgressMonitor(true);
		IDialogSettings workbenchSettings = IDEWorkbenchPlugin.getDefault().getDialogSettings();

		IDialogSettings wizardSettings = workbenchSettings.getSection(EXTERNAL_PROJECT_SECTION);
		if (wizardSettings == null) {
			wizardSettings = workbenchSettings.addNewSection(EXTERNAL_PROJECT_SECTION);
		}
		setDialogSettings(wizardSettings);
	}

	@Override
	public void addPages() {
		super.addPages();
		mainPage = new WizardProjectsImportPage(
			"wizardExternalProjectsPage", initialPath, currentSelection); //$NON-NLS-1$
		addPage(mainPage);
	}

	@Override
	public void init(IWorkbench workbench, IStructuredSelection selection) {
		
		setWindowTitle(DataTransferMessages.DataTransfer_importTitle);
		setDefaultPageImageDescriptor(IDEWorkbenchPlugin
			.getIDEImageDescriptor("wizban/importproj_wiz.png")); //$NON-NLS-1$
		this.currentSelection = selection;

	}

	@Override
	public boolean performFinish() {
		return mainPage.createProjects();
	}

	@Override
	public boolean performCancel() {
		mainPage.performCancel();
		return true;
	}

}

```
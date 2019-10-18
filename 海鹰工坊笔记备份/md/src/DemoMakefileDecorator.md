
```java {.line-numbers}

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IFolder;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.runtime.Platform;
import org.eclipse.jface.preference.JFacePreferences;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.resource.JFaceResources;
import org.eclipse.jface.viewers.IDecoration;
import org.eclipse.jface.viewers.ILabelProviderListener;
import org.eclipse.jface.viewers.ILightweightLabelDecorator;

import com.acce.hyide.project.file.Activator;


public class MakefileDecorator implements ILightweightLabelDecorator {
	public static final String MAKEFILE_REMOVED = "icons/informationcenter.png"; //$NON-NLS-1$
	public static ImageDescriptor MAKEFILE_REMOVED_IMAGE;
	// 初始化ImageDescriptor
	static {
		MAKEFILE_REMOVED_IMAGE = ImageDescriptor
			.createFromURL(Platform.getBundle(Activator.PLUGIN_ID).getEntry(MAKEFILE_REMOVED));
	}

	@Override
	public void addListener(ILabelProviderListener listener) {
		// TODO 自动生成的方法存根

	}

	@Override
	public void dispose() {
		// TODO 自动生成的方法存根

	}

	@Override
	public boolean isLabelProperty(Object element, String property) {
		// TODO 自动生成的方法存根
		return false;
	}

	@Override
	public void removeListener(ILabelProviderListener listener) {
		// TODO 自动生成的方法存根

	}

	@Override
	public void decorate(Object element, IDecoration decoration) {
		IResource resource;
		String projectLocation;	// 项目的绝对路径
		String elementPath;		// 被点击文件的相对路径

		if (element instanceof IFile || element instanceof IFolder) {
			resource = (IResource) element;
			projectLocation = resource.getProject().getLocation().toString();
			elementPath = absolutePathToRelativePath(resource.getLocation().toString(),
					projectLocation);
		} else {
			return;
		}

		// 文件（文件夹左下角）显示x图标；
			decoration.addOverlay(MAKEFILE_REMOVED_IMAGE);
		// 字体变灰色
			decoration.setForegroundColor(JFaceResources.getColorRegistry()
				.get(JFacePreferences.QUALIFIER_COLOR));

	}

	/*
	 * 将绝对路径转为相对路径，不保留第一个"/"，通过调用subString（）方法，去掉第一个“/”
	 * example
	 * absolutePath="E:/sylixos/plugin_workspace/runtime-EclipseApplication/app_demo/functions/f1.c";
	 * projectLocation="E:/sylixos/plugin_workspace/runtime-EclipseApplication/app_demo";
	 * return "functions/f1.c";
	 */
	public static String absolutePathToRelativePath(String absolutePath, String projectLocation) {
		String result = absoluteToRelative(absolutePath, projectLocation);
		if (result.equals("")) {
			return "";
		} else {
			return result.substring(1);
		}
	}

	/*
	 * 将绝对路径转为相对路径，保留第一位的“/”
	 */
	public static String absoluteToRelative(String file, String parentFile) {
		return absoluteToRelative(new File(file), new File(parentFile));
	}

	/*
	 * 将绝对路径转为相对路径，保留第一位的“/”
	 */
	public static String absoluteToRelative(File file, File parentFile) {
		if (file.equals(parentFile)) {
			return "";	//$NON-NLS-1$
		} else {
			return absoluteToRelative(file.getParentFile(), parentFile) + "/" + file.getName();
		}
	}

}

```
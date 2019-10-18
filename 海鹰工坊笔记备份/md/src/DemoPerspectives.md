```java {.line-numbers}
package com.xxx;

import org.eclipse.ui.IFolderLayout;
import org.eclipse.ui.IPageLayout;
import org.eclipse.ui.IPerspectiveFactory;
import org.eclipse.ui.wizards.newresource.BasicNewFileResourceWizard;
import org.eclipse.ui.wizards.newresource.BasicNewFolderResourceWizard;

public class DemoPerspectives implements IPerspectiveFactory {

	public Perspectives() {
		super();
	}

	@Override
	public void createInitialLayout(IPageLayout layout) {
		defineLayout(layout);	// 增加透视图的布局和视图
	//	defineActions(layout);	// 增加透视图的动作和快捷
	}

	// 增加透视图的布局和视图
	public void defineLayout(IPageLayout paramIPageLayout) {
        /* paramIPageLayout 是方位布局，即上中下左右*/

		// 设置设置编辑器区域可见不可见
		paramIPageLayout.setEditorAreaVisible(false);
		// 获取编辑器区域
		String strEditorArea = paramIPageLayout.getEditorArea();

		/* 子view 布局 */
		// 左边 区域 布局
		IFolderLayout leftFolderLayout = paramIPageLayout.createFolder("leftFolder", 1, 0.18F,
			strEditorArea); // left
		// 添加子view的节点 id (这里是此插件节点的布局，而不是class的类名)
		paramIPageLayout.addView("com.acce.hyide.product.gadget.navigator.view", 3, 0.65F,
			"leftFolder"); // left-bottom

		// 底部 区域布局
		IFolderLayout bottomIFolderLayout = paramIPageLayout.createFolder("bottomFolder", 4, 0.75F,
			strEditorArea); // bottom
		// 添加子view的节点 id
		bottomIFolderLayout.addView("com.acce.hyide.product.gadget.terminal.view");
		bottomIFolderLayout.addView("com.acce.hyide.product.gadget.test.view");

		// 中间区域 布局
		IFolderLayout middleIFolderLayout = paramIPageLayout.createFolder("MiddleFolder", 2, 0.75F,
			strEditorArea); // Middle
		// 添加子view的节点 id
		middleIFolderLayout.addView("com.acce.hyide.product.gadget.information.view");
		middleIFolderLayout.addView("com.acce.hyide.product.gadget.ftp.view");

	}

	// 增加透视图的动作和快捷
	public void defineActions(IPageLayout layout) {

	}

}

```
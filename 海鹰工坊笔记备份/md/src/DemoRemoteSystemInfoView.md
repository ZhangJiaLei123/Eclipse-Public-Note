
```java {.line-numbers}
package com.xxx;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.viewers.TableViewer;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CTabFolder;
import org.eclipse.swt.custom.CTabItem;
import org.eclipse.swt.custom.SashForm;
import org.eclipse.swt.custom.StyleRange;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.events.MenuEvent;
import org.eclipse.swt.events.MenuListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.DirectoryDialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Group;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableColumn;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.widgets.Tree;
import org.eclipse.swt.widgets.TreeItem;
import org.eclipse.ui.part.ViewPart;

public class RemoteSystemInfoView2 extends ViewPart {
	// 分页标签的主页面
	public CTabFolder tabFolder;
	// 页面子标签项
	public CTabItem tbtmNewItem;
	public CTabItem tbtmNewItem_1;
	// 子标签视图
	public TableViewer tableViewer;
	public TableViewer tableViewer_1;
	public TableViewer tableViewer_2;
	// 标签组件
	// 组件 ： 列表
	public Table table;
	public Table table_1;
	public Table table_2;
	// 组件 ： 文本框
	public Text text;
	
	// 布局 ：Group，可作为一个容器或页面，添加其他组件、布局等
	public Group group;
	// 组件 ： 下拉框
	public Combo combo;
	// 组件 ： 按键
	public Button button;
	// 组件,和 Text 差不多，和设置字体和颜色
	public StyledText styledText;
	
	// 树状图
	public Tree tree;
	private TreeItem treeItem;
	private TreeItem treeItem2;
	private MenuItem menuItem1;
	private MenuItem menuItem2;
	
	// 简单消息对话框
	MessageBox messagebox;

	
	@Override
	public void createPartControl(Composite parent) {
		// 容器初始化 (所有Tab页面都在此容器下)
		tabFolder = new CTabFolder(parent, SWT.BORDER);
		tabFolder.setSimple(false);
	
		// 添加 UI
		addTableView_1();
		addTableView_2();
		addGroupView_3(parent);
		addTreeView_4(parent);
	
		// 添加右键菜单
		addMenu(table);
	
	}
	// 添加标签页1 方式1
	// 布局1
	void addTableView_1()
	{
		// 标签1
		tbtmNewItem = new CTabItem(tabFolder, SWT.NONE);
		//tbtmNewItem.setImage(DeviceUtil.getImage("icons/Memory.png")); //$NON-NLS-1$
		tbtmNewItem.setText("标签1");
	
		// 标签的容器，在此容器内添加组件
		SashForm sashForm = new SashForm(tabFolder, SWT.VERTICAL);
		tbtmNewItem.setControl(sashForm);
	
		// (列表视图)标签页面的组件
		tableViewer = new TableViewer(sashForm, SWT.BORDER | SWT.FULL_SELECTION);
		table = tableViewer.getTable();
		table.setHeaderVisible(true);
		table.setLinesVisible(true);
		// 添加列表项的监听
		table.addListener(SWT.MouseDoubleClick, new Listener() {
			@Override
			public void handleEvent(org.eclipse.swt.widgets.Event event) {
				TableItem tableitm;
				try {
					tableitm = table.getSelection()[0];// 获取选中的行
					putMsg("" + tableitm.getText());
				} catch (Exception e) {
					return;
				}
				File fitem = (File) tableitm.getData();
				if (fitem.toString().equals("..")) { //$NON-NLS-1$
					File file = new File(strlocpath);
					file = file.getParentFile();
					listLocalFiles(file, table);
					return;
				}
				if (fitem.isDirectory()) {
					try {
						listLocalFiles(fitem, table);
					} catch (Exception e) {
						// 遇到无权限的文件夹则返回他上级目录
						MessageDialog.openInformation(Display.getCurrent().getActiveShell(),
							"title",
							"无权限的文件夹");
						File file = fitem.getParentFile();
						listLocalFiles(file, table);
						return;
					}
				} else {
					//if (!rimplementation.isListener) {
					//	return;
					//}
					//logMessage(Messages.RemoteSystemFtpImplementation_Startuploading);
					//rimplementation.Upload(filelist);
				}
			}
		});
	
		tableViewer_2 = new TableViewer(sashForm, SWT.BORDER | SWT.FULL_SELECTION);
		table_2 = tableViewer_2.getTable();
		table_2.setToolTipText("table_2");
		table_2.setHeaderVisible(false);
		table_2.setLinesVisible(true);
		// (文本框视图)标签页面的组件
		text = new Text(sashForm, SWT.BORDER | SWT.WRAP | SWT.V_SCROLL | SWT.READ_ONLY);
		//text.setFont(DeviceUtil.getFont());
		text.setBackground(Display.getCurrent().getSystemColor(SWT.COLOR_WHITE));
		text.setEditable(true);
	
		// sashForm 的权重
		sashForm.setWeights(new int[] { 161, 170, 103 });
	}
	// 添加标签页2 方式2
	// 布局2
	void addTableView_2()
	{
		/* 方式2 */
		Composite compsoite = new Composite(tabFolder, SWT.NONE);
		tbtmNewItem_1 = new CTabItem(tabFolder, SWT.NONE);
		//tbtmNewItem_1.setImage(DeviceUtil.getImage("icons/Process.png"));
		tbtmNewItem_1.setText("标签2");
		// 组件1
		tableViewer_1 = new TableViewer(compsoite, SWT.BORDER | SWT.FULL_SELECTION);
		table_1 = tableViewer_1.getTable();
		// 组件布局方式
		GridData gd_tablea = new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1);
		gd_tablea.heightHint = 220;
		// 添加布局到 table
		table_1.setLayoutData(gd_tablea);
		table_1.setHeaderVisible(true);
		table_1.setLinesVisible(true);
		// 添加UI内容到 CTabItem
		tbtmNewItem_1.setControl(compsoite);
		GridLayout layout = new GridLayout();
		layout.marginWidth = 0;
		layout.marginHeight = 0;
		// 添加布局到 Composite
		compsoite.setLayout(layout);
	
	}
	// 布局3 另起一组
	void addGroupView_3(Composite parent)
	{
		group = new Group(parent, SWT.NULL);
		group.setText("Group 布局");
		GridLayout gridLayout = new GridLayout(2, true);
		gridLayout.marginHeight = 0;
		group.setLayout(gridLayout);
		group.setLayoutData(new GridData(GridData.FILL_HORIZONTAL));
	
		/* 下拉框 */
		combo = new Combo(group, SWT.FLAT);
		combo.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false, 1, 1));
		combo.setText("默认数据");
		combo.add("下拉数据1", 0);//添加到最前
		combo.add("下拉数据2", 0);//不会覆盖
		// String[] data = combo.getItems()获得所有项
		// 为该下拉框选中事件
		combo.addSelectionListener(new SelectionAdapter() {
			public void widgetSelected(SelectionEvent e) {
				String strcomnocontent = combo.getText().trim();// 选择的数据
				MessageDialog
					.openInformation(
						Display.getCurrent().getActiveShell(),
						"标题",
						"内容:" + strcomnocontent);
			}
		});
	
		/* 按键 */
		button = new Button(group, SWT.PUSH);
		//button.setImage(DeviceUtil.getImage("icons/up.png"));
		button.addSelectionListener(new SelectionAdapter() {
		@Override
		public void widgetSelected(SelectionEvent e) {
			// 打开文件资源管理器
			DirectoryDialog dialog = new DirectoryDialog(parent.getShell());
			// 返回选中的文件路径
			String strpath = dialog.open();
			if (strpath == null) {
				return;
			}
			File file = new File(strpath);
			if (file.getParentFile() == null) {
				//buttonUpLocalDir.setEnabled(false);
			} else {
				listLocalFiles(file, table);
				putStyledText(file.toPath().toString());
			}
		}
		});
		//
		styledText = new StyledText(group, SWT.BORDER | SWT.V_SCROLL);
		styledText.setSize(200, 400);
		styledText.setEditable(false);
	}
	
	// 给tab页面添加右键菜单
	// 添加 Tree 视图
	void addTreeView_4(Composite parent)
	{
		this.tree = new Tree(parent, SWT.NONE);
		// 添加双点击事件
		this.tree.addSelectionListener(new SelectionListener() {
			// 双击时
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
				putMsg("TreeView点击响应"  +  tree.getSelection()[0].getData().toString() );// 获取选中信息
			}
	
			// 获得(单击)焦点时
			@Override
			public void widgetSelected(SelectionEvent e) {
				//putMsg("TreeView点击响应widgetSelected");
			}
		});
	
		// 添加右键菜单
		addMenu(tree);
	
		treeItem = new TreeItem(tree, SWT.None);
	
		treeItem.setText("subItem");
		treeItem.setData("subItemData");
		//treeItem.setImage(DeviceUtil.getImage("icons/connect.png")); //$NON-NLS-1$
	
		treeItem2 = new TreeItem(treeItem, SWT.None);
		treeItem2.setText("subItem2");
		treeItem2.setData("subItemData2");
		//treeItem2.setImage(DeviceUtil.getImage("icons/connect.png")); //$NON-NLS-1$
	
	}
	
	// 添加右键菜单 给Table、Tree等继承Control的类都行
	private void addMenu(Control table) {
		// 添加右键菜单
		Menu memorymenu = new Menu(table);
	
		// 添加操作项
		MenuItem memoryItem = new MenuItem(memorymenu, SWT.PUSH);
		// 操作项名称
		memoryItem.setText("操作项1");
		// 添加操作响应监听
		memoryItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread memorymenu = new Thread() {
					public void run() {
						//操作响应
						// 列表头
						String[] strtitle = {"strtitle1","strtitle2"};
						// 列表数据行
						String[][] strcontent = {{"strcontent1", "strcontent2"},{"strcontent3", "strcontent4"}};
						setTableData_table(strtitle, strcontent);
					}
				};
				memorymenu.setName("memorymenu");
				memorymenu.start();
			}
		});
	
		// 创建一个分割线
		MenuItem separator1 = new MenuItem(memorymenu, SWT.SEPARATOR);
	
		// 添加其他操作项
		MenuItem connectItem = new MenuItem(memorymenu, SWT.PUSH);
		connectItem.setText("操作项2");
		connectItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
	
			}
		});
	
		// 菜单监听
		memorymenu.addMenuListener(new MenuListener() {
			// 菜单显示前
			@Override
			public void menuShown(MenuEvent e) {
				// 设置操作项不可显示
				memoryItem.setEnabled(true);
				connectItem.setEnabled(false);
				// 这里可以设置规则，控制操作项的显示逻辑
				// ***
			}
	
			// 菜单隐藏后
			@Override
			public void menuHidden(MenuEvent e) {
			}
		});
		table.setMenu(memorymenu);
	
		/* MenuItem 可重复添加 */
	}
	
	/**
	 * StyledText 显示数据
	 * @param message
	 */
	public void putStyledText(String message) {
		styledText.getDisplay().asyncExec(new Runnable() {
			@Override
			public void run() {
				StyleRange styleRange1 = new StyleRange();
				styleRange1.start = styledText.getCharCount();
				styleRange1.length = message.length();
				styleRange1.fontStyle = SWT.BOLD;
				Shell shell = new Shell();
				styleRange1.foreground = shell.getDisplay().getSystemColor(SWT.COLOR_RED);// Display.getCurrent().getActiveShell()
				styledText.append(message + "\r\n"); //$NON-NLS-1$
				styledText.setStyleRange(styleRange1);
				styledText.setSelection(styledText.getCharCount());
			}
		});
	}
	
	public static long kb = 1024;
	public static long mb = kb * 1024;
	public static long gb = mb * 1024;
	public static DecimalFormat df = new DecimalFormat("#,###"); //$NON-NLS-1$
	String strlocpath = "";// 当前地址
	/*
	 * 在table显示 本地路径 数据
	 */
	private void listLocalFiles(File selDisk, Table table) {
		if (selDisk == null || selDisk.isFile()) {
			return;
		}
		strlocpath = selDisk.toString();
		combo.setText(selDisk.toString());// 当前地址
		table.removeAll();// 移除旧数据
		File[] listFiles = selDisk.listFiles(); // 获取磁盘文件列表
		List<File> fileList = new ArrayList<File>();
		for (File f : listFiles) {
			fileList.add(f);
		}
		Collections.sort(fileList, new Comparator<File>() {
			@Override
			public int compare(File o1, File o2) {
				if (o1.isDirectory() && o2.isFile()) {
					return -1;
				}
				if (o1.isFile() && o2.isDirectory()) {
					return 1;
				}
				return o1.getName().compareTo(o2.getName());
			}
		});
		// 上层目录
		if (selDisk.getParentFile() != null) {
	
			File file = new File(".."); //$NON-NLS-1$
			TableItem itema = new TableItem(table, SWT.NONE);
			//itema.setImage(DeviceUtil.getImage("icons/newfolder.png")); //$NON-NLS-1$
			itema.setText(new String[] { "..", "", "" }); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
			itema.setData(file);
		} else {
	
		}
	
		// 遍历磁盘根文件夹的内容，添加到表格中
		for (File file : fileList) {
			TableItem itemsa = new TableItem(table, SWT.NONE);
			String length = ""; // 获取文件大小 //$NON-NLS-1$
			long lsize = file.length();
			if (lsize >= gb) {
				length = String.format("%.1fGB", (float) lsize / gb) + " (" + df.format(lsize) + ")"; //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
			} else if (lsize >= mb) {
				float f = (float) lsize / mb;
				length = String.format(f > 100 ? "%.0fMB" : "%.1fMB", f) + " (" + df.format(lsize) + ")"; //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
			} else if (lsize >= kb) {
				float f = (float) lsize / kb;
				length = String.format(f > 100 ? "%.0fKB" : "%.1fKB", f) + " (" + df.format(lsize) + ")"; //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
			} else {
				length = String.format("%dB", lsize); //$NON-NLS-1$
			}
			if (file.isDirectory()) { // 显示文件夹标志
				length = ""; //$NON-NLS-1$
				//itemsa.setImage(DeviceUtil.getIcon(file));
			} else {
				//itemsa.setImage(DeviceUtil.getIcon(file));
			}
			// 获取文件的最后修改日期
			//SimpleDateFormat myFmt = new SimpleDateFormat(
				//ConstantClass.RemoteSystemFtpView_DateFormat);
			//String modifDate = myFmt.format(new Date(file.lastModified()));
			itemsa.setText(new String[] { file.getName(), length, "日期" });
			itemsa.setData(file);
		}
	}
	
	// 添加 数据奥 table 列表
	/*添加数据到 tab 列表中*/
	// 给table 添加数据
	public void setTableData_table(String[] strtitle, String[][] strcontent) {
		setTableData(table, tableViewer, strcontent, strtitle);
	}
	
	/**
	 * 给table添加信息公共方法
	 *
	 * @param table
	 * @param tableViewer
	 */
	void setTableData(Table table, TableViewer tableViewer, String[][] strcontent,
		String[] strtitle) {
		Display.getDefault().syncExec(new Runnable() {
			@Override
			public void run() {
				// 记录table当前位置
				int iscrollbarlocation = table.getTopIndex();
				int iSelection = table.getSelectionIndex();
				// 清空table内容
				table.removeAll();
	
				// 重新加载table内容
				// if(tableViewer.getTable().getColumnCount()==0){
				TableColumn[] columns = table.getColumns(); // 清除表格原有表头
				for (TableColumn tc : columns) {
					tc.dispose();
				}
				// 添加表头
				for (int i = 0; i < strtitle.length; i++) {
					TableColumn TableContent = new TableColumn(table, SWT.NONE, i);
					TableContent.setWidth(140);
					TableContent.setText(strtitle[i]);
				}
				// }
	
				for (int j = 0; j < strcontent.length; j++) {
					// 添加数据
					TableItem TableTitle = new TableItem(table, SWT.NONE);
					String strcont[] = new String[strcontent[j].length];
					for (int k = 0; k < strcontent[j].length; k++) {
						strcont[k] = strcontent[j][k];
					}
					TableTitle.setText(strcont);
				}
				// 设置当前选中信息位置
				table.setTopIndex(iscrollbarlocation);
			}
		});
	}
	
	@Override
	public void setFocus() {
		// TODO Auto-generated method stub
	}
	void putMsg(String msg)
	{
		MessageDialog
		.openInformation(
			Display.getCurrent().getActiveShell(),
			"标题",
			msg);
	}
	
}
```
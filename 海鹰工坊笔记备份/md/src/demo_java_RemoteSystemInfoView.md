
``` java {.line-numbers}

/***************************************************************************************************
 *                                      中国航天科工集团三院三部
 *                                          海鹰集成开发环境
 * 文     件      名: RemoteSystemInfoView.java
 * 创     建      人:
 * 文件创建日期: 2018 年  1 月 12 日
 * 描               述:
 * 文件修改记录：
 **************************************************************************************************/
package com.acce.hyide.product.gadget.infoview;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IFolder;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.viewers.ISelectionChangedListener;
import org.eclipse.jface.viewers.SelectionChangedEvent;
import org.eclipse.jface.viewers.TableViewer;
import org.eclipse.jface.viewers.Viewer;
import org.eclipse.jface.viewers.ViewerFilter;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CTabFolder;
import org.eclipse.swt.custom.CTabItem;
import org.eclipse.swt.custom.SashForm;
import org.eclipse.swt.events.MenuEvent;
import org.eclipse.swt.events.MenuListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableColumn;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.dialogs.ElementTreeSelectionDialog;
import org.eclipse.ui.dialogs.ISelectionStatusValidator;
import org.eclipse.ui.model.WorkbenchContentProvider;
import org.eclipse.ui.model.WorkbenchLabelProvider;
import org.eclipse.ui.part.ViewPart;
import org.eclipse.ui.views.navigator.ResourceComparator;

import com.acce.hyide.product.util.CommonUtil;
import com.acce.hyide.product.util.ProjectCfg;

import com.acce.hyide.product.gadget.Activator;
import com.acce.hyide.product.gadget.Messages;
import com.acce.hyide.product.gadget.util.AttachDebugAction;
import com.acce.hyide.product.gadget.util.DeviceUtil;

public class RemoteSystemInfoView extends ViewPart {
	public CTabFolder tabFolder;
	public CTabItem tbtmNewItem;
	public CTabItem tbtmNewItem_1;
	public CTabItem tbtmNewItem_2;
	public CTabItem tbtmNewItem_test;
	public CTabItem tbtmNewItem_stackusage;
	public CTabItem tbtmNewItem_tp;
	public CTabItem tbtmNewItem_ints;
	public Table table;
	public Table table_1;
	public Table table_2;
	public Table table_3;
	public Table table_test;
	public Table table_stackusage;
	public Table table_tp;
	public Table table_ints_nesting;
	public Table table_ints_vector;
	public Text text;
	public TableViewer tableViewer;
	public TableViewer tableViewer_1;
	public TableViewer tableViewer_2;
	public TableViewer tableViewer_3;
	public TableViewer tableViewer_stackusage;
	public TableViewer tableViewer_tp;
	public TableViewer tableViewer_ints_nesting;
	public TableViewer tableViewer_ints_vector;
	public int TPSelection = -1;
	RemoteSystemDataInfo rDataInfo;
	private String strpttid = ""; //$NON-NLS-1$//保存死锁总tid
	TableItem itemi = null; // 保存临时被替换颜色的TableItem
	Color col = new Color(Display.getDefault(), 255, 255, 0);
	Color Red = new Color(Display.getDefault(), 255, 0, 0);
	Color Lime = new Color(Display.getDefault(), 0, 255, 0);
	Color coldefault;

	public RemoteSystemInfoView() {
		rDataInfo = new RemoteSystemDataInfo();
	}

	@Override
	public void createPartControl(Composite parent) {

		tabFolder = new CTabFolder(parent, SWT.BORDER);
		tabFolder.setSimple(false);

		tbtmNewItem = new CTabItem(tabFolder, SWT.NONE);
		tbtmNewItem.setImage(DeviceUtil.getImage("icons/Memory.png")); //$NON-NLS-1$
		tbtmNewItem.setText(Messages.RemoteSystemInofView_Memory);
		SashForm sashForm = new SashForm(tabFolder, SWT.VERTICAL);
		tbtmNewItem.setControl(sashForm);
		tableViewer = new TableViewer(sashForm, SWT.BORDER | SWT.FULL_SELECTION);
		table = tableViewer.getTable();
		table.setHeaderVisible(true);
		table.setLinesVisible(true);
		tableViewer_3 = new TableViewer(sashForm, SWT.BORDER | SWT.FULL_SELECTION);
		table_3 = tableViewer_3.getTable();
		table_3.setToolTipText("table_3");
		table_3.setHeaderVisible(true);
		table_3.setLinesVisible(true);
		// 添加一个文本框
		text = new Text(sashForm, SWT.BORDER | SWT.WRAP | SWT.V_SCROLL | SWT.READ_ONLY);
		text.setFont(DeviceUtil.getFont());
		text.setBackground(Display.getCurrent().getSystemColor(SWT.COLOR_WHITE));
		text.setEditable(true);
		
		sashForm.setWeights(new int[] { 161, 170, 103 });

		/* ps */
		Composite compsoite2 = new Composite(tabFolder, SWT.NONE);
		tbtmNewItem_1 = new CTabItem(tabFolder, SWT.NONE);
		tbtmNewItem_1.setImage(DeviceUtil.getImage("icons/Process.png")); //$NON-NLS-1$
		tbtmNewItem_1.setText(Messages.RemoteSystemInofView_Process);
		tableViewer_1 = new TableViewer(compsoite2, SWT.BORDER | SWT.FULL_SELECTION);
		table_1 = tableViewer_1.getTable();
		GridData gd_tablea = new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1);
		gd_tablea.heightHint = 220;
		table_1.setLayoutData(gd_tablea);
		table_1.setHeaderVisible(true);
		table_1.setLinesVisible(true);
		tbtmNewItem_1.setControl(compsoite2);
		GridLayout layout2 = new GridLayout();
		layout2.marginWidth = 0;
		layout2.marginHeight = 0;
		compsoite2.setLayout(layout2);

		/* ts */
		Composite compsoite3 = new Composite(tabFolder, SWT.NONE);
		tbtmNewItem_2 = new CTabItem(tabFolder, SWT.NONE);
		tbtmNewItem_2.setImage(DeviceUtil.getImage("icons/Thread12.png")); //$NON-NLS-1$
		tbtmNewItem_2.setText(Messages.RemoteSystemInofView_Thread);
		tableViewer_2 = new TableViewer(compsoite3, SWT.BORDER | SWT.FULL_SELECTION);
		table_2 = tableViewer_2.getTable();
		GridData gd_tablea1 = new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1);
		gd_tablea1.heightHint = 220;
		table_2.setLayoutData(gd_tablea1);
		table_2.setHeaderVisible(true);
		table_2.setLinesVisible(true);
		tbtmNewItem_2.setControl(compsoite3);
		GridLayout layout3 = new GridLayout();
		layout3.marginWidth = 0;
		layout3.marginHeight = 0;
		compsoite3.setLayout(layout3);

		/* test */
		Composite compsoite_test = new Composite(tabFolder, SWT.NONE);
		tbtmNewItem_2 = new CTabItem(tabFolder, SWT.NONE);
		tbtmNewItem_2.setImage(DeviceUtil.getImage("icons/Thread12.png")); //$NON-NLS-1$
		tbtmNewItem_2.setText("测试");
		tableViewer_2 = new TableViewer(compsoite_test, SWT.BORDER | SWT.FULL_SELECTION);
		table_test = tableViewer_2.getTable();
		GridData gd_tablea_test = new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1);
		gd_tablea_test.heightHint = 220;
		table_test.setLayoutData(gd_tablea_test);
		table_test.setHeaderVisible(true);
		table_test.setLinesVisible(true);
		tbtmNewItem_2.setControl(compsoite_test);
		GridLayout layout_test = new GridLayout();
		layout3.marginWidth = 0;
		layout3.marginHeight = 0;
		compsoite_test.setLayout(layout_test);

		/* ss */
		Composite compsoitecupusage = new Composite(tabFolder, SWT.NONE);
		tbtmNewItem_stackusage = new CTabItem(tabFolder, SWT.NONE);
		tbtmNewItem_stackusage.setImage(DeviceUtil.getImage("icons/stackusage.png")); //$NON-NLS-1$
		tbtmNewItem_stackusage.setText(Messages.RemoteSystemInofView_StackUsage);
		tableViewer_stackusage = new TableViewer(compsoitecupusage, SWT.BORDER | SWT.FULL_SELECTION);
		table_stackusage = tableViewer_stackusage.getTable();
		GridData gd_tablecupusage = new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1);
		gd_tablecupusage.heightHint = 220;
		table_stackusage.setLayoutData(gd_tablecupusage);
		table_stackusage.setHeaderVisible(true);
		table_stackusage.setLinesVisible(true);
		tbtmNewItem_stackusage.setControl(compsoitecupusage);
		GridLayout layoutcupusage = new GridLayout();
		layoutcupusage.marginWidth = 0;
		layoutcupusage.marginHeight = 0;
		compsoitecupusage.setLayout(layoutcupusage);

		/* ints */
		tbtmNewItem_ints = new CTabItem(tabFolder, SWT.NONE);
		tbtmNewItem_ints.setImage(DeviceUtil.getImage("icons/stop.png")); //$NON-NLS-1$
		tbtmNewItem_ints.setText(Messages.RemoteSystemInofView_Interrupt);
		SashForm sashForm_ints = new SashForm(tabFolder, SWT.VERTICAL);
		tbtmNewItem_ints.setControl(sashForm_ints);
		tableViewer_ints_vector = new TableViewer(sashForm_ints, SWT.BORDER | SWT.FULL_SELECTION);
		table_ints_vector = tableViewer_ints_vector.getTable();
		table_ints_vector.setHeaderVisible(true);
		table_ints_vector.setLinesVisible(true);
		tableViewer_ints_nesting = new TableViewer(sashForm_ints, SWT.BORDER | SWT.FULL_SELECTION);
		table_ints_nesting = tableViewer_ints_nesting.getTable();
		table_ints_nesting.setHeaderVisible(true);
		table_ints_nesting.setLinesVisible(true);
		sashForm_ints.setWeights(new int[] { 161, 103 });

		/* tp */
		Composite compsoitetp = new Composite(tabFolder, SWT.NONE);
		tbtmNewItem_tp = new CTabItem(tabFolder, SWT.NONE);
		tbtmNewItem_tp.setImage(DeviceUtil.getImage("icons/lock.png")); //$NON-NLS-1$
		tbtmNewItem_tp.setText(Messages.RemoteSystemInofView_ThreadPending);
		tableViewer_tp = new TableViewer(compsoitetp, SWT.BORDER | SWT.FULL_SELECTION);
		table_tp = tableViewer_tp.getTable();
		GridData gd_tabletp = new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1);
		gd_tabletp.heightHint = 220;
		table_tp.setLayoutData(gd_tabletp);
		table_tp.setHeaderVisible(true);
		table_tp.setLinesVisible(true);
		tbtmNewItem_tp.setControl(compsoitetp);
		GridLayout layouttp = new GridLayout();
		layouttp.marginWidth = 0;
		layouttp.marginHeight = 0;
		compsoitetp.setLayout(layouttp);

		ThreadPendingMenu();
		business();

		tabFolder.setSelection(tbtmNewItem);
		MemoryMenu();
		ProcessMenu();
		ThreadMenu();
		StackUsageMenu();
		interruptMenu();
		TestMenu();
	}

	/**
	 * 内存选项页菜单
	 */
	private void MemoryMenu() {
		Menu memorymenu = new Menu(table);
		MenuItem memoryItem = new MenuItem(memorymenu, SWT.PUSH);
		memoryItem.setText(Messages.RemoteSystemInofView_Refresh);
		memoryItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread memorymenu = new Thread() {
					public void run() {
						rDataInfo.RefreshMems();
					}
				};
				memorymenu.setName("memorymenu"); //$NON-NLS-1$
				memorymenu.start();
			}
		});

		MenuItem connectItem = new MenuItem(memorymenu, SWT.PUSH);
		connectItem.setText(Messages.RemoteSystemInofView_Reconnect);
		connectItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});

		memorymenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				memoryItem.setEnabled(false);
				connectItem.setEnabled(false);
				if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					memoryItem.setEnabled(true);
				} else if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& !RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					connectItem.setEnabled(true);
				}
			}

			@Override
			public void menuHidden(MenuEvent e) {
			}
		});
		table.setMenu(memorymenu);

		Menu memoryfreemenu = new Menu(table_3);

		MenuItem memoryfreeItem = new MenuItem(memoryfreemenu, SWT.PUSH);
		memoryfreeItem.setText("Refresh.."); //$NON-NLS-1$
		memoryfreeItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread memoryfreemenu = new Thread() {
					public void run() {
						rDataInfo.RefreshMems();
					}
				};
				memoryfreemenu.setName("memoryfreemenu"); //$NON-NLS-1$
				memoryfreemenu.start();
			}
		});

		MenuItem connectfreeItem = new MenuItem(memoryfreemenu, SWT.PUSH);
		connectfreeItem.setText("Reconnect.."); //$NON-NLS-1$
		connectfreeItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});

		memoryfreemenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				memoryfreeItem.setEnabled(false);
				connectfreeItem.setEnabled(false);
				if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					memoryfreeItem.setEnabled(true);
				} else if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& !RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					connectfreeItem.setEnabled(true);
				}
			}

			@Override
			public void menuHidden(MenuEvent e) {
			}
		});
		table_3.setMenu(memoryfreemenu);
	}

	/**
	 * 进程选项页菜单
	 */
	private void ProcessMenu() {
		Menu processmenu = new Menu(table_1);

		MenuItem KillprocessItem = new MenuItem(processmenu, SWT.PUSH);
		KillprocessItem.setText(Messages.RemoteSystemInofView_KillProcess);
		KillprocessItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				String strprocess = table_1.getSelection()[0].getText(TableColumns.getIps_pid());
				rDataInfo.KillSendcommands(strprocess);
			}
		});

		MenuItem refreshprocessItem = new MenuItem(processmenu, SWT.PUSH);
		refreshprocessItem.setText(Messages.RemoteSystemInofView_Refresh);
		refreshprocessItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread processmenu = new Thread() {
					public void run() {
						rDataInfo.RefreshProcess();
					}
				};
				processmenu.setName("processmenu"); //$NON-NLS-1$
				processmenu.start();

			}
		});
		/*----------------------未处理（包含菜单的显示以及判断修改进程核数的pid）-------------------------*/
		MenuItem CorrelationprocessItem = new MenuItem(processmenu, SWT.PUSH);
		CorrelationprocessItem.setText(Messages.RemoteSystemInofView_Correlation);
		CorrelationprocessItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();
				String strprocessname = table_1.getSelection()[0].getText(TableColumns
					.getIps_name());
				String strprocess = table_1.getSelection()[0].getText(TableColumns.getIps_pid())
					.trim();
				String strcpuactive = "NULL";
				RelevanceDialog dialog = new RelevanceDialog(shell, strprocessname, TableColumns
					.getIcpucores(), strcpuactive);
				if (dialog.open() == Dialog.OK) {
					Thread psaffinitytid = new Thread() {
						public void run() {
							rDataInfo.telnetclient
								.sendCommand("affinity " + strprocess + " " + dialog.getstrCPUActive()); //$NON-NLS-1$ //$NON-NLS-2$
						}
					};
					psaffinitytid.setName("psaffinity"); //$NON-NLS-1$
					psaffinitytid.start();
				}
			}
		});
		/*----------------------未处理-------------------------*/

		// 创建一个debug按钮，该按钮可以获取当前选中的进程id(pid)，选中需要被调试的app工程后，并由此启动一个debug调试 ，
		// guoenjing@acoinfo.com
		MenuItem debugItem = new MenuItem(processmenu, SWT.PUSH);
		debugItem.setText(Messages.RemoteSystemInofView_Debug);
		debugItem.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent event) {
				if (table_1.getSelectionCount() != 1) {
					return;
				}
				ElementTreeSelectionDialog dialog = new ElementTreeSelectionDialog(processmenu
					.getShell(), new WorkbenchLabelProvider(), new WorkbenchContentProvider());
				dialog.setAllowMultiple(false);
				dialog.setHelpAvailable(false);
				dialog.setTitle(Messages.RemoteSystemInofView_SelectionDialogMsg); //$NON-NLS-1$
				dialog.setMessage(Messages.RemoteSystemInofView_SelectionDialogMsg); //$NON-NLS-1$
				dialog.setInput(ResourcesPlugin.getWorkspace().getRoot());
				dialog.setComparator(new ResourceComparator(ResourceComparator.NAME));
				dialog.addFilter(new ViewerFilter() {
					@Override
					public boolean select(Viewer viewer, Object parentElement, Object element) {
						if (element instanceof IResource) {
							if (element instanceof IProject) {
								IProject project = (IProject) element;
								String strProjectPath = project.getLocation().toOSString();
								if (!"SylixOSAppProject".equals(ProjectCfg.GetProjectCfg(strProjectPath).GetProjectType()) || CommonUtil.IsOlderVersionProject(strProjectPath)) { //$NON-NLS-1$
									// 排除非app工, 排除老工程
									return false;
								}
							} else if (element instanceof IFolder) {
								IFolder folder = (IFolder) element;
								if (!"Debug".equals(folder.getName())) {//$NON-NLS-1$
									return false;
								}
							} else if (element instanceof IFile) {
								IFile file = (IFile) element;
								if (!"Debug".equals(file.getParent().getName())) {//$NON-NLS-1$
									return false;
								}
							}
							return true;
						} else {
							return false;
						}
					}
				});

				dialog.setValidator(new ISelectionStatusValidator() {
					@Override
					public IStatus validate(Object[] selection) {
						if (selection != null && selection.length > 0) {
							if (selection[0] instanceof IProject) {
								return new Status(IStatus.OK, Activator.PLUGIN_ID, "");
							} else if (selection[0] instanceof IFile) {
								return new Status(IStatus.OK, Activator.PLUGIN_ID, "");
							}
						}
						return new Status(IStatus.ERROR, Activator.PLUGIN_ID,
							Messages.RemoteSystemInofView_SelectionDialogErrorMsg);
					}
				});
				if (dialog.open() == IDialogConstants.OK_ID) {
					Object result = dialog.getFirstResult();
					if (result == null) { //$NON-NLS-1$
						return;
					}
					IProject project;
					String programName;
					String strprocess = table_1.getSelection()[0].getText(TableColumns.getIps_pid());
					if (result instanceof IProject) {
						project = (IProject) result;
						programName = "Debug" + File.separator + project.getName();
					} else if (result instanceof IFile) {
						IFile executableFile = (IFile) result;
						project = executableFile.getProject();
						programName = "Debug" + File.separator + executableFile.getName();
					} else {
						return;
					}
					new AttachDebugAction().launch(project, programName, strprocess);
				}
			}
		});

		MenuItem ConnectprocessItem = new MenuItem(processmenu, SWT.PUSH);
		ConnectprocessItem.setText(Messages.RemoteSystemInofView_Reconnect);
		ConnectprocessItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});

		processmenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				isDebugMenuShow(debugItem);
				isShowMenu(KillprocessItem, refreshprocessItem, ConnectprocessItem,
					CorrelationprocessItem, table_1);
			}

			@Override
			public void menuHidden(MenuEvent e) {
			}
		});
		table_1.setMenu(processmenu);
	}

	/**
	 * 线程选项页菜单
	 */
	private void ThreadMenu() {
		// 创建一个Thread 右键菜单
		Menu threadmenu = new Menu(table_2);
		MenuItem killthreadItem = new MenuItem(threadmenu, SWT.PUSH);
		killthreadItem.setText(Messages.RemoteSystemInofView_KillThread);
		killthreadItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				String strthreadtid = table_2.getSelection()[0].getText(TableColumns.getIts_tid())
					.trim();
				rDataInfo.KillSendcommands(strthreadtid);
			}
		});

		MenuItem refreshthreadItem = new MenuItem(threadmenu, SWT.PUSH);
		refreshthreadItem.setText(Messages.RemoteSystemInofView_Refresh);
		refreshthreadItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread threadmenu = new Thread() {
					public void run() {
						rDataInfo.RefreshThread();
					}
				};
				threadmenu.setName("threadmenu"); //$NON-NLS-1$
				threadmenu.start();
			}
		});

		MenuItem CorrelationthreadItem = new MenuItem(threadmenu, SWT.PUSH);
		CorrelationthreadItem.setText(Messages.RemoteSystemInofView_Correlation);
		CorrelationthreadItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				String strcpuactive = "NULL";
				String strthreadname = table_2.getSelection()[0]
					.getText(TableColumns.getIts_name()).trim();
				String strthreadtid = table_2.getSelection()[0].getText(TableColumns.getIts_tid())
					.trim();
				if (rDataInfo.telnetclient.isTelnetConnected()) {
					String str = rDataInfo.telnetclient.sendCommand("affinity"); //$NON-NLS-1$
					rDataInfo.rDataParsing.getaffinity(str, 2);
					LinkedHashMap<String, String> mapLink = rDataInfo.rDataParsing.getaffinitymap();
					Iterator<Entry<String, String>> iter = mapLink.entrySet().iterator();
					while (iter.hasNext()) {
						Map.Entry entry = (Map.Entry) iter.next();
						if (entry.getKey().equals(strthreadtid)) {
							strcpuactive = (String) entry.getValue();
						}
					}
					Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();
					RelevanceDialog dialog = new RelevanceDialog(shell, strthreadname, TableColumns
						.getIcpucores(), strcpuactive);
					if (dialog.open() == Dialog.OK) {
						Thread affinitytid = new Thread() {
							public void run() {
								rDataInfo.telnetclient
									.sendCommand("affinity " + strthreadtid + " " + dialog.getstrCPUActive()); //$NON-NLS-1$ //$NON-NLS-2$
							}
						};
						affinitytid.setName("affinity"); //$NON-NLS-1$
						affinitytid.start();
					}
				}
			}
		});

		MenuItem ConnectthreadItem = new MenuItem(threadmenu, SWT.PUSH);
		ConnectthreadItem.setText(Messages.RemoteSystemInofView_Reconnect);
		ConnectthreadItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});
		threadmenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				isShowMenu(killthreadItem, refreshthreadItem, ConnectthreadItem,
					CorrelationthreadItem, table_2);
			}

			@Override
			public void menuHidden(MenuEvent e) {

			}
		});
		table_2.setMenu(threadmenu);
	}

	/**
	 * Test选项页菜单
	 */
	private void TestMenu() {
		// 创建一个Thread 右键菜单
		Menu threadmenu = new Menu(table_test);

		// 在右键菜单添加操作项
		MenuItem killthreadItem = new MenuItem(threadmenu, SWT.PUSH);
		killthreadItem.setText(Messages.RemoteSystemInofView_KillThread);
		killthreadItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				String strthreadtid = table_test.getSelection()[0].getText(TableColumns.getIts_tid())
					.trim();
				rDataInfo.KillSendcommands(strthreadtid);
			}
		});

		MenuItem refreshthreadItem = new MenuItem(threadmenu, SWT.PUSH);
		refreshthreadItem.setText(Messages.RemoteSystemInofView_Refresh);
		refreshthreadItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread threadmenu = new Thread() {
					public void run() {
						rDataInfo.RefreshThread();
					}
				};
				threadmenu.setName("Testmenu"); //$NON-NLS-1$
				threadmenu.start();
			}
		});

		MenuItem CorrelationthreadItem = new MenuItem(threadmenu, SWT.PUSH);
		CorrelationthreadItem.setText(Messages.RemoteSystemInofView_Correlation);
		CorrelationthreadItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				String strcpuactive = "NULL";
				String strthreadname = table_test.getSelection()[0]
					.getText(TableColumns.getIts_name()).trim();
				String strthreadtid = table_test.getSelection()[0].getText(TableColumns.getIts_tid())
					.trim();
				if (rDataInfo.telnetclient.isTelnetConnected()) {
					String str = rDataInfo.telnetclient.sendCommand("affinity"); //$NON-NLS-1$
					rDataInfo.rDataParsing.getaffinity(str, 2);
					LinkedHashMap<String, String> mapLink = rDataInfo.rDataParsing.getaffinitymap();
					Iterator<Entry<String, String>> iter = mapLink.entrySet().iterator();
					while (iter.hasNext()) {
						Map.Entry entry = (Map.Entry) iter.next();
						if (entry.getKey().equals(strthreadtid)) {
							strcpuactive = (String) entry.getValue();
						}
					}
					Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();
					RelevanceDialog dialog = new RelevanceDialog(shell, strthreadname, TableColumns
						.getIcpucores(), strcpuactive);
					if (dialog.open() == Dialog.OK) {
						Thread affinitytid = new Thread() {
							public void run() {
								rDataInfo.telnetclient
									.sendCommand("affinity " + strthreadtid + " " + dialog.getstrCPUActive()); //$NON-NLS-1$ //$NON-NLS-2$
							}
						};
						affinitytid.setName("affinity"); //$NON-NLS-1$
						affinitytid.start();
					}
				}
			}
		});

		MenuItem ConnectthreadItem = new MenuItem(threadmenu, SWT.PUSH);
		ConnectthreadItem.setText(Messages.RemoteSystemInofView_Reconnect);
		ConnectthreadItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});
		
		// 菜单显示规则
		threadmenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				isShowMenu(killthreadItem, refreshthreadItem, ConnectthreadItem,
					CorrelationthreadItem, table_test);
			}

			@Override
			public void menuHidden(MenuEvent e) {

			}
		});
		// 添加到标签页
		table_test.setMenu(threadmenu);
	}

	/**
	 * 堆栈选项页菜单
	 */
	private void StackUsageMenu() {
		Menu stackusagemenu = new Menu(table_stackusage);

		MenuItem refreshssItem = new MenuItem(stackusagemenu, SWT.PUSH);
		refreshssItem.setText("Refresh.."); //$NON-NLS-1$
		refreshssItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread stackusagemenu = new Thread() {
					public void run() {
						rDataInfo.RefreshCPUutilization();
					}
				};
				stackusagemenu.setName("stackusagemenu"); //$NON-NLS-1$
				stackusagemenu.start();
			}
		});

		MenuItem connectssItem = new MenuItem(stackusagemenu, SWT.PUSH);
		connectssItem.setText("Reconnect.."); //$NON-NLS-1$
		connectssItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});

		stackusagemenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				refreshssItem.setEnabled(false);
				connectssItem.setEnabled(false);
				if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					refreshssItem.setEnabled(true);
				} else if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& !RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					connectssItem.setEnabled(true);
				}
			}

			@Override
			public void menuHidden(MenuEvent e) {
			}
		});
		table_stackusage.setMenu(stackusagemenu);
	}

	/**
	 * 选项页菜单
	 */
	private void interruptMenu() {
		Menu interruptmenu = new Menu(table_ints_nesting);

		MenuItem refreshItem = new MenuItem(interruptmenu, SWT.PUSH);
		refreshItem.setText("Refresh.."); //$NON-NLS-1$
		refreshItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread interruptMenu = new Thread() {
					public void run() {
						rDataInfo.Refreshints();
					}
				};
				interruptMenu.setName("interruptRefresh"); //$NON-NLS-1$
				interruptMenu.start();
			}
		});

		MenuItem connectItem = new MenuItem(interruptmenu, SWT.PUSH);
		connectItem.setText("Reconnect.."); //$NON-NLS-1$
		connectItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});

		interruptmenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				refreshItem.setEnabled(false);
				connectItem.setEnabled(false);
				if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					refreshItem.setEnabled(true);
				} else if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& !RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					connectItem.setEnabled(true);
				}
			}

			@Override
			public void menuHidden(MenuEvent e) {
			}
		});
		table_ints_nesting.setMenu(interruptmenu);

		Menu ints_vectortmenu = new Menu(table_ints_vector);

		MenuItem refreshintsItem = new MenuItem(ints_vectortmenu, SWT.PUSH);
		refreshintsItem.setText("Refresh.."); //$NON-NLS-1$
		refreshintsItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread interruptMenu = new Thread() {
					public void run() {
						rDataInfo.Refreshints();
					}
				};
				interruptMenu.setName("interruptRefresh"); //$NON-NLS-1$
				interruptMenu.start();
			}
		});

		MenuItem connectintsItem = new MenuItem(ints_vectortmenu, SWT.PUSH);
		connectintsItem.setText("Reconnect.."); //$NON-NLS-1$
		connectintsItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});

		ints_vectortmenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				refreshintsItem.setEnabled(false);
				connectintsItem.setEnabled(false);
				if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					refreshintsItem.setEnabled(true);
				} else if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& !RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					connectintsItem.setEnabled(true);
				}
			}

			@Override
			public void menuHidden(MenuEvent e) {
			}
		});
		table_ints_vector.setMenu(ints_vectortmenu);
	}

	/**
	 * 线程阻塞选项页菜单
	 */
	private void ThreadPendingMenu() {
		Menu tpmenu = new Menu(table_tp);

		MenuItem refreshtpItem = new MenuItem(tpmenu, SWT.PUSH);
		refreshtpItem.setText("Refresh.."); //$NON-NLS-1$
		refreshtpItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Thread tpmenu = new Thread() {
					public void run() {
						rDataInfo.Refreshtp();
					}
				};
				tpmenu.setName("tpmenu"); //$NON-NLS-1$
				tpmenu.start();

			}
		});

		MenuItem connecttpItem = new MenuItem(tpmenu, SWT.PUSH);
		connecttpItem.setText("Reconnect.."); //$NON-NLS-1$
		connecttpItem.addListener(SWT.Selection, new Listener() {
			@Override
			public void handleEvent(Event event) {
				Reconnect();
			}
		});

		tpmenu.addMenuListener(new MenuListener() {
			@Override
			public void menuShown(MenuEvent e) {
				refreshtpItem.setEnabled(false);
				connecttpItem.setEnabled(false);
				if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					refreshtpItem.setEnabled(true);
				} else if (RemoteSystemDataInfo.rDeviceEntrity != null
					&& RemoteSystemDataInfo.telnetclient != null
					&& !RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
					connecttpItem.setEnabled(true);
				}
			}

			@Override
			public void menuHidden(MenuEvent e) {
			}
		});
		table_tp.setMenu(tpmenu);
	}

	/**
	 * 添加信息公共方法
	 *
	 * @param table
	 * @param tableViewer
	 */
	void setcreatePart(Table table, TableViewer tableViewer, String[][] strcontent,
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
				if (table.equals(table_tp)) {
					// 获取table所有行
					List<TableItem> list = new ArrayList<TableItem>();
					TableItem[] items = table_tp.getItems();
					for (int i = 0; i < items.length; i++) {
						if (!items[i].getText(6).trim().equals("")) { //$NON-NLS-1$
							items[i].setBackground(col);
							list.add(items[i]);
						}
					}
					List<TableItem> listred = new ArrayList<TableItem>();
					for (int x = 0; x < list.size(); x++) {
						for (int y = 0; y < list.size(); y++) {
							if ((list.get(y).getText(6).trim()
								.equals(list.get(x).getText(1).trim()))
								&& (list.get(y).getText(1).trim().equals(list.get(x).getText(6)
									.trim()))) {
								listred.add(list.get(y));
							}
							if (list.get(x).getText(6).trim().equals(list.get(y).getText(1).trim())) {
								listred.add(list.get(y));
							}
						}
					}
					for (int x = 0; x < listred.size(); x++) {
						listred.get(x).setBackground(Red);
					}
					itemi = null;
				}
				if (!table.equals(table_tp) && iSelection != -1) {
					table.setSelection(iSelection);
				}

				if (TPSelection != -1) {
					TableItem[] items = table_tp.getItems();
					for (int i = 0; i < items.length; i++) {
						if (items[i].getText(1).equals(strpttid)) {
							TPSelection = i;
						}
					}
					if (TPSelection >= items.length) {
						return;
					}
					table_tp.setSelection(TPSelection);
					TableItem item = table_tp.getItem(TPSelection);
					String strowner = item.getText(6);
					if (!strowner.isEmpty()) {
						for (int i = 0; i < items.length; i++) {
							if (items[i].getText(1).equals(strowner)) {
								itemi = items[i];
								itemi.setBackground(Lime);
							}
						}
					}
				}
				// 设置当前选中信息位置
				table.setTopIndex(iscrollbarlocation);
			}
		});
	}

	/**
	 * 商业版中tptableViewer 选中的行
	 */
	public void business() {
		tableViewer_tp.addSelectionChangedListener(new ISelectionChangedListener() {
			public void selectionChanged(SelectionChangedEvent event) {
				if (itemi != null) {
					if (coldefault == null) {
						coldefault = table_tp.getBackground();
					}
					itemi.setBackground(coldefault);
				}
				TPSelection = table_tp.getSelectionIndex();
				if (TPSelection != -1) {
					TableItem item = table_tp.getItem(TPSelection);
					strpttid = item.getText(1);
					String strowner = item.getText(6);
					if (!strowner.isEmpty()) {
						TableItem[] items = table_tp.getItems();
						for (int i = 0; i < items.length; i++) {
							if (items[i].getText(1).equals(strowner)) {
								coldefault = items[i].getBackground();
								itemi = items[i];
								itemi.setBackground(Lime);
							}
						}
					}
				}
			}
		});
	}

	public void setmenry(String[] strtitle, String[][] strcontent) {
		setcreatePart(table, tableViewer, strcontent, strtitle);
	}

	public void setProcess(String[] strtitle, String[][] strcontent) {

		setcreatePart(table_1, tableViewer_1, strcontent, strtitle);
	}

	public void setThread(String[] strtitle, String[][] strcontent) {
		setcreatePart(table_2, tableViewer_2, strcontent, strtitle);
	}

	public void setCPUutilization(String[] strtitle, String[][] strcontent) {
		setcreatePart(table_stackusage, tableViewer_stackusage, strcontent, strtitle);
	}

	public void settp(String[] strtitle, String[][] strcontent) {
		setcreatePart(table_tp, tableViewer_tp, strcontent, strtitle);
	}

	public void setfree(String[] strtitle, String[][] strcontent, String strtextcontent) {
		setcreatePart(table_3, tableViewer_3, strcontent, strtitle);
		text.getDisplay().syncExec(new Runnable() {
			@Override
			public void run() {
				text.setText(""); //$NON-NLS-1$
				text.setText(strtextcontent);
			}
		});
	}

	public void dispose() {
		RemoteSystemDataInfo.DisConnect();
		RemoteSystemDataInfo.rDeviceEntrity = null;
		RemoteSystemDataInfo.telnetclient = null;
		DeviceUtil.RefreshView();
	}

	private void isShowMenu(MenuItem KillItem, MenuItem RefreshItem, MenuItem ConnectItem,
		MenuItem CorrelationItem, Table table) {
		KillItem.setEnabled(false);
		RefreshItem.setEnabled(false);
		ConnectItem.setEnabled(false);
		CorrelationItem.setEnabled(false);
		if (RemoteSystemDataInfo.rDeviceEntrity != null) {
			if (RemoteSystemDataInfo.telnetclient.isTelnetConnected()) {
				RefreshItem.setEnabled(true);

				if (table.getSelectionIndex() != -1) {
					TableItem items = table.getItem(table.getSelectionIndex());
					if (items == null) {
						return;
					}
					if (table.equals(table_1)
						&& !items.getText(TableColumns.getIps_pid()).trim().equals("0")) { //$NON-NLS-1$
						KillItem.setEnabled(true);
						CorrelationItem.setEnabled(true);
					}
					if (table.equals(table_2)
						&& !items.getText(TableColumns.getIts_pid()).trim().equals("0")) { //$NON-NLS-1$
						KillItem.setEnabled(true);
					}
					if (TableColumns.getIcpucores() == 1) {
						CorrelationItem.setEnabled(false);
					} else if (table.equals(table_2)
						&& !items.getText(TableColumns.getIts_name()).trim().startsWith("t_idle")) { //$NON-NLS-1$
						CorrelationItem.setEnabled(true);
					}
				}

			} else {
				ConnectItem.setEnabled(true);
			}
		}
	}

	/**
	 * 判断debug按钮是否显示
	 *
	 * @author guoenjing@acoinfo.com
	 * @param debugItem
	 */
	private void isDebugMenuShow(MenuItem debugItem) {
		debugItem.setEnabled(false);
		if (RemoteSystemDataInfo.rDeviceEntrity != null
			&& RemoteSystemDataInfo.telnetclient.isTelnetConnected()
			&& table_1.getSelectionIndex() != -1) {
			TableItem items = table_1.getItem(table_1.getSelectionIndex());
			if (items == null) {
				return;
			}
			if (!items.getText(TableColumns.getIps_pid()).trim().equals("0")) { //$NON-NLS-1$
				debugItem.setEnabled(true);
			}
		}
	}

	private void Reconnect() {
		rDataInfo.ismessagebox = true;
		if (rDataInfo.Reloginthread != null && rDataInfo.Reloginthread.isAlive()) {
			return;
		}
		rDataInfo.Relogin();
	}

	@Override
	public void setFocus() {
		// TODO Auto-generated method stub
	}
}



```
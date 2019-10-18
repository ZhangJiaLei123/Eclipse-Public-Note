

```java {.line-numbers}
public class SampleAction implements IWorkbenchWindowActionDelegate{

	@Override
	public void run(IAction action) {
		String strActionName = action.getText();
		System.out.println(strActionName );//按钮名称
		System.out.println(action.getId() );// 按钮id
	}

	@Override
	public void selectionChanged(IAction action, ISelection selection) {
		// TODO Auto-generated method stub

	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public void init(IWorkbenchWindow window) {
		// TODO Auto-generated method stub

	}

}
```

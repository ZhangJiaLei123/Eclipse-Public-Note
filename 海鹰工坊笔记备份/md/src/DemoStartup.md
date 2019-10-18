
```java {.line-numbers}
import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.IStartup;

public class Startup implements IStartup {

	@Override
	public void earlyStartup() {
		Display.getDefault().syncExec(new Runnable() {
			public void run() {
				try {
					System.setProperty("HY-IDE_Version", "1.0");
					System.setProperty("HY-PATCH-Version", "1.0.0");
				} catch (Throwable t) {
					t.printStackTrace();
				}
			}
		});

	}

}

```

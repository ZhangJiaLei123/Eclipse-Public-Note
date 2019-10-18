```java {.line-numbers}
public class SourceFileRenameParticipant extends RenameParticipant {
	
	// 需要被删除的源文件列表
	private List<String> deleteFilter = new ArrayList<String>();

	public SourceFileRenameParticipant() {
		// TODO 自动生成的构造函数存根
	}

	@Override
	protected boolean initialize(Object element) {
		if (element instanceof IResource) {
			IResource resource = (IResource) element;
			String projectLocation = resource.getProject().getLocation().toString();
			if (FileUtil.underDebugOrRelease(resource.getLocation().toString(), projectLocation)) {
				return false;
			}
			******
			if (!deleteFilter.isEmpty()) {
				return true;
			}
			return false;
		}
		return false;
	}

}

```

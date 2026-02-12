package unluac.web.result;

import java.util.ArrayList;
import java.util.List;

public final class PagedResult<T> {
  public int page;
  public int pageSize;
  public long total;
  public final List<T> records = new ArrayList<T>();
}


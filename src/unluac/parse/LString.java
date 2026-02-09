package unluac.parse;


import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;


public class LString extends LObject {

  private static final Charset FALLBACK_CHARSET = StandardCharsets.ISO_8859_1;
  private static final Charset DISPLAY_CHARSET = resolveDisplayCharset();

  public final BSizeT size;
  public final String value;
  public final byte[] bytes;
  
  public LString(BSizeT size, String value) {    
    this.size = size;
    this.value = value.length() == 0 ? "" : value.substring(0, value.length() - 1);
    this.bytes = this.value.getBytes(StandardCharsets.ISO_8859_1);
  }

  public LString(BSizeT size, byte[] valueBytes) {
    this.size = size;
    if(valueBytes == null || valueBytes.length == 0) {
      this.value = "";
      this.bytes = new byte[0];
      return;
    }
    int end = valueBytes.length;
    if(valueBytes[end - 1] == 0) {
      end--;
    }
    this.bytes = new byte[end];
    System.arraycopy(valueBytes, 0, this.bytes, 0, end);
    this.value = decodeForDisplay(this.bytes);
  }

  private static String decodeForDisplay(byte[] bytes) {
    try {
      return new String(bytes, DISPLAY_CHARSET);
    } catch(Exception e) {
      return new String(bytes, FALLBACK_CHARSET);
    }
  }

  private static Charset resolveDisplayCharset() {
    String name = System.getProperty("unluac.stringCharset", "GBK");
    try {
      return Charset.forName(name);
    } catch(Exception e) {
      return FALLBACK_CHARSET;
    }
  }
  
  @Override
  public String deref() {
    return value;
  }
  
  @Override
  public String toString() {
    return "\"" + value + "\"";
  }
  
  @Override
  public boolean equals(Object o) {
    if(o instanceof LString) {
      LString os = (LString) o;
      return os.value.equals(value);
    }
    return false;
  }
  
}

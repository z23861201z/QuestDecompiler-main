package unluac.parse;

import java.nio.ByteBuffer;


public abstract class LStringType extends BObjectType<LString> {

  public static LStringType50 getType50() {
    return new LStringType50();
  }
  
  public static LStringType53 getType53() {
    return new LStringType53();
  }
  
  protected ThreadLocal<StringBuilder> b = new ThreadLocal<StringBuilder>() {
    
    @Override
    protected StringBuilder initialValue() {
      return new StringBuilder();  
    }

  };
  
}

class LStringType50 extends LStringType {
  @Override
  public LString parse(final ByteBuffer buffer, BHeader header) {
    BSizeT sizeT = header.sizeT.parse(buffer, header);
    int length = sizeT.asInt();
    if(length == 0) {
      if(header.debug) {
        System.out.println("-- parsed <string> \"\"");
      }
      return new LString(sizeT, new byte[0]);
    }

    byte[] payload = new byte[length];
    for(int i = 0; i < length; i++) {
      payload[i] = buffer.get();
    }

    if(header.Encoded) {
      for(int i = 0; i < length - 1; i++) {
        payload[i] = (byte)((payload[i] - (i + 1)) & 0xFF);
      }
    }

    LString value = new LString(sizeT, payload);
    if(header.debug) {
      System.out.println("-- parsed <string> \"" + value.deref() + "\"");
    }
    return value;
  }
}

class LStringType53 extends LStringType {
  @Override
  public LString parse(final ByteBuffer buffer, BHeader header) {
    BSizeT sizeT;
    int size = 0xFF & buffer.get();
    if(size == 0xFF) {
      sizeT = header.sizeT.parse(buffer, header);
    } else {
      sizeT = new BSizeT(size);
    }
    int length = sizeT.asInt();
    byte[] payload = new byte[length];
    for(int i = 0; i < length; i++) {
      payload[i] = buffer.get();
    }
    String s = new LString(sizeT, payload).deref();
    if(header.debug) {
      System.out.println("-- parsed <string> \"" + s + "\"");
    }
    return new LString(sizeT, payload);
  }
}

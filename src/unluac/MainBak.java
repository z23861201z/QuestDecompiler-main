package unluac;

import unluac.decompile.Decompiler;
import unluac.decompile.Output;
import unluac.decompile.OutputProvider;
import unluac.parse.BHeader;
import unluac.parse.LFunction;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.FileChannel;

public class MainBak {

  public static String version = "1.2.2.155";
  
  public static void main(String[] args) {
    String [] arr = new String[2];
    arr[0]="-a";
    arr[1]="E:\\SteamLibrary\\steamapps\\common\\SoulSaverOnline\\zGsp\\Script\\quest.luc";
    args = arr;
    String fn = null;
    Configuration config = new Configuration();
    for(String arg : args) {
      if(arg.startsWith("-")) {
        // option
        if(arg.equals("--rawstring")) {
          config.rawstring = true;
        }  else if(arg.equals("-a")) 
        {
        	 try {
        		 
       			decompile(args[1],args[1].replace(".luc", ".lua"));
       		} catch (IOException e) {
       			// TODO Auto-generated catch block
       			e.printStackTrace();
       		}
        }
        else {
          error("unrecognized option: " + arg, true);
        }
      } else if(fn == null) {
        fn = arg;
      } else {
        error("too many arguments: " + arg, true);
      }
    }
    if(fn == null) {
      error("no input file provided", true);
    } else {
      LFunction lmain = null;
      try {
        lmain = file_to_function(fn, config);
      } catch(IOException e) {
        error(e.getMessage(), false);
      }
      
      Decompiler d = new Decompiler(lmain);
      d.decompile();
      d.print();
      System.exit(0);
    }
  }
  
  private static void error(String err, boolean usage) {
    System.err.println("unluac v" + version);
    System.err.print("  error: ");
    System.err.println(err);
    if(usage) {
      System.err.println("  usage: java -jar unluac.jar [options] <file>");
    }
    System.exit(1);
  }
  private static LFunction file_to_function(String fn, Configuration config) throws IOException {
    RandomAccessFile file = new RandomAccessFile(fn, "r");  // 打开指定文件的随机访问文件对象
    ByteBuffer buffer = ByteBuffer.allocate((int) file.length());  // 创建指定长度的字节缓冲区
    buffer.order(ByteOrder.LITTLE_ENDIAN);  // 设置字节缓冲区的字节顺序为小端序
    int len = (int) file.length();  // 获取文件长度
    FileChannel in = file.getChannel();  // 获取文件的通道
    while(len > 0) len -= in.read(buffer);  // 读取通道中的数据到缓冲区，直到读取完毕
    buffer.rewind();  // 重置缓冲区的位置为0
    BHeader header = new BHeader(buffer, config);  // 使用缓冲区和配置对象创建BHeader对象
    return header.main;  // 返回BHeader对象中的主函数
  }

  public static void decompile(String in, String out) throws IOException {
    LFunction lmain = file_to_function(in, new Configuration());  // 调用file_to_function函数获取LFunction对象
    Decompiler d = new Decompiler(lmain);  // 使用LFunction对象创建Decompiler对象
    d.decompile();  // 对LFunction对象进行反编译
    final PrintWriter pout = new PrintWriter(out, "UTF-8");  // 创建一个PrintWriter对象，用于写入UTF-8编码的文件
//    final PrintStream pout = new PrintStream(out);  // 创建一个PrintStream对象，用于写入文件
    d.print(new Output(new OutputProvider() {  // 使用OutputProvider接口实现创建一个Output对象
      @Override
      public void print(String s) {  // 实现print方法，打印字符串到PrintWriter对象
        pout.print(s);
      }
      @Override
      public void print(byte b) {  // 实现print方法，打印字节到PrintWriter对象
        pout.print(b);
      }
      @Override
      public void println() {  // 实现println方法，打印换行到PrintWriter对象
        pout.println();
      }
    }));
    pout.flush();  // 刷新PrintWriter对象，将缓冲区的内容写入文件
    pout.close();  // 关闭PrintWriter对象
  }

  
}

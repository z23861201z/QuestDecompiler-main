package unluac;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.nio.charset.Charset;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.FileChannel;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import unluac.decompile.Decompiler;
import unluac.decompile.Output;
import unluac.decompile.OutputProvider;
import unluac.parse.BHeader;
import unluac.parse.LFunction;

public class Main {
  public static String version = "1.2.2.155";

  private static final class CliOptions {
    String inputFile;
    String dirPath;
    String outputFile;
    String outputEncoding = "UTF-8";
    boolean rawstring;
  }

  public static void main(String[] args) {
    CliOptions options = parseArgs(args);
    Configuration config = new Configuration();
    config.rawstring = options.rawstring;

    try {
      if(options.dirPath != null) {
        // 批量处理目录下所有 .luc 文件
        processDirectory(options.dirPath, config, options.outputEncoding);
      } else if(options.inputFile != null) {
        // 单个文件处理（保持MainBak的逻辑）
        LFunction lmain = null;
        try {
          lmain = file_to_function(options.inputFile, config);
        } catch(IOException e) {
          error(e.getMessage(), false);
        }

        Decompiler d = new Decompiler(lmain);
        d.decompile();
        if(options.outputFile == null) {
          d.print();
        } else {
          printToFile(d, options.outputFile, options.outputEncoding);
        }
        System.exit(0);
      } else {
        error("no input file or directory provided", true);
      }
    } catch(Exception e) {
      error(e.getMessage(), false);
    }
  }

  // 处理目录下所有 .luc 文件
  private static void processDirectory(String dirPath, Configuration config, String outputEncoding) throws IOException {
    Path startDir = Paths.get(dirPath);
    Files.walk(startDir)
            .filter(path -> path.toString().toLowerCase().endsWith(".luc"))
            .forEach(path -> {
              try {
                String inFile = path.toString();
                String outFile = inFile.replace(".luc", ".lua");
                System.out.println("Processing: " + inFile);
                decompile(inFile, outFile, config, outputEncoding);
              } catch (Exception e) {
                System.err.println("Error processing " + path + ": " + e.getMessage());
              }
            });
  }

  private static void error(String err, boolean usage) {
    System.err.println("unluac v" + version);
    System.err.print("  error: ");
    System.err.println(err);
    if(usage) {
      System.err.println("  usage: java -cp build unluac.Main [options] <file>");
      System.err.println("  options:");
      System.err.println("    -d <dir>                 batch decompile .luc files");
      System.err.println("    -a <file>                legacy single-file mode");
      System.err.println("    -o|--out <file>          write output to file");
      System.err.println("    --encoding <charset>     output file charset (default UTF-8)");
      System.err.println("    --rawstring              raw string mode");
      System.err.println("  example:");
      System.err.println("    java -cp build unluac.Main --encoding GBK --out D:\\...\\quest.lua D:\\...\\quest.luc");
    }
    System.exit(1);
  }

  private static CliOptions parseArgs(String[] args) {
    CliOptions options = new CliOptions();
    for(int i = 0; i < args.length; i++) {
      String arg = args[i];
      if("-d".equals(arg) && i + 1 < args.length) {
        options.dirPath = args[++i];
      } else if("-a".equals(arg) && i + 1 < args.length) {
        options.inputFile = args[++i];
      } else if(("-o".equals(arg) || "--out".equals(arg)) && i + 1 < args.length) {
        options.outputFile = args[++i];
      } else if("--encoding".equals(arg) && i + 1 < args.length) {
        options.outputEncoding = normalizeCharset(args[++i]);
      } else if("--rawstring".equals(arg)) {
        options.rawstring = true;
      } else if(arg.startsWith("-")) {
        error("unrecognized option: " + arg, true);
      } else if(options.inputFile == null) {
        options.inputFile = arg;
      } else {
        error("too many arguments: " + arg, true);
      }
    }
    if(options.outputEncoding == null || options.outputEncoding.isEmpty()) {
      options.outputEncoding = "UTF-8";
    }
    return options;
  }

  private static String normalizeCharset(String name) {
    try {
      return Charset.forName(name).name();
    } catch(Exception e) {
      error("unsupported charset: " + name, false);
      return "UTF-8";
    }
  }

  private static void printToFile(Decompiler d, String outPath, String charset) throws IOException {
    final PrintWriter pout = new PrintWriter(outPath, charset);
    d.print(new Output(new OutputProvider() {
      @Override
      public void print(String s) {
        pout.print(s);
      }

      @Override
      public void print(byte b) {
        pout.print(b);
      }

      @Override
      public void println() {
        pout.println();
      }
    }));
    pout.flush();
    pout.close();
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

  public static LFunction fileToFunction(String fn, Configuration config) throws IOException {
    return file_to_function(fn, config);
  }

  public static void decompile(String in, String out) throws IOException {
    decompile(in, out, new Configuration(), "UTF-8");
  }

  public static void decompile(String in, String out, Configuration config) throws IOException {
    decompile(in, out, config, "UTF-8");
  }

  public static void decompile(String in, String out, Configuration config, String charset) throws IOException {
    LFunction lmain = file_to_function(in, config);  // 调用file_to_function函数获取LFunction对象
    Decompiler d = new Decompiler(lmain);  // 使用LFunction对象创建Decompiler对象
    d.decompile();  // 对LFunction对象进行反编译
    printToFile(d, out, charset);
  }
}

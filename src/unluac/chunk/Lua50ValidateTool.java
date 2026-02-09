package unluac.chunk;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Lua50ValidateTool {

  public static void main(String[] args) throws Exception {
    if(args.length < 2) {
      System.out.println("Usage: java -cp build unluac.chunk.Lua50ValidateTool <reference.luc> <target.luc> [report.txt]");
      return;
    }

    Path referencePath = Paths.get(args[0]);
    Path targetPath = Paths.get(args[1]);

    byte[] reference = Files.readAllBytes(referencePath);
    byte[] target = Files.readAllBytes(targetPath);

    Lua50StructureValidator validator = new Lua50StructureValidator(reference);
    Lua50StructureValidator.ValidationReport report = validator.validateLuc(target);

    System.out.println("reference=" + referencePath);
    System.out.println("target=" + targetPath);
    System.out.println(report.toTextReport());

    if(args.length >= 3) {
      Path reportPath = Paths.get(args[2]);
      Files.write(reportPath, report.toTextReport().getBytes(Charset.forName("UTF-8")));
      System.out.println("report_file=" + reportPath);
    }

    if(!report.structureConsistent) {
      throw new IllegalStateException("luc structure validation failed");
    }
  }
}

package unluac.chunk;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class Lua50AstPatchTool {

  public static void main(String[] args) throws Exception {
    if(args.length < 3) {
      System.out.println("Usage:");
      System.out.println("  java -cp build unluac.chunk.Lua50AstPatchTool <input.luc> <output.luc> <newText>");
      System.out.println("Effect:");
      System.out.println("  Patch first root string constant in-place; keep structure sizes/counts unchanged.");
      return;
    }

    Path input = Paths.get(args[0]);
    Path output = Paths.get(args[1]);
    String newText = args[2];

    byte[] original = Files.readAllBytes(input);
    byte[] patched = original.clone();

    Lua50AstPatcher patcher = new Lua50AstPatcher();
    LuaChunk chunk = patcher.parse(patched);

    final List<String> targets = new ArrayList<String>();
    patcher.patchStringConstant(
        patched,
        chunk,
        new Lua50AstPatcher.ConstantPredicate() {
          private boolean patchedOne;
          @Override
          public boolean matches(LuaChunk.Function function, int constantIndex, LuaChunk.Constant constant) {
            if(patchedOne) {
              return false;
            }
            if(!"root".equals(function.path)) {
              return false;
            }
            if(constant.stringValue == null) {
              return false;
            }
            byte[] body = constant.stringValue.bodyBytes();
            if(body.length < 4) {
              return false;
            }
            patchedOne = true;
            targets.add(function.path + "#" + constantIndex + " len=" + constant.stringValue.lengthField);
            return true;
          }
        },
        newText,
        Charset.forName(System.getProperty("unluac.stringCharset", "GBK"))
    );

    Files.write(output, patched);

    Lua50AstPatcher.PatchReport report = patcher.diff(original, patched, chunk);

    System.out.println("input=" + input);
    System.out.println("output=" + output);
    System.out.println("orig_size=" + original.length);
    System.out.println("patched_size=" + patched.length);
    System.out.println("target_constants=" + targets.size());
    for(String target : targets) {
      System.out.println("target=" + target);
    }
    System.out.println("diff_count=" + report.diffs.size());
    System.out.println("constant_area_diff_count=" + report.constantAreaChangeCount);
    System.out.println("non_constant_area_diff_count=" + report.nonConstantAreaChangeCount);
    System.out.println("only_constant_area_changed=" + report.onlyConstantAreaChanged());
    for(int i = 0; i < report.diffs.size(); i++) {
      Lua50AstPatcher.PatchDiff diff = report.diffs.get(i);
      System.out.println(String.format("diff[%d]=0x%08X %02X->%02X", i, diff.offset, diff.before, diff.after));
      if(i >= 127) {
        System.out.println("diff_truncated=true");
        break;
      }
    }

    if(!report.onlyConstantAreaChanged()) {
      throw new IllegalStateException("patch touched non-constant area");
    }
  }
}


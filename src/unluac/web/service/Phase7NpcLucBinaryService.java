package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;

import unluac.semantic.Phase7NpcLucBinaryExporter;
import unluac.web.request.Phase7NpcLucBinaryRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;

public final class Phase7NpcLucBinaryService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<String> execute(Phase7NpcLucBinaryRequest request) {
    Path workDir = null;
    PhaseResult<String> result = null;
    try {
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase7NpcLucBinary", workDir.toString());

      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      if(request.npcFileName == null || request.npcFileName.trim().isEmpty()) {
        throw new IllegalArgumentException("npcFileName is required");
      }

      Path inputLuc = PhasePathUtil.resolvePath(workDir, require(request.inputLuc, "inputLuc"));
      Path outputLuc = PhasePathUtil.resolvePath(workDir,
          request.outputLuc == null ? Paths.get("reports", request.npcFileName.replace(".lua", ".luc")) : request.outputLuc);
      PhasePathUtil.ensureParent(outputLuc);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;
      String stringCharset = request.stringCharset == null ? "GBK" : request.stringCharset;

      String[] args = new String[] {
          request.npcFileName,
          inputLuc.toString(),
          outputLuc.toString(),
          jdbcUrl,
          user,
          password,
          stringCharset
      };

      Phase7NpcLucBinaryExporter.main(args);

      PhasePathUtil.verifyFileExistsAndNotEmpty(outputLuc, "phase7NpcLucOutput");
      result.addArtifact("phase7NpcLucOutput", outputLuc.toString());
      return result.success(outputLuc.toString());
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase7NpcLucBinary", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }

  private Path require(Path value, String name) {
    if(value == null) {
      throw new IllegalArgumentException(name + " is required");
    }
    return value;
  }
}


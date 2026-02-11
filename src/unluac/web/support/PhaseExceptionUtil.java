package unluac.web.support;

import java.io.PrintWriter;
import java.io.StringWriter;
import unluac.web.result.PhaseError;

public final class PhaseExceptionUtil {

  private PhaseExceptionUtil() {
  }

  public static PhaseError toPhaseError(Throwable ex) {
    PhaseError error = new PhaseError();
    error.exceptionType = ex == null ? "java.lang.Exception" : ex.getClass().getName();
    error.message = ex == null ? "unknown error" : safe(ex.getMessage());
    error.stackTrace = buildStackTrace(ex);
    return error;
  }

  private static String safe(String value) {
    return value == null ? "" : value;
  }

  private static String buildStackTrace(Throwable ex) {
    if(ex == null) {
      return "";
    }
    StringWriter sw = new StringWriter();
    PrintWriter pw = new PrintWriter(sw);
    ex.printStackTrace(pw);
    pw.flush();
    return sw.toString();
  }
}


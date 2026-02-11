package unluac.web.result;

public final class WebApiError {

  public String exceptionType;
  public String message;

  public static WebApiError fromPhaseError(PhaseError error) {
    if(error == null) {
      return null;
    }
    WebApiError out = new WebApiError();
    out.exceptionType = error.exceptionType;
    out.message = error.message;
    return out;
  }

  public static WebApiError fromThrowable(Throwable ex) {
    if(ex == null) {
      return null;
    }
    WebApiError out = new WebApiError();
    out.exceptionType = ex.getClass().getName();
    out.message = ex.getMessage();
    return out;
  }
}


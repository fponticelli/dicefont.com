import api.*;
import thx.Url;

typedef State = {
  contents: SiteContents,
  main: View,
  baseDistUrl: Url
}

enum View {
  Loading;
  Page(data: Page);
  Error(e: ErrorKind);
}

enum ErrorKind {
  ContentNotFound(path: String);
  ServerError(e: String);
}

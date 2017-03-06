import api.*;

typedef State = {
  contents: SiteContents,
  main: View
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

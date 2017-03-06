import api.*;
import State;

enum Action {
  GoTo(slug: String);
  LoadPage(page: PageAbstract);
  PageLoaded(page: Page);
  NotifyError(err: ErrorKind);
}

enum Destination {
  Path;
  NotFound;
}

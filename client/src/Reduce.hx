using thx.Objects;

class Reduce {
  public static function reduce(state: State, action: Action): State {
    return switch action {
      case GoTo(_) | LoadPage(_):
        state;
      case PageLoaded(page):
        state.with(main, Page(page));
      case NotifyError(err):
        state.with(main, Error(err));
    };
  }
}

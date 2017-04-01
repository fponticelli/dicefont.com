import thx.stream.Reducer.Middleware;
import thx.stream.Reducer.Middleware.*;
import api.Rest;
import Action;
import State;
using thx.Arrays;
using thx.Functions;
using thx.Strings;
import Loc.msg;

class MW {
  var rest: Rest;
  public function new(rest: Rest) {
    this.rest = rest;
  }

  public function use(): Middleware<State, Action> {
    return empty() + loadContent + displayTitle + googleAnalytics();
  }

  public function displayTitle(state: State) {
    var title = switch state.main {
      case Loading: msg.tab_title_loading;
      case Page(data) if(data.name != "home"): format(msg.tab_title_page, [data.name.upperCaseFirst()]);
      case Page(data): msg.tab_home_title_page;
      case Error(ContentNotFound(_)): msg.tab_title_page_not_found;
      case Error(ServerError(_)): msg.tab_title_generic_error;
    };
    js.Browser.document.title = title;
  }

  static function format(template: String, values: Array<String>) {
    return values.reducei(function(template: String, word: String, i: Int) {
      return template.split('{$i}').join(word);
    }, template);
  }

  public function loadContent(state: State, action: Action, dispatch: Action -> Void) {
    switch action {
      case GoTo(url):
        url = url.trimCharsLeft("#/");
        if(url == "") {
          dispatch(LoadPage(state.contents.home));
        } else {
          switch state.contents.pages.findOption(function(page) return page.name == url) {
            case Some(page):
              trace("FOUND", page);
              dispatch(LoadPage(page));
            case None:
              trace("NOT FOUND", url);
              dispatch(NotifyError(ContentNotFound(url)));
          }
        }
      case LoadPage(page):
         rest.getPage(page)
          .success.fn(dispatch(PageLoaded(_)))
          .failure(function(err) {
            trace(err);
            dispatch(NotifyError(ContentNotFound(page.filename.toString())));
          });
      case _:
    }
  }

  public function googleAnalytics() {
    var curr = "";
    return function(state: State) {
      switch state.main {
        case Page(page) if(curr == page.name):
          curr = page.name;
          (untyped ga)('set', 'page', curr);
          (untyped ga)('send', 'pageview');
        case Error(err):
        case _:
      }
    }
  }
}

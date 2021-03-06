package view;

import doom.html.Html.*;
import State;
import Loc.msg;
import api.Group;
import thx.Url;

class App {
  public static function render(state: State) {
    return div([
      Header.render(state.contents, switch state.main { case Page(page): Some(page); case _: None; }),
      div(["class" => "page"], [
        renderMain(state.baseDistUrl, state.main, state.contents.groups)
      ]),
      Footer.render()
    ]);
  }

  static function renderMain(baseDistUrl: Url, main: View, groups: Array<Group>) return switch main {
    case Loading:
      div(["class" => "loading"], "...");
    case Page(data):
      PageView.render(baseDistUrl, data, groups);
    case Error(ContentNotFound(_)):
      div([h1(msg.error_page_not_found)]);
    case Error(ServerError(err)):
      div([h1(msg.error_generic), pre(err)]);
  }
}

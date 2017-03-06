import thx.stream.Property;
import thx.stream.Store;
import doom.html.Render;
import api.*;

class Client {
  public static function onContents(contents: SiteContents, api: Rest) {
    var state: State = {
      contents: contents,
      main: Loading
    };

    var prop = new Property(state);
    var middleware = new MW(api);

    var store = new Store(prop, Reduce.reduce, middleware.use());
    var render = new Render();
    render.stream(
      store.stream()
        .map(view.App.render),
      dots.Query.find('#main')
    );

    store.dispatch(GoTo(js.Browser.location.hash));

    js.Browser.window.onpopstate = function(e) {
      store.dispatch(GoTo(js.Browser.location.hash));
    };
  }

  public static function currentLocation() {
    trace(js.Browser.location.hash);
    return js.Browser.location.hash;
  }

  public static function main() {
    var api = new api.Rest();
    api.base.success(function(url) {
      trace(url);
      var link: js.html.LinkElement = cast js.Browser.document.createElement("link");
      link.rel = "stylesheet";
      link.href = '$url/dicefont/dicefont.css';
      js.Browser.document.head.appendChild(link);
    });
    api.getSiteContents()
      .success(onContents.bind(_, api))
      .failure(function(e) {
        trace("ERROR", e.toString());
      });
  }
}

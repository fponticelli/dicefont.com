import thx.stream.Property;
import thx.stream.Store;
import thx.Url;
import doom.html.Render;
import api.*;

class Client {
  public static function onContents(contents: SiteContents, baseDistUrl: Url, api: Rest) {
    var state: State = {
      contents: contents,
      main: Loading,
      baseDistUrl: baseDistUrl
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
    api.Rest.loadBase()
      .success(function(base: Url) {
        var api = new api.Rest(base);
        trace(base);
        var link: js.html.LinkElement = cast js.Browser.document.createElement("link");
        link.rel = "stylesheet";
        link.href = '$base/dicefont/dicefont.css';
        js.Browser.document.head.appendChild(link);
        api.getSiteContents()
          .success(onContents.bind(_, base, api))
          .failure(function(e) {
            trace("ERROR", e.toString());
          });
      })
      .failure(function(e) {
        trace("ERROR", e.toString());
      });
  }
}

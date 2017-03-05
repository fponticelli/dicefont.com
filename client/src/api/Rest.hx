package api;

import thx.Functions.*;
using thx.Functions;
import thx.Path;
import thx.Url;
using thx.promise.Promise;
using thx.http.Request;
using thx.http.RequestInfo;
using thx.schema.SimpleSchema;
using thx.schema.SchemaDynamicExtensions;

class Rest {
  var base: Promise<Url>;
  public function new() {
    base = loadBase();
    base.success(function(url) trace("BASE", url));
  }

  function loadBase()
    return Request.make(new RequestInfo(Get, "./config.json"), Json)
             .body.map(Url.fromString);

  public function getSiteContents(): Promise<SiteContents>
    return getContent("info", SiteContents.schema());

  public function getPage(page: PageAbstract): Promise<Page>
    return getText(page.filename)
      .map(function(content) {
        return new Page(page.name, page.filename, content);
      });

  function getText(path: Path): Promise<String> {
    return base.flatMap(function(base) {
      var url = base / path.asRelative();
      return Request.make(requestOne(url), Text).body;
    });
  }

  function getContent<T>(path: Path, schema: Schema<String, T>): Promise<T> {
    return base.flatMap(function(base) {
      var url = base / path.asRelative() + ".json";
      return getOne(url, schema);
    });
  }

  static function getOne<T>(url: Url, schema: Schema<String, T>): Promise<T>
    return Request.make(requestOne(url), Json)
      .body.flatMap(mapOneSchema(schema));

  static function requestOne(url: Url)
    return new RequestInfo(Get,url);

  static function mapOneSchema<T>(schema: Schema<String, T>): Dynamic -> Promise<T>
    return function(o: Dynamic): Promise<T> {
      return switch schema.parseDynamic(identity, o) {
        case Left(e):
          Promise.fail(e.toArray().map.fn(_.toString()).join("\n"));
        case Right(v):
          Promise.value(v);
      }
    };
}

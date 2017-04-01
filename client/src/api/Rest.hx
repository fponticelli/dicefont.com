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
  public var base(default, null): Url;
  var pages: Map<String, Promise<Page>>;
  public function new(base: Url) {
    pages = new Map();
    this.base = base;
    // base.success(function(url) trace("BASE", url));
  }

  public static function loadBase()
    return Request
              .make(new RequestInfo(Get, "./config.json"), Json)
              .body.map(Url.fromString);

  public function getSiteContents(): Promise<SiteContents>
    return getContent("info", SiteContents.schema());

  public function getPage(page: PageAbstract): Promise<Page> {
    if(!pages.exists(page.name)) {
      pages.set(page.name, getText(page.filename).map(function(content) {
        return new Page(page.name, page.filename, content);
      }));
    }
    return pages.get(page.name);
  }

  function getText(path: Path): Promise<String> {
    var url = base / path.asRelative();
    return Request.make(requestOne(url), Text).body;
  }

  function getContent<T>(path: Path, schema: Schema<String, T>): Promise<T> {
    var url = base / path.asRelative() + ".json";
    return getOne(url, schema);
  }

  static function getOne<T>(url: Url, schema: Schema<String, T>): Promise<T>
    return Request.make(requestOne(url), Json)
      .body.flatMap(mapOneSchema(schema));

  static function requestOne(url: Url)
    return new RequestInfo(Get, url);

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

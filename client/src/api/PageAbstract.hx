package api;

import thx.schema.SchemaF;
import thx.schema.SchemaDSL.*;
import thx.schema.SimpleSchema;
import thx.schema.SimpleSchema.*;

class PageAbstract {
  public var name(default, null): String;
  public var filename(default, null): String;

  public function new(name: String, filename: String) {
    this.name = name;
    this.filename = filename;
  }

  public function toString()
    return 'Page Abstract: $name';

  public static function schema<E>(): Schema<E, PageAbstract> return object(builder());
  public static function builder<E>(): ObjectBuilder<E, thx.Unit, PageAbstract> return ap2(
    PageAbstract.new,
    required("name", string(), function(x: PageAbstract) return x.name),
    required("filename",  string(), function(x: PageAbstract) return x.filename)
  );
}

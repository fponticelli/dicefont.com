package api;

import thx.schema.SchemaF;
import thx.schema.SchemaDSL.*;
import thx.schema.SimpleSchema;
import thx.schema.SimpleSchema.*;

class Page {
  public var name(default, null): String;
  public var filename(default, null): String;
  public var content(default, null): String;

  public function new(name: String, filename: String, content: String) {
    this.name = name;
    this.filename = filename;
    this.content = content;
  }

  public function toString()
    return 'Page: $name';

  public static function schema<E>(): Schema<E, Page> return object(builder());
  public static function builder<E>(): ObjectBuilder<E, thx.Unit, Page> return ap3(
    Page.new,
    required("name",     string(), function(x: Page) return x.name),
    required("filename", string(), function(x: Page) return x.filename),
    required("content",  string(), function(x: Page) return x.content)
  );
}

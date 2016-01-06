## Introduction

Classes should use their private methods. Otherwise this is dead
code which is confusing and bad for maintenance.

The `Unused Private Method` detector reports unused private instance
methods and instance methods only - class methods are ignored.

## Example

Given:

```Ruby
class Car
  private
  def drive; end
  def start; end
end
```

`Reek` would emit the following warning:

```
2 warnings:
  [3]:Car has the unused private instance method `drive` (UnusedPrivateMethod)
  [4]:Car has the unused private instance method `start` (UnusedPrivateMethod)
```

## Configuration

`Unused Private Method` offers the [Basic Smell Options](Basic-Smell-Options.md).

Private methods that are called via dynamic dispatch
will trigger a false alarm since detecting something like this is far out of
scope for `Reek`. In this case you can disable this detector via the `exclude`
configuration option (which is part of the [Basic Smell Options](Basic-Smell-Options.md))
for instance like this (an example from `Reek's` own codebase):

```Ruby
# :reek:UnusedPrivateMethod: { exclude: [ !ruby/regexp /process_/ ] }
class ContextBuilder
  def process_begin
    # ....
  end
end
```

Note that disabling this detector via comment works on a `class` scope, not
a method scope (like you can see above).

## Known limitations

* Method calls via dynamic dispatch (e.g. via `send`) is something `Reek` (or any other
  static tool for that matter) can not detect. You should whitelist those methods.
* `Reek` works on a per-file base. This means that using something like the [template pattern](https://en.wikipedia.org/wiki/Template_method_pattern)
  will trigger this detector by mistake. Right now you have to whitelist the
  methods in question as well unfortunately.


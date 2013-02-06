Description
===========

Smackage cookbook

Requirements
============
-

Attributes
==========

```ruby
default["smackage"] = {
  "dir" => nil,
  "smlnj_config_path" => nil
}
```

Usage
=====
Example role:

```ruby
name "smackage"
description "smackage"

run_list(
  "recipe[smackage::default]"
)

default_attributes( {
  "smackage" => {
    "dir" => File.join(ENV['HOME'], 'projects/smackage'),
    "smlnj_config_path" => File.join(ENV['HOME'], '.smlnj-pathconfig')
  }
} )
```

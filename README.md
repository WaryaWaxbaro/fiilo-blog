# fiilo-blog

Fiilo Blog is a blog project that is done for learning purposes, to strengthen Ruby on Rails understanding and use to create own blogs.

## UUID as an ID

The project uses uuid as primary id
Here is a link that shows how to set the uuid
Using UUIDs to your new Rails 6 application [ITNEXT](https://itnext.io/using-uuids-to-your-rails-6-application-6438f4eeafdf).

### Summary of the blog

- Create migration `rails g migration enable_uuid`
- Add _enable_extension 'pgcrypto'_ to the migration file as shown below

```
# config/db/migrate/enable_uuid.rb
class EnableUuid < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
  end
end
```

- Set UUID as a default Primary key. Create generators.rb file if does not already exist and then the below code.

```
# config/initializers/generators.rb
Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end
```

- Ordering records
  By default Activerecord sorts using primary key. Since the primary id's are UUID the records sorting will not be consistent. The oldest record might be the first or the last record might be first record.
  This issue can be solve by adding application_record.rb file `self.implicit_order_column = :created_at`

```
# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Sort records by date of creation instead of primary key
  self.implicit_order_column = :created_at
end
```

# fiilo-blog

Fiilo Blog is a blog project that is done for learning purposes, to strengthen Ruby on Rails understanding and use to create own blogs.

## UUID as an ID

The project uses uuid as primary id
Here is a link that shows how to set the uuid
Using UUIDs to your new Rails 6 application [ITNEXT](https://itnext.io/using-uuids-to-your-rails-6-application-6438f4eeafdf).

### Installation summary

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

## Authentication

Fiilo Blog uses _devise gem_ to authenticate users.
heartcombo/devise [GitHub](https://github.com/heartcombo/devise).

### Installation summary

- Add `gem 'devise'` to gemfile and run `bundle install`
- Run the generator `rails generate devise:install` and then follow the instructions
- Add the below line to `config/environments/development.rb` as shown below
  `config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }`
- Generate user model

```
rails generate devise User
```

- To authenticate controller actions add

```
before_action :authenticate_user!
```

- To verify if a user is signed in, use the following helper:
  `user_signed_in?`

- For the current signed-in user, this helper is available:
  `current_user`

- You can access the session for this scope:
  `user_session`

## Testing

The project uses `rspec-rails` for testing. [Rspec-rails](https://github.com/rspec/rspec-rails).

### Installation summary

- Add `rspec-rails` to both the `:development` and `:test `groups of your app’s Gemfile as shown below and run bundle install

```
group :development, :test do
  gem 'rspec-rails', '~> 5.0.0'
end
```

## File attachment with Active storage

- The project will use Amazon S3 or Cloudinary in production but in development the project uses local

- For more info about Active storage visit [Active storage overview](https://edgeguides.rubyonrails.org/active_storage_overview.html).

### Summary installation

- Uncomment or add `gem "image_processing", ">= 1.2"` in the gemfile
- Run `rails active_storage:install` command
- Fiilo blog project is using UUID as a primary Id. In order for Active storage to work well we need to modify active migration file to use UUID as primary id. Check the projects `db/migrate/20210810170024_create_active_storage_tables.active_storage.rb`
- After that run `bin/rails db:migrate` command
- After that add a attachment specification in the model

```
class Photo < ApplicationRecord
  has_one_attached :blog_photo
end
```

## WYSIWYG editor (Action text)

- For more info about Active text visit [Action Text Overview](https://edgeguides.rubyonrails.org/action_text_overview.html).

### Summary installation

- `rails action_text:install`
- For UUID, The generated migration for ActionText will also need to be updated to specify type: :uuid for the :record references line.

```
t.references :record, null: false, polymorphic: true, index: false, type: :uuid
```

## Bootstrap 5

- Fiilo blog project is using bootstrap.

### Summary installation

- If using yarn run in the terminal of the project folder

```
yarn add bootstrap
yarn add @popperjs/core

// npm
npm install bootstrap
npm install @popperjs/core
```

- After adding the packages successfully the package.json file should have something like this

```
  "dependencies": {
    "@popperjs/core": "^2.9.3",
    ....
    "bootstrap": "^5.1.0",
  },
```

- Create `application.scss` file in `/javascript/stylesheets/application.scss`
- After creating the file import bootstrap to the file as shown below

```
// javascript/stylesheets/application.scss

// Bootstrap
@import "bootstrap";
```

- Also import bootstrap and the `application.scss` created above to `/javascript/packs/application.js` as shown below

```
// Bootstrap
import "bootstrap"
import "../stylesheets/application"
```

- To test if the installation was fully succesful use bootstrap classes or just add modal example from bootstrap website

## Fontawesome icons

- To install run `yarn add @fortawesome/fontawesome-free` or `npm install --save @fortawesome/fontawesome-free`
- Add `import "@fortawesome/fontawesome-free/js/all";` to `/javascript/packs/application.js`

# Add tags to the Posts

```
rails generate model tag name

rails generate model tagging tag:belongs_to post:belongs_to

class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings
end


```

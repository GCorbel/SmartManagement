# Smart Management

The main goal of this tool is to give a powerful administration tool for a
Rails application. It is simple to use and highly customisable.

## Installation

Add it to your Gemfile :

```ruby
gem 'smart_management'
```

You have to include those dependencies in `application.js` :

```coffee
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require twitter/bootstrap
//= require underscore
//= require angular
//= require smart_table
//= require smart_management
```

And you have to add this in `application.css` :
```css
 *= require bootstrap_and_overrides
```

You also have to download Smart-Table with this command :
```
wget https://raw.githubusercontent.com/lorenzofox3/Smart-Table/master/dist/smart-table.js -O app/assets/javascripts/smart-table.js
```

Finally, you have to generate the simple_form installation with this command :
```
rails g simple_form:install --bootstrap
```

## How to use

Now, you can create a new controller, as you do in a normal Rails application.
You can use SmartManagement by including `SmartMangement::ControllerScaffold`
like in this example :

```ruby
class PluralModelNameController < ApplicationController
  include SmartManagement::ControllerScaffold
end
```

## Customize the list

To customize the list of records, you can simple override the `table` partial
by creating a file called `app/views/plural_model_name/_table.html.erb`. You
can find the one used by SmartManagement
[here](https://github.com/GCorbel/smart_management/blob/master/app/views/smart_management/_table.html.erb). You can just do a copy/paste in your new file.


## Customize the form

You can customize the form by creating a file called `app/views/plural_model_name/_form.html.erb`. You can find the default form [here](https://github.com/GCorbel/smart_management/blob/master/app/views/smart_management/_form.html.erb).

You can also add fields at the bottom of the default form like this :

```ruby
  <%= render layout: 'smart_management/form' do |f| %>
    <%= f.input :custom_field %>
  <% end %>
```

## Customize the data returned by the index

To customize the data returned by `/plural_model_name.json` you can create a
helper called `PluralModelNameHelper` and create a method called
`json_options`. For example :

```ruby
module PluralModelNameHelper
  def json_options
    { include: [:groups] }
  end
end
```

In additions, you should also customize the scope of the query. You can do this
by creating a function called `scope` in your helper. You helper have to be
like this :

```ruby
module PluralModelNameHelper
  def scope
    PluralModelName.includes(:groups)
  end

  def json_options
    { include: [:groups] }
  end
end
```

## Customize the controller

You can override methods of the module
[here](https://github.com/GCorbel/smart_management/blob/master/lib/smart_management/controller_scaffold.rb).
For example, if you want to send an email after the creation a new model, you
can create a controller like this :

```ruby
class PluralModelNameController < ApplicationController
  include SmartManagement::ControllerScaffold

  def create
    if resource.save
      PluralModelNameMailer.welcome_email(resource).deliver_later
    else
      render :new
    end
  end
end
```

SmartManagement is using [responders](https://github.com/plataformatec/responders) and [decent_exposure](https://github.com/hashrocket/decent_exposure).
You can go on their Github pages to know how it works.

## Host the application another host

To be more efficient, and to don't have performance impact on the client app,
you can host your app another host, like Heroku. You just have to copy models
and `schema.rb`. You can change the file `database.yml` to give the information
of database you want to be connected.

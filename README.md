A simple Rails view presenter for those with discerning taste.  
_From the Library of Knowledge and Power_

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lokap-presenter'
```

## Usage

Call the presenter within your view using the `present` helper:

```ruby
present(object, :class_name).render('template')
```

Your Presenter will be searched for in:

```
app/presenters/<class_name>_presenter.rb
```

Templates will be searched for in:

```
app/views/presenters/<class_name>/_default.html.erb
app/views/presenters/<class_name>/_<template>.html.erb
```

And can be used like so:

```ruby
present(@person, :emotion).render
# => app/presenters/emotion_presenter.rb
# => app/views/presenters/emotion/_default.html.erb

present(@person, :emotion).render(:happy)
# => app/presenters/emotion_presenter.rb
# => app/views/presenters/emotion/_happy.html.erb

present(@person, :emotion).render(:sad)
# => app/presenters/emotion_presenter.rb
# => app/views/presenters/emotion/_sad.html.erb
```

Access the presenter inside your presenter templates:

```ruby
presenter.show_emotion
p.show_emotion
```

### The Presenter Class

The class has full access to the view... and view helpers, etc.  
_Think of this as a helper on steroids (but less angry)_

```ruby
class EmotionPresenter < Lokap::Presenter
  presents :person
  delegate :emotions, :moods, to: :human

  def who_is_this
    person
  end

  def show_emotion
    emotions.logic
  end

  def show_mood
    moods.logic
  end
end
```

### Default Templates

If a specified template is not found, the presenter will attempt to render a
default view.

```ruby
present(@person, :share).render(:twitter)

# looks for /views/presenters/share/_twitter.html.erb (doesn't exist)
# => /views/presenters/share/_default.html.erb
```

This will also work for templates inside subfolders:

```ruby
present(@person, :share).render('social/twitter')

# looks for /views/presenters/share/social/_twitter.html.erb (doesn't exist)
# => /views/presenters/share/social/_default.html.erb
```

## Examples

Here are a few different ways to utilize presenters:

```ruby
# Render (Default)
present(@person, :share).render
present(@person, :share).render(:twitter)
present(@person, :share).render('social/twitter')

# Block
present(@person, :share) do |p|
  link_to p.text, p.url
end

# Object
share = present(@person, :share)
share.render(:twitter)
share.render(:facebook)
share.render(:email)
```



# frozen_string_literal: true

if defined?(ActiveSupport.on_load)
  ActiveSupport.on_load(:action_view) do
    require_relative 'presenter/ext/action_view'
  end
end

module Lokap
  #
  # `Lokap::Presenter` is the base class for which all presenters inherit
  #
  # @attribute context
  #   @return [ActionView] Rails view context
  # @attribute options
  #   @return [Hash] Options passed to the presenter and the template
  #
  class Presenter < SimpleDelegator
    attr_reader   :context
    attr_accessor :options

    # Creates a new `Lokap::Presenter` object
    # @see Lokap::ActionView#present
    #
    # @example
    #   present(@person, :share).render
    #   present(@person, :share).render(:twitter)
    #   present(@person, :share).render('social/twitter')
    #
    # @param entity [Object] Object/entity to present
    # @param context [ActionView::Context] Rails view context for rendering
    # @param options [Hash] Options passed to the presenter and template
    #
    # @return [Lokap::Presenter]
    def initialize(entity, context, options={})
      @entity  = entity
      @context = context
      @options = options

      super(@context)
    end

    # Renders the specified template for a presenter
    # @param partial [String|Symbol] The name of the partial in `app/views/presenters`
    # @return [String] HTML output
    def render(partial=nil)
      super partial_options(partial)
    rescue Lokap::ActionView::MissingTemplate
      super partial_options(default_path(partial))
    end

    private

    # Defines a method to access the presented entity
    # @param name [String|Symbol] Name of the entity
    def self.presents(name)
      define_method(name) { @entity }
    end

    # Makes the presenter available to it's templates via `p.<method>` or
    # `presenter.<method>`
    def locals
      { presenter: self, p: self }.merge(options)
    end

    # Generate Hash options to pass to the renderer
    # @param partial [String] path to the template's partial
    # @return [Hash] These options are passed to `render :partial, <options>`
    def partial_options(partial=nil)
      {
        partial: template_path(partial),
        locals:  locals
      }
    end

    # The full path of the template to be rendered
    # @param partial [String] The name of the partial to render
    # @return [String] Full path to the template's partial
    def template_path(partial=nil)
      template = partial || default_template
      "#{class_path}/#{template}".downcase
    end

    # Generates the name for the class segment of the path
    # @note Removes `_presenter` from the resulting string if present
    # @return [String] Path for the subclassed presenter
    def class_path
      self.class.name.underscore.gsub('_presenter', '').gsub('/presenter', '')
    end

    # Generates the default partial path when a template is not found or specified
    # @param partial [String] full path to the template's partial
    # @returns [String] full path to the specified template or the default template
    def default_path(partial=nil)
      return unless partial
      prefix = partial.to_s.split('/')[0..-2].join('/')
      [prefix, default_template].compact.join('/')
    end

    # The default name for the template when specified template can't be found
    def default_template
      'default'
    end
  end
end

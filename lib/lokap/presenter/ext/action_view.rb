module Lokap
  module ActionView
    # Raised when `ActionView::Context` can't locate a presenter's template  
    # _(We catch the error and attempt to render a default template)_
    class MissingTemplate < ::ActionView::MissingTemplate; end

    # Helper method which allows access to your presenters
    #
    # @example
    #   present(@person, :share).render
    #   present(@person, :share).render(:twitter)
    #   present(@person, :share).render('social/twitter')
    #
    # @param entity [Object] The object to present
    # @param klass [Object] The underscored class name of your presenter
    # @param options [Hash] Passed to the presenter (and template)
    #
    # @return [Lokap::Presenter] an instance of your presenter
    def present(entity, klass = nil, options={})
      base_klass = klass ? klass.to_s.titleize.gsub(' ', '') : entity.class
      klass = "#{base_klass}Presenter".constantize
      presenter = klass.new(entity, self, options)
      yield presenter and return if block_given?
      presenter
    end
  end
end

ActionView::Base.send(:include, Lokap::ActionView)

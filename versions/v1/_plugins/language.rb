module Jekyll
  class LanguageBlock < Liquid::Block
    attr_accessor :language, :module

    def initialize(name, params, tokens)
      super
      @language = params[0]
    end

    def unknown_tag(name, params, tokens)
      if name == "example"
        handle_link_tag(params)
      else
        super
      end
    end

    def handle_link_tag(params)
      print(params)
    end

    def render(context)
      context.environments.first["page"]["language"]
    end

  end
end

# Liquid::Template.register_tag('language', Jekyll::LanguageBlock)
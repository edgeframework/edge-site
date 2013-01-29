module Jekyll
  class ExampleTag < Liquid::Tag
    attr_accessor :path

    def initialize(tag_name, path, tokens)
      super
      @path = path
    end

    def render(context)
      language = context["page"]["language"]["name"]

      partial = Liquid::Template.parse("{% include #{language}/#{@path} %}")
      partial.render(context)
    end
  end
end

Liquid::Template.register_tag('example', Jekyll::ExampleTag)
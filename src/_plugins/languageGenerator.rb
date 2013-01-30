module Jekyll

  class LanguagePage < Page
    def initialize(site, base, dir, language, page)
      @site = site
      @base = base
      @dir = dir
      @name = "#{page}.md"

      puts "Generating Page: #{@dir}/#{@name}"

      self.process(@name)
      self.read_yaml(File.join(base, '_learn_pages'), @name)
      self.data['language'] = language

      language_title_prefix = site.config['language_title_prefix'] || 'Language: '
      self.data['title'] = "#{language_title_prefix}#{language}"
    end
  end

  class LanguagePageGenerator < Generator
    safe true

    def generate(site)
      pages = site.config['learn_pages'] || [ 'index' ]
      languages = site.config['languages'] || [ 'java' ]

      languages.each do |language|
        dir = File.join('guides', language['name'])
        puts("#{dir}")

        pages.each do | page |
          site.pages << LanguagePage.new(site, site.source, dir, language, page)
        end
      end
    end
  end

end
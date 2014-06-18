module ApplicationHelper
  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

  def render_md(text)
    @@markdown.render(text).html_safe
  end
  
  def script_exists?(script)    
    script = "#{Rails.root}/app/assets/javascripts/#{params[:controller]}.js"
    available_extensions = %w[.coffee .erb .coffee.erb] + [""]
    available_extensions.inject(false) do |truth, extension|
      truth || File.exists?("#{script}#{extension}")
    end
  end

  def stylesheet_exists?(stylesheet)
    stylesheet = "#{Rails.root}/app/assets/stylesheets/#{params[:controller]}.css"
    available_extensions = %w[.sass .scss] + [""]
    available_extensions.inject(false) do |truth, extension|
      truth || File.exists?("#{stylesheet}#{extension}")
    end
  end
end

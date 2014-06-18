require 'render_anywhere'

class ViewDecorator < Draper::Decorator
  include RenderAnywhere

  def render_template(template)
    render template: template, 
           layout: false
  end

  def method_missing(method, *args, &block) 
    class_name = self.class.to_s.downcase
    class_name.slice!('decorator')
    template = "layouts/#{class_name}_#{method}"

    render template: template, layout: false
  end


end

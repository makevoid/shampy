module MarkupUtils
  def markup(file)
    text = File.read "#{PATH}/texts/#{file}.txtl"
    content = RedCloth.new(text).to_html
    haml_tag :div, { class: file } do
      haml_concat content
    end
  end
end
path = File.expand_path "../../", __FILE__

mod = "auth"

if defined?(DataMapper)
  require_all "#{path}/exts/#{mod}/models"
end

LOAD_MODULES_ROUTES = lambda do
  class Shampy < Sinatra::Base
    @@mod = "auth"

    def haml_mod(view, options={})
      haml "../exts/#{@@mod}/views/#{view}".to_sym, options
    end

    def partial_mod(name, value={})
      haml_mod "_#{name}".to_sym, locals: extract_locals(name, value)
    end
  end

  require_all "#{path}/exts/#{mod}/routes"
end
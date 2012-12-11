module RenderedCsv
  class Railtie < Rails::Railtie
    initializer "rendered_csv.action_controller" do
    ActiveSupport.on_load(:action_controller) do
      include RenderedCsv::Controller # ActiveSupport::Concern
    end
  end
end

require 'model_params'
require 'rails'

module ModelParams
  class Railtie < Rails::Railtie

    # configure our plugin on boot. other extension points such
    # as configuration, rake tasks, etc, are also available
    initializer "model_params.initialize" do |app|
      
      initial_ctime = 0

      # subscribe to all rails notifications: controllers, AR, etc.
      ActiveSupport::Notifications.subscribe("sql.active_record") do |*args|        
        event = ActiveSupport::Notifications::Event.new(*args)
       
        schema_path = Rails.root.to_s + '/db/schema.rb'
        new_ctime = File.ctime(schema_path).to_i

        if new_ctime != initial_ctime && initial_ctime != 0      
          initial_ctime = new_ctime
          ChangeModel.new.add_attr_desc_to_models              
        end

        initial_ctime = new_ctime
      end
    end
  end
end
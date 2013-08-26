module ModelParams

  class ChangeModel

    def get_models         
      Rails.application.eager_load!
      all_models = ActiveRecord::Base.descendants

      models_hash = {}
      models_attributes = {}


      all_models.each do |model|        
        next if model.name.include?("::")        
        model.columns_hash.each do |attribute, details|         
          models_attributes[attribute] = details.type          
        end                
        models_hash[model.name] = models_attributes.to_s
        models_attributes = {}
      end

      models_hash
    end

    def add_attr_desc_to_models
      models = get_models
    end
  end
end
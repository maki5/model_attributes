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
          models_attributes[attribute] = details.type.to_s          
        end                
        models_hash[model.name] = models_attributes
        models_attributes = {}
      end

      models_hash
    end

    def create_desc_for_models
      models = get_models
      
      models.each do |key, value|       
        str = ""      
        value.each do |attribute, type|          
          str+= "# :" + attribute + " => " + type + "\n"          
        end        

        str.insert(0, "#" * 10 + " #{key}" + " Attributes " + "#" * 17 + "\n")
        str.insert(str.length, "#" * 20 + " End of Attributes " + "#" * 10 + "\n" + "\n")
        
        models[key] = str
      end
      models
    end

    def models_path(models_names)
      paths = {}

      models_names.each do |name|
        file_name = ""

        name.split("").each_with_index do |n, index|          
          if n == n.upcase && index != 0 && index + 1 != name.length 
            file_name += "_" + n.downcase
          elsif n == n.upcase
            file_name += n.downcase
          else
            file_name += n
          end
        end
        paths[name] = Rails.root.join('app/models/').join(file_name + ".rb")
      end

      paths
    end

    def insert_desc_to_model(path, desc, model)      
      has_desc = false
      end_of_desc = false
      valid_line = true
      new_content = ""
      old_content = ""

      File.open(path, "r") do |file|        
        file.each do |line|
          old_content += line
          
          if line.include?("#" * 10 + " #{model}" + " Attributes " + "#" * 17) 
            has_desc = true          
          elsif line.include?("#" * 20 + " End of Attributes " + "#" * 10)
            has_desc = true
            end_of_desc = true
            valid_line = false
          end

          if !has_desc || (has_desc && end_of_desc && valid_line)
            new_content += line            
          end
          valid_line = true
        end
        new_content.insert(0, desc)        
      end

      if old_content != new_content
        File.open(path, "w+") do |file|
          file.write(new_content)
        end
      end
      
    end

    def add_attr_desc_to_models      
      models_with_desc = create_desc_for_models

      paths = models_path(models_with_desc.keys)

      paths.each do |k,v|
        insert_desc_to_model(v, models_with_desc[k], k)
      end

    end

  end
end
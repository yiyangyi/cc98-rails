module Mongoid
  module CounterCache
  	module ClassMethods
  	  def counter_cache(meta_data)
  	  	counter_name = "#{meta_data[:inverse_of]}_count"

  	  	set_callback(:create, :after) do |document|
  	  	  relation = document.send(meta_data[:name])

  	  	  if relation
  	  	  	relation.inc(counter_name.to_sym => 1) if relation.class.fields.keys.include?(counter_name)
  	  	  end
  	  	end

  	  	set_callback(:destroy, :after) do |document|
  	  	  relation = document.send(meta_data[:name])

  	  	  if relation && relation.class.fields.keys.include?(counter_name)
  	  	  	relation.inc(counter_name.to_sym => -1)
  	  	  end
  	  	end
  	  end
  	end
  end
end 
module ServicesHelper

  def request_business(user)
    user.services.collect do |ele| 
      if ele.expense.nil? 
        ""
      else
        link_to ele.name, "javascript:void(0);" 
      end
    end.join('').html_safe
  end

  def countries(service)
    country_ids = service.country_ids
    Country.cache_list.map do |c|
      if country_ids.include? c.id
        link_to c.name, if service.instance_of? RequestVisa
          country_request_visas_path(c.id)
        else
          country_request_schools_path(c.id)
        end
      end
    end.join('').html_safe
  end

end

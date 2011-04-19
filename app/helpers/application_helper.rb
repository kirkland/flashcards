module ApplicationHelper
  def js_init
    google_analytics_init
  end

  def google_analytics_init
    "var _gaq = _gaq || [];_gaq.push(['_setAccount', 'UA-20647561-2']);_gaq.push(['_trackPageview']);" 
  end

  def js_dom_loaded
    js_ga_load
  end

  def js_ga_load
    "gaLoad();"
  end

  def js_after_yield
  end
end

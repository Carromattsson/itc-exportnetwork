class Crawler
  def base_url
    "http://www.trademap.org/"
  end

  def headers
    {"Cookie" => "ASP.NET_SessionId=hi2a3tuhtcx5pq333bv13n55; trademap.org=99D44A131B99051B5BACBE16C429D5508A7C48E2194335B9FE53670CE69612CDA2FFD5C177C62CA15AD8F27D464049FC4F86A2E51360C7032CD08BC85FCA49B11CF41AEEE3054708DDF1FF6EEF9A1D002A1BA2D2C564274DD3CB39A9CD11A4CCFDFE91253238C52AF4410DE5ABA0F2B1758BFA9881558199A37E5B3BCF5B9974BE3CA8371563BF07E9CEC3ADD2461AEBE03CE84F", "Content-Type" => "application/json; charset=utf-8"}
  end

  # Why the below function exists.
  # <html>
  #   <body>
  #     <select id="ctl00_NavigationContent_NavControl_DropDownList_Partner">
  #       <option value=282>Algeria</option>
  #       <option value=128>Andorra</option>
  #       <option value=024>Angola</option>
  #     </select>
  #   </body>
  # </html>
  def get_countries_selector
    "select#ctl00_NavigationContent_NavControl_DropDownList_Partner option"
  end

  def get_countries_options
    {"ctl00$PageContent$GridViewPanelControl$HiddenField_Prev_PageSizeTab" => 300}
  end

  def get_countries
    Hash[client_get("Country_SelProduct_TS.aspx", get_countries_options).search(get_countries_selector).map do |country_option|
      [country_option.children.first.text, country_option.attributes.value.value]
    end]
  end

  def client_get(path, options={})
    Nokogiri.parse(
      RestClient::Request.execute(
       :method => :get,
       :url => base_url+path+"?"+options.parameterize,
       :headers => headers
      )
    )
  end

####NON ESSENTIAL IS BELOW.
  def get_selection_menu(country)
  end

  def client_post(path, options={})
    Nokogiri.parse(
      RestClient::Request.execute(
        method: :post, url: base_url+path, payload: options, headers: {"Cookie" => "ASP.NET_SessionId=hi2a3tuhtcx5pq333bv13n55; trademap.org=99D44A131B99051B5BACBE16C429D5508A7C48E2194335B9FE53670CE69612CDA2FFD5C177C62CA15AD8F27D464049FC4F86A2E51360C7032CD08BC85FCA49B11CF41AEEE3054708DDF1FF6EEF9A1D002A1BA2D2C564274DD3CB39A9CD11A4CCFDFE91253238C52AF4410DE5ABA0F2B1758BFA9881558199A37E5B3BCF5B9974BE3CA8371563BF07E9CEC3ADD2461AEBE03CE84F"}
      )
    )
  end



end
